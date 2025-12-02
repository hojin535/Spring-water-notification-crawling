"""
데이터베이스 설정 및 연결 (SSH 터널링 지원)
"""
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import paramiko
# Compatibility shim for newer paramiko versions that removed DSSKey
if not hasattr(paramiko, "DSSKey"):
    # Fallback to RSAKey for DSA key handling (most SSH servers accept RSA)
    paramiko.DSSKey = paramiko.RSAKey
from sshtunnel import SSHTunnelForwarder
import os
from dotenv import load_dotenv
import logging

logger = logging.getLogger(__name__)

# 환경 변수 로드
load_dotenv()

# SSH 터널 설정
USE_SSH_TUNNEL = os.getenv("USE_SSH_TUNNEL", "false").lower() == "true"
SSH_HOST = os.getenv("SSH_HOST", "")
SSH_PORT = int(os.getenv("SSH_PORT", "22"))
SSH_USER = os.getenv("SSH_USER", "")
SSH_PASSWORD = os.getenv("SSH_PASSWORD", "")
SSH_KEY_PATH = os.getenv("SSH_KEY_PATH", "")  # SSH 키 파일 경로 (선택)

# MySQL 연결 설정
MYSQL_USER = os.getenv("MYSQL_USER", "root")
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD", "")
MYSQL_HOST = os.getenv("MYSQL_HOST", "localhost")
MYSQL_PORT = int(os.getenv("MYSQL_PORT", "3306"))
MYSQL_DATABASE = os.getenv("MYSQL_DATABASE", "mcee_violations")

# SSH 터널 인스턴스 (글로벌)
ssh_tunnel = None


def start_ssh_tunnel():
    """SSH 터널 시작"""
    global ssh_tunnel
    
    if not USE_SSH_TUNNEL:
        logger.info("SSH tunnel is disabled")
        return None
    
    if ssh_tunnel is not None and ssh_tunnel.is_active:
        logger.info("SSH tunnel is already active")
        return ssh_tunnel
    
    try:
        logger.info(f"Starting SSH tunnel to {SSH_HOST}:{SSH_PORT}...")
        
        # SSH 인증 방법 결정
        ssh_auth = {}
        if SSH_KEY_PATH and os.path.exists(SSH_KEY_PATH):
            # SSH 키 사용
            ssh_auth['ssh_pkey'] = SSH_KEY_PATH
            logger.info(f"Using SSH key: {SSH_KEY_PATH}")
        elif SSH_PASSWORD:
            # 비밀번호 사용
            ssh_auth['ssh_password'] = SSH_PASSWORD
            logger.info("Using SSH password authentication")
        else:
            raise ValueError("SSH_PASSWORD or SSH_KEY_PATH must be provided when USE_SSH_TUNNEL=true")
        
        # SSH 터널 생성
        ssh_tunnel = SSHTunnelForwarder(
            (SSH_HOST, SSH_PORT),
            ssh_username=SSH_USER,
            **ssh_auth,
            remote_bind_address=(MYSQL_HOST, MYSQL_PORT),
            local_bind_address=('127.0.0.1', 0)  # 0 = 자동으로 사용 가능한 포트 선택
        )
        
        ssh_tunnel.start()
        logger.info(f"SSH tunnel started successfully. Local port: {ssh_tunnel.local_bind_port}")
        
        return ssh_tunnel
        
    except Exception as e:
        logger.error(f"Failed to start SSH tunnel: {e}", exc_info=True)
        raise


def stop_ssh_tunnel():
    """SSH 터널 종료"""
    global ssh_tunnel
    
    if ssh_tunnel is not None and ssh_tunnel.is_active:
        logger.info("Stopping SSH tunnel...")
        ssh_tunnel.stop()
        ssh_tunnel = None
        logger.info("SSH tunnel stopped")


def get_database_url():
    """데이터베이스 연결 URL 생성"""
    if USE_SSH_TUNNEL and ssh_tunnel and ssh_tunnel.is_active:
        # SSH 터널 사용 시 로컬 포트로 연결
        host = '127.0.0.1'
        port = ssh_tunnel.local_bind_port
        logger.info(f"Using SSH tunnel connection: {host}:{port}")
    else:
        # 직접 연결
        host = MYSQL_HOST
        port = MYSQL_PORT
        logger.info(f"Using direct connection: {host}:{port}")
    
    return (
        f"mysql+pymysql://{MYSQL_USER}:{MYSQL_PASSWORD}"
        f"@{host}:{port}/{MYSQL_DATABASE}"
        f"?charset=utf8mb4"
    )


# SSH 터널 시작 (필요한 경우)
if USE_SSH_TUNNEL:
    start_ssh_tunnel()

# MySQL 연결 URL
SQLALCHEMY_DATABASE_URL = get_database_url()

# 엔진 생성
engine = create_engine(
    SQLALCHEMY_DATABASE_URL,
    pool_pre_ping=True,  # 연결 유효성 검사
    pool_recycle=3600,   # 1시간마다 연결 재생성
    echo=False  # SQL 쿼리 로깅 (개발 시 True로 설정)
)

# 세션 팩토리
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base 클래스
Base = declarative_base()


def get_db():
    """
    데이터베이스 세션 생성
    
    사용 예:
        db = next(get_db())
        try:
            # DB 작업
        finally:
            db.close()
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def init_db():
    """
    데이터베이스 및 테이블 초기화
    """
    Base.metadata.create_all(bind=engine)
