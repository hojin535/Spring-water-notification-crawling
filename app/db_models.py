"""
SQLAlchemy 데이터베이스 모델
"""
from sqlalchemy import Column, Integer, String, Text, DateTime, ForeignKey
from sqlalchemy.sql import func
from app.database import Base


class ViolationRecord(Base):
    """위반 기록 테이블"""
    __tablename__ = "violations"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    
    # 기본 정보
    순번 = Column(String(50))
    품목 = Column(String(100))
    업체명 = Column(String(200), index=True)
    업체소재지 = Column(String(300))
    제품명 = Column(String(200))
    업종명 = Column(String(100))
    
    # 처분 정보
    처분명 = Column(String(300))
    처분일자 = Column(String(20), index=True)
    처분기간 = Column(String(100))
    공표마감일자 = Column(String(20))
    
    # 위반 내용
    위반내용 = Column(Text)
    
    # 추가 정보
    상세URL = Column(String(500))
    board_id = Column(String(50), unique=True, index=True)  # 고유 ID
    
    # 메타 정보
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())
    
    def __repr__(self):
        return f"<ViolationRecord(업체명={self.업체명}, 처분일자={self.처분일자})>"


class TermMapping(Base):
    """전문 용어와 쉬운 용어 매핑 테이블"""
    __tablename__ = "term_mappings"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    professional = Column(String(200), nullable=False, unique=True)
    easy = Column(String(200), nullable=False)


class WaterTerm(Base):
    """수질 검사 용어 사전 테이블"""
    __tablename__ = "water_terms"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    
    # 용어 정보
    term = Column(String(100), nullable=False, unique=True, comment='수질 검사 용어')
    description = Column(Text, nullable=False, comment='쉬운 설명')
    
    # 분류 정보
    category = Column(String(50), nullable=False, index=True, comment='카테고리')
    category_name = Column(String(100), nullable=False, comment='카테고리 한글명')
    risk_level = Column(String(20), nullable=False, index=True, comment='위험도')
    
    # 데이터 출처
    source = Column(String(50), default='manual', comment='데이터 출처')
    
    # 메타 정보
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())
    
    def __repr__(self):
        return f"<WaterTerm(term={self.term}, category={self.category_name})>"


class ViolationExplanationCache(Base):
    """AI 생성 위반 설명 캐시 테이블"""
    __tablename__ = "violation_explanation_cache"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    
    # violations 테이블 참조 (FK) - API 직접 호출 시에는 NULL 가능
    violation_id = Column(Integer, ForeignKey('violations.id', ondelete='CASCADE'), nullable=True, index=True, comment='violations 테이블 ID (있는 경우)')
    
    # 캐시 키 (해시값으로 저장)
    cache_key = Column(String(64), nullable=False, unique=True, index=True, comment='처분명+위반내용의 해시값')
    
    # 원본 데이터
    처분명 = Column(String(300), nullable=False)
    위반내용 = Column(Text, nullable=False)
    
    # AI 생성 결과
    easy_explanation = Column(Text, nullable=False, comment='AI 생성 쉬운 설명')
    related_terms_json = Column(Text, comment='관련 전문 용어 JSON')
    
    # 메타 정보
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    accessed_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now(), comment='마지막 접근 시간')
    access_count = Column(Integer, default=0, comment='사용 횟수')
    
    def __repr__(self):
        return f"<ViolationExplanationCache(violation_id={self.violation_id}, cache_key={self.cache_key}, access_count={self.access_count})>"


class EmailSubscriber(Base):
    """이메일 구독자 테이블"""
    __tablename__ = "email_subscribers"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    
    # 이메일 정보
    email = Column(String(255), nullable=False, unique=True, index=True, comment='구독자 이메일 주소')
    
    # 구독 상태
    is_active = Column(Integer, default=0, comment='구독 활성화 여부 (0: 비활성, 1: 활성)')
    subscription_token = Column(String(64), unique=True, index=True, comment='구독 확인 토큰')
    unsubscribe_token = Column(String(64), unique=True, index=True, comment='구독 취소 토큰')
    
    # 일시 정보
    subscribed_at = Column(DateTime(timezone=True), server_default=func.now(), comment='구독 신청일시')
    confirmed_at = Column(DateTime(timezone=True), nullable=True, comment='이메일 인증 완료일시')
    last_notified_at = Column(DateTime(timezone=True), nullable=True, comment='마지막 알림 발송일시')
    unsubscribed_at = Column(DateTime(timezone=True), nullable=True, comment='구독 취소일시')
    
    # 메타 정보
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())
    
    def __repr__(self):
        return f"<EmailSubscriber(email={self.email}, is_active={self.is_active})>"


class NotificationHistory(Base):
    """알림 발송 기록 테이블"""
    __tablename__ = "notification_history"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    
    # 관계
    subscriber_id = Column(Integer, nullable=False, index=True, comment='구독자 ID')
    violation_id = Column(Integer, nullable=False, index=True, comment='위반 ID')
    
    # 알림 정보
    email_subject = Column(String(500), comment='이메일 제목')
    email_sent_at = Column(DateTime(timezone=True), server_default=func.now(), comment='이메일 발송일시')
    is_success = Column(Integer, default=1, comment='발송 성공 여부 (0: 실패, 1: 성공)')
    error_message = Column(Text, nullable=True, comment='발송 실패 시 에러 메시지')
    
    # 메타 정보
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    
    def __repr__(self):
        return f"<NotificationHistory(subscriber_id={self.subscriber_id}, violation_id={self.violation_id})>"
