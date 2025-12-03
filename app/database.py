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


def get_database_url():
    """데이터베이스 연결 URL 생성"""
    # 직접 연결
    host = MYSQL_HOST
    port = MYSQL_PORT
    logger.info(f"Using direct connection: {host}:{port}")
    
    return (
        f"mysql+pymysql://{MYSQL_USER}:{MYSQL_PASSWORD}"
        f"@{host}:{port}/{MYSQL_DATABASE}"
        f"?charset=utf8mb4"
    )

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
