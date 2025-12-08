"""
Database configuration and connection
"""
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os
from dotenv import load_dotenv
import logging

logger = logging.getLogger(__name__)

# 환경 변수 로드
load_dotenv()

# MySQL 연결 설정
MYSQL_USER = os.getenv("MYSQL_USER", "root")
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD", "")
MYSQL_HOST = os.getenv("MYSQL_HOST", "localhost")
MYSQL_PORT = int(os.getenv("MYSQL_PORT", "3306"))
MYSQL_DATABASE = os.getenv("MYSQL_DATABASE", "mcee_violations")

# SSH 터널링 설정
USE_SSH_TUNNEL = os.getenv("USE_SSH_TUNNEL", "false").lower() == "true"
SSH_HOST = os.getenv("SSH_HOST", "")
SSH_PORT = int(os.getenv("SSH_PORT", "22"))
SSH_USER = os.getenv("SSH_USER", "")
SSH_PASSWORD = os.getenv("SSH_PASSWORD", "")
SSH_KEY_PATH = os.getenv("SSH_KEY_PATH", "")

# SSH 터널 객체 (전역)
ssh_tunnel = None


def get_database_url():
    """데이터베이스 연결 URL 생성 (SSH 터널링 지원)"""
    global ssh_tunnel
    
    # 배포 환경 (기본값): 직접 연결
    if not USE_SSH_TUNNEL:
        host = MYSQL_HOST
        port = MYSQL_PORT
        logger.info(f"🔗 Using direct connection: {host}:{port}")
    else:
        # 개발 환경: SSH 터널링
        try:
            from sshtunnel import SSHTunnelForwarder
            
            logger.info(f"🔐 Starting SSH tunnel to {SSH_HOST}:{SSH_PORT}...")
            
            # SSH 인증 방식 결정
            ssh_auth = {}
            if SSH_KEY_PATH:
                ssh_auth['ssh_pkey'] = SSH_KEY_PATH
                logger.info(f"   Using SSH key: {SSH_KEY_PATH}")
            elif SSH_PASSWORD:
                ssh_auth['ssh_password'] = SSH_PASSWORD
                logger.info(f"   Using SSH password authentication")
            else:
                raise ValueError("SSH_KEY_PATH or SSH_PASSWORD must be provided when USE_SSH_TUNNEL=true")
            
            # SSH 터널 생성
            ssh_tunnel = SSHTunnelForwarder(
                (SSH_HOST, SSH_PORT),
                ssh_username=SSH_USER,
                remote_bind_address=(MYSQL_HOST, MYSQL_PORT),
                **ssh_auth
            )
            
            ssh_tunnel.start()
            
            # 로컬 포트로 변경
            host = '127.0.0.1'
            port = ssh_tunnel.local_bind_port
            
            logger.info(f"✅ SSH tunnel started successfully. Local port: {port}")
            logger.info(f"🔗 Using SSH tunnel connection: {host}:{port}")
            
        except ImportError:
            logger.error("❌ sshtunnel package not installed. Install with: pip install sshtunnel")
            raise
        except Exception as e:
            logger.error(f"❌ Failed to start SSH tunnel: {e}")
            raise
    
    return (
        f"mysql+pymysql://{MYSQL_USER}:{MYSQL_PASSWORD}"
        f"@{host}:{port}/{MYSQL_DATABASE}"
        f"?charset=utf8mb4"
    )


def close_ssh_tunnel():
    """SSH 터널 종료"""
    global ssh_tunnel
    if ssh_tunnel:
        logger.info("🔚 Closing SSH tunnel...")
        ssh_tunnel.stop()
        ssh_tunnel = None

# MySQL 연결 URL
SQLALCHEMY_DATABASE_URL = get_database_url()

# 엔진 생성
engine = create_engine(
    SQLALCHEMY_DATABASE_URL,
    pool_pre_ping=True,
    pool_recycle=3600,
    connect_args={"connect_timeout": 10}
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


def get_sync_connection():
    """
    동기 방식 데이터베이스 연결 (스크립트용)
    SSH 터널링이 활성화되어 있으면 터널을 통해 연결합니다.
    
    Returns:
        pymysql.connections.Connection: 데이터베이스 연결 객체
    """
    import pymysql
    
    global ssh_tunnel
    
    # SSH 터널이 활성화되어 있고 시작된 경우 로컬 포트 사용
    if USE_SSH_TUNNEL and ssh_tunnel and ssh_tunnel.is_active:
        host = '127.0.0.1'
        port = ssh_tunnel.local_bind_port
        logger.info(f"🔗 Using SSH tunnel connection for sync: {host}:{port}")
    else:
        host = MYSQL_HOST
        port = MYSQL_PORT
        logger.info(f"🔗 Using direct connection for sync: {host}:{port}")
    
    return pymysql.connect(
        host=host,
        port=port,
        user=MYSQL_USER,
        password=MYSQL_PASSWORD,
        database=MYSQL_DATABASE,
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor
    )
