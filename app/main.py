"""
먹는물영업자 위반현황 크롤링 FastAPI 서버
"""
from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from typing import List
from datetime import datetime
from apscheduler.schedulers.background import BackgroundScheduler
from contextlib import asynccontextmanager
from sqlalchemy.orm import Session
from sqlalchemy import desc
import logging
import re
import os
import secrets

from app.models.violation import ViolationListItem, ViolationDetail
from app.models.explain import ExplainRequest, ExplainResponse, TermExplanation
from app.models.subscription import SubscribeRequest, SubscribeResponse, UnsubscribeResponse
from app.crawlers.mcee_crawler import (
    get_violation_list,
    get_all_violations_with_details,
    get_violation_by_board_id
)
from app.database import get_db, init_db
from app.db_models import ViolationRecord, TermMapping, ViolationExplanationCache, EmailSubscriber
from app.services.ai_explainer import get_explainer
from app.services.email_service import email_service
from app.services.notification_service import notification_service


# 로깅 설정
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# 스케줄러 인스턴스
scheduler = BackgroundScheduler()

# 환경 변수
CRAWL_ON_STARTUP = os.getenv('CRAWL_ON_STARTUP', 'false').lower() == 'true'
NOTIFICATION_ENABLED = os.getenv('NOTIFICATION_ENABLED', 'true').lower() == 'true'


def extract_board_id(url: str) -> str:
    """URL에서 board_id 추출"""
    if not url:
        return ""
    match = re.search(r'boardId=(\d+)', url)
    return match.group(1) if match else ""


def generate_cache_key(처분명: str, 위반내용: str) -> str:
    """
    AI 캐시 키 생성 (ai_explainer.py와 동일한 로직)
    
    Args:
        처분명: 처분 명칭
        위반내용: 위반 내용
        
    Returns:
        64자 해시 문자열
    """
    import hashlib
    combined = f"{처분명}|{위반내용}"
    return hashlib.sha256(combined.encode('utf-8')).hexdigest()


def crawl_and_save_to_db():
    """
    크롤링 후 DB에 저장 (1시간마다 실행)
    """
    logger.info("Starting scheduled crawl and save to DB...")
    
    try:
        # 상세 정보 크롤링
        logger.info("Crawling detailed violations...")
        detailed_violations = get_all_violations_with_details()
        
        if not detailed_violations:
            logger.warning("No violations found during crawl")
            return
        
        # DB 세션 생성
        db = next(get_db())
        
        try:
            saved_count = 0
            updated_count = 0
            
            # 현재 웹사이트에 존재하는 board_id 목록 수집
            current_board_ids = set()
            
            for item in detailed_violations:
                # board_id가 없으면 생성 (업체명 + 처분일자 조합)
                board_id = f"{item.get('업체명', '')}_{item.get('처분일자', '')}".replace(" ", "_")
                current_board_ids.add(board_id)
                
                # 기존 레코드 확인
                existing = db.query(ViolationRecord).filter(
                    ViolationRecord.board_id == board_id
                ).first()
                
                if existing:
                    # 업데이트
                    for key, value in item.items():
                        if hasattr(existing, key):
                            setattr(existing, key, value)
                    updated_count += 1
                else:
                    # 새로 추가
                    new_record = ViolationRecord(
                        품목=item.get('품목', ''),
                        업체명=item.get('업체명', ''),
                        업체소재지=item.get('업체소재지', ''),
                        제품명=item.get('제품명', ''),
                        업종명=item.get('업종명', ''),
                        공표마감일자=item.get('공표마감일자', ''),
                        처분명=item.get('처분명', ''),
                        처분기간=item.get('처분기간', ''),
                        위반내용=item.get('위반내용', ''),
                        처분일자=item.get('처분일자', ''),
                        board_id=board_id
                    )
                    db.add(new_record)
                    saved_count += 1
            
            db.commit()
            logger.info(f"DB save completed. New: {saved_count}, Updated: {updated_count}")
            
            # 공개기간이 지나 웹사이트에서 사라진 데이터 삭제
            logger.info("Checking for expired records to delete...")
            
            # DB의 모든 레코드 조회
            all_db_records = db.query(ViolationRecord).all()
            
            # 웹사이트에는 없지만 DB에는 있는 레코드 찾기
            records_to_delete = []
            for record in all_db_records:
                if record.board_id not in current_board_ids:
                    records_to_delete.append(record)
            
            # 삭제 실행
            deleted_count = 0
            
            for record in records_to_delete:
                # DB 레코드 삭제 (캐시는 FK CASCADE로 자동 삭제됨)
                db.delete(record)
                deleted_count += 1
                logger.info(f"Deleted expired record: {record.업체명} - {record.처분일자} (board_id: {record.board_id})")
            
            if deleted_count > 0:
                db.commit()
                logger.info(f"Cleanup completed. Deleted {deleted_count} violation records (cache auto-deleted via CASCADE)")
            else:
                logger.info("No expired records found. All data is up to date.")
            
            # 새로운 위반 감지 및 알림 발송
            if NOTIFICATION_ENABLED:
                logger.info("Checking for new violations and sending notifications...")
                try:
                    notification_result = notification_service.process_new_violations(db)
                    logger.info(f"Notification result: {notification_result}")
                except Exception as notify_error:
                    logger.error(f"Error sending notifications: {notify_error}", exc_info=True)
            
            
        except Exception as e:
            db.rollback()
            logger.error(f"Error saving to DB: {e}", exc_info=True)
            raise
        finally:
            db.close()
            
    except Exception as e:
        logger.error(f"Error in crawl_and_save_to_db: {e}", exc_info=True)


@asynccontextmanager
async def lifespan(app: FastAPI):
    """
    앱 시작/종료 시 실행되는 lifespan 이벤트
    """
    # 시작 시
    logger.info("Starting application...")
    
    # DB 초기화
    logger.info("Initializing database...")
    init_db()
    logger.info("Database initialized")
    
    # 스케줄러 시작 (매 시간 정각에 실행)
    scheduler.add_job(
        crawl_and_save_to_db,
        'cron',
        minute=0,  # 매 시간 0분(정각)에 실행
        id='crawl_to_db'
    )
    scheduler.start()
    logger.info("Scheduler started (crawls every hour at 00 minutes)")
    
    # 서버 시작 시 즉시 크롤링 실행 여부 확인
    if CRAWL_ON_STARTUP:
        logger.info("CRAWL_ON_STARTUP is enabled. Starting initial crawl...")
        try:
            crawl_and_save_to_db()
            logger.info("Initial crawl completed successfully")
        except Exception as e:
            logger.error(f"Initial crawl failed: {e}", exc_info=True)
    else:
        logger.info("CRAWL_ON_STARTUP is disabled. First crawl will occur at the next hour (00 minutes)")
    
    yield
    
    # 종료 시
    logger.info("Shutting down application...")
    scheduler.shutdown()
    
    # SSH 터널 종료
    from app.database import stop_ssh_tunnel
    stop_ssh_tunnel()


# FastAPI 앱 초기화
app = FastAPI(
    title="MCEE Violation Crawler API",
    description="기후에너지환경부 먹는물영업자 위반현황 크롤링 API (1시간마다 자동 갱신, MySQL 저장)",
    version="3.0.0",
    lifespan=lifespan
)

# CORS 미들웨어 설정
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 프로덕션에서는 특정 도메인만 허용하도록 변경
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def root(db: Session = Depends(get_db)):
    """
    헬스 체크 엔드포인트
    """
    # DB 통계 조회
    total_count = db.query(ViolationRecord).count()
    latest_record = db.query(ViolationRecord).order_by(desc(ViolationRecord.updated_at)).first()
    
    return {
        "status": "ok",
        "message": "MCEE Crawler API",
        "version": "3.0.0",
        "database": {
            "total_records": total_count,
            "last_updated": latest_record.updated_at.isoformat() if latest_record else None
        }
    }


@app.get("/api/violations", response_model=List[ViolationListItem])
async def get_violations(
    limit: int = 100,
    offset: int = 0,
    db: Session = Depends(get_db)
):
    """
    위반 목록 조회 (DB에서 반환)
    
    DB에 저장된 데이터를 반환합니다. 데이터는 1시간마다 자동으로 갱신됩니다.
    
    Args:
        limit: 반환할 최대 레코드 수 (기본: 100)
        offset: 건너뛸 레코드 수 (페이지네이션용, 기본: 0)
    
    Returns:
        List[ViolationListItem]: 위반 목록
    """
    records = db.query(ViolationRecord).order_by(
        desc(ViolationRecord.처분일자)
    ).offset(offset).limit(limit).all()
    
    results = []
    for record in records:
        results.append(ViolationListItem(
            순번=record.순번 or "",
            품목=record.품목 or "",
            업체명=record.업체명 or "",
            제품명=record.제품명 or "",
            처분명=record.처분명 or "",
            처분일자=record.처분일자 or "",
            공표마감일자=record.공표마감일자 or "",
            상세URL=record.상세URL
        ))
    
    logger.info(f"GET /api/violations - Returning {len(results)} records from DB")
    return results


@app.get("/api/violations/mapped", response_model=List[ViolationDetail])
async def get_violations_mapped(
    limit: int = 100,
    offset: int = 0,
    db: Session = Depends(get_db)
):
    """
    위반 데이터를 DB에서 가져와 전문 용어를 쉬운 언어로 매핑하여 반환합니다.
    매핑은 term_mappings 테이블에 정의된 professional → easy 값을 사용합니다.
    """
    # term mapping dict
    term_rows = db.query(TermMapping).all()
    term_map = {row.professional: row.easy for row in term_rows}
    
    records = db.query(ViolationRecord).order_by(
        desc(ViolationRecord.처분일자)
    ).offset(offset).limit(limit).all()
    
    def map_text(text: str) -> str:
        if not text:
            return text
        for prof, easy in term_map.items():
            text = text.replace(prof, easy)
        return text
    
    results = []
    for record in records:
        # map each textual field
        mapped = ViolationDetail(
            품목=map_text(record.품목),
            업체명=map_text(record.업체명),
            업체소재지=map_text(record.업체소재지),
            제품명=map_text(record.제품명),
            업종명=map_text(record.업종명),
            공표마감일자=record.공표마감일자,
            처분명=map_text(record.처분명),
            처분기간=record.처분기간,
            위반내용=map_text(record.위반내용),
            처분일자=record.처분일자
        )
        results.append(mapped)
    
    logger.info(f"GET /api/violations/mapped - Returned {len(results)} mapped records")
    return results



@app.get("/api/violations/company/{company_name}", response_model=List[ViolationDetail])
async def get_violations_by_company(
    company_name: str,
    db: Session = Depends(get_db)
):
    """
    특정 업체의 위반 내역 조회
    
    Args:
        company_name: 업체명
        
    Returns:
        List[ViolationDetail]: 해당 업체의 위반 목록
    """
    records = db.query(ViolationRecord).filter(
        ViolationRecord.업체명.like(f"%{company_name}%")
    ).order_by(desc(ViolationRecord.처분일자)).all()
    
    if not records:
        raise HTTPException(
            status_code=404,
            detail=f"업체명 '{company_name}'에 해당하는 위반 기록을 찾을 수 없습니다"
        )
    
    results = []
    for record in records:
        results.append(ViolationDetail(
            품목=record.품목 or "",
            업체명=record.업체명 or "",
            업체소재지=record.업체소재지 or "",
            제품명=record.제품명 or "",
            업종명=record.업종명 or "",
            공표마감일자=record.공표마감일자 or "",
            처분명=record.처분명 or "",
            처분기간=record.처분기간 or "",
            위반내용=record.위반내용 or "",
            처분일자=record.처분일자 or ""
        ))
    
    logger.info(f"GET /api/violations/company/{company_name} - Found {len(results)} records")
    return results


@app.post("/api/crawl/manual")
async def manual_crawl():
    """
    수동 크롤링 실행 (관리자용)
    
    즉시 크롤링을 실행하여 DB에 저장합니다.
    """
    logger.info("Manual crawl requested")
    
    try:
        # 백그라운드에서 실행
        scheduler.add_job(crawl_and_save_to_db, id='manual_crawl')
        
        return {
            "status": "ok",
            "message": "크롤링이 시작되었습니다. 완료까지 1-2분 정도 소요될 수 있습니다."
        }
    except Exception as e:
        logger.error(f"Error starting manual crawl: {e}", exc_info=True)
        raise HTTPException(
            status_code=500,
            detail=f"크롤링 시작 중 오류가 발생했습니다: {str(e)}"
        )


@app.post("/api/violations/explain", response_model=ExplainResponse)
async def explain_violation(
    request: ExplainRequest,
    db: Session = Depends(get_db)
):
    """
    위반 내역을 AI로 쉽게 설명 (Google Gemini API 사용)
    
    전문 용어는 DB(water_terms)에서 조회하고,
    전체 설명은 AI가 자연스러운 문장으로 생성합니다.
    
    Args:
        request: 처분명과 위반내용을 포함한 요청
        
    Returns:
        ExplainResponse: AI 생성 설명 + 관련 전문 용어 리스트
    """
    logger.info(f"POST /api/violations/explain - 처분명: {request.처분명[:30]}...")
    
    try:
        # AI Explainer 인스턴스 가져오기
        explainer = get_explainer()
        
        # AI로 설명 생성
        result = await explainer.explain_violation(
            처분명=request.처분명,
            위반내용=request.위반내용,
            db=db
        )
        
        # Pydantic 모델로 변환
        response = ExplainResponse(
            easy_explanation=result["easy_explanation"],
            related_terms=[
                TermExplanation(**term) for term in result["related_terms"]
            ]
        )
        
        logger.info(f"Successfully generated explanation with {len(response.related_terms)} related terms")
        return response
        
    except ValueError as e:
        # API Key 미설정 등의 설정 오류
        logger.error(f"Configuration error: {e}", exc_info=True)
        raise HTTPException(
            status_code=500,
            detail=str(e)
        )
    except Exception as e:
        # 기타 오류
        logger.error(f"Error generating explanation: {e}", exc_info=True)
        raise HTTPException(
            status_code=500,
            detail=f"설명 생성 중 오류가 발생했습니다: {str(e)}"
        )


# =================================================
# 이메일 구독 API
# =================================================

@app.post("/api/subscribe", response_model=SubscribeResponse)
async def subscribe_email(
    request: SubscribeRequest,
    db: Session = Depends(get_db)
):
    """
    이메일 구독 신청
    
    Args:
        request: 이메일 주소
        
    Returns:
        SubscribeResponse: 구독 신청 결과
    """
    logger.info(f"POST /api/subscribe - email: {request.email}")
    
    try:
        # 이미 구독 중인지 확인
        existing = db.query(EmailSubscriber).filter(
            EmailSubscriber.email == request.email
        ).first()
        
        if existing:
            if existing.is_active == 1:
                return SubscribeResponse(
                    status="already_subscribed",
                    message="이미 구독 중인 이메일입니다.",
                    email=request.email
                )
            else:
                # 비활성 상태인 경우 토큰 재생성 및 확인 이메일 재발송
                existing.subscription_token = secrets.token_urlsafe(32)
                existing.subscribed_at = datetime.now()
                db.commit()
                
                # 확인 이메일 발송
                email_service.send_subscription_confirmation(
                    email=request.email,
                    token=existing.subscription_token
                )
                
                return SubscribeResponse(
                    status="resent",
                    message="확인 이메일을 재발송했습니다. 이메일을 확인해주세요.",
                    email=request.email
                )
        
        # 새로운 구독자 생성
        subscription_token = secrets.token_urlsafe(32)
        unsubscribe_token = secrets.token_urlsafe(32)
        
        new_subscriber = EmailSubscriber(
            email=request.email,
            is_active=0,  # 이메일 확인 전에는 비활성
            subscription_token=subscription_token,
            unsubscribe_token=unsubscribe_token
        )
        
        db.add(new_subscriber)
        db.commit()
        
        # 확인 이메일 발송
        email_sent = email_service.send_subscription_confirmation(
            email=request.email,
            token=subscription_token
        )
        
        if email_sent:
            return SubscribeResponse(
                status="success",
                message="구독 확인 이메일을 발송했습니다. 이메일을 확인해주세요.",
                email=request.email
            )
        else:
            # 이메일 발송 실패 시 DB에서 삭제
            db.delete(new_subscriber)
            db.commit()
            raise HTTPException(
                status_code=500,
                detail="이메일 발송에 실패했습니다. 잠시 후 다시 시도해주세요."
            )
            
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error subscribing email: {e}", exc_info=True)
        db.rollback()
        raise HTTPException(
            status_code=500,
            detail=f"구독 처리 중 오류가 발생했습니다: {str(e)}"
        )


@app.get("/api/subscribe/confirm/{token}")
async def confirm_subscription(
    token: str,
    db: Session = Depends(get_db)
):
    """
    이메일 구독 확인
    
    Args:
        token: 구독 확인 토큰
        
    Returns:
        확인 결과 메시지
    """
    logger.info(f"GET /api/subscribe/confirm/{token[:10]}...")
    
    try:
        subscriber = db.query(EmailSubscriber).filter(
            EmailSubscriber.subscription_token == token
        ).first()
        
        if not subscriber:
            raise HTTPException(
                status_code=404,
                detail="유효하지 않은 구독 확인 링크입니다."
            )
        
        if subscriber.is_active == 1:
            return {
                "status": "already_confirmed",
                "message": "이미 구독이 확인된 이메일입니다.",
                "email": subscriber.email
            }
        
        # 구독 활성화
        subscriber.is_active = 1
        subscriber.confirmed_at = datetime.now()
        db.commit()
        
        logger.info(f"Email subscription confirmed: {subscriber.email}")
        
        # 첫 구독 시 환영 이메일 발송
        try:
            # 1. 환영 이메일 발송
            welcome_sent = email_service.send_welcome_email(
                email=subscriber.email,
                unsubscribe_token=subscriber.unsubscribe_token
            )
            
            if welcome_sent:
                logger.info(f"Welcome email sent to {subscriber.email}")
            else:
                logger.warning(f"Failed to send welcome email to {subscriber.email}")
            
            # 2. 현재 DB에서 최신 위반 내용 조회 (최신 10개)
            current_violations = db.query(ViolationRecord).order_by(
                desc(ViolationRecord.처분일자)
            ).limit(10).all()
            
            if current_violations:
                # 위반 데이터를 dict로 변환
                violations_data = []
                for v in current_violations:
                    violations_data.append({
                        'id': v.id,
                        '업체명': v.업체명,
                        '제품명': v.제품명,
                        '업체소재지': v.업체소재지,
                        '처분명': v.처분명,
                        '처분일자': v.처분일자,
                        '공표마감일자': v.공표마감일자,
                        '위반내용': v.위반내용,
                        '상세URL': v.상세URL
                    })
                
                # 위반 정보 이메일 발송 (환영 이메일과 별도)
                violations_sent = email_service.send_violation_alert(
                    email=subscriber.email,
                    violations=violations_data,
                    unsubscribe_token=subscriber.unsubscribe_token
                )
                
                if violations_sent:
                    logger.info(f"Current violations email sent to {subscriber.email} (total: {len(violations_data)} violations)")
                else:
                    logger.warning(f"Failed to send violations email to {subscriber.email}")
        except Exception as email_error:
            logger.error(f"Error sending welcome/violations emails: {email_error}", exc_info=True)
            # 이메일 발송 실패해도 구독은 활성화되도록 함
        
        return {
            "status": "success",
            "message": "구독이 확인되었습니다! 환영 이메일과 현재 위반 정보를 발송했습니다.",
            "email": subscriber.email
        }
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error confirming subscription: {e}", exc_info=True)
        db.rollback()
        raise HTTPException(
            status_code=500,
            detail=f"구독 확인 중 오류가 발생했습니다: {str(e)}"
        )


@app.get("/api/unsubscribe/{token}", response_model=UnsubscribeResponse)
async def unsubscribe_email(
    token: str,
    db: Session = Depends(get_db)
):
    """
    이메일 구독 취소
    
    Args:
        token: 구독 취소 토큰
        
    Returns:
        UnsubscribeResponse: 구독 취소 결과
    """
    logger.info(f"GET /api/unsubscribe/{token[:10]}...")
    
    try:
        subscriber = db.query(EmailSubscriber).filter(
            EmailSubscriber.unsubscribe_token == token
        ).first()
        
        if not subscriber:
            raise HTTPException(
                status_code=404,
                detail="유효하지 않은 구독 취소 링크입니다."
            )
        
        if subscriber.unsubscribed_at:
            return UnsubscribeResponse(
                status="already_unsubscribed",
                message="이미 구독이 취소된 이메일입니다."
            )
        
        # 구독 취소
        subscriber.is_active = 0
        subscriber.unsubscribed_at = datetime.now()
        db.commit()
        
        logger.info(f"Email subscription cancelled: {subscriber.email}")
        
        return UnsubscribeResponse(
            status="success",
            message="구독이 취소되었습니다. 더 이상 알림을 받지 않습니다."
        )
        
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error unsubscribing: {e}", exc_info=True)
        db.rollback()
        raise HTTPException(
            status_code=500,
            detail=f"구독 취소 중 오류가 발생했습니다: {str(e)}"
        )


@app.post("/api/test-email")
async def send_test_email():
    """
    테스트 이메일 발송 (본인에게)
    
    SMTP 설정이 올바른지 확인하기 위해 본인 이메일로 테스트 이메일을 발송합니다.
    
    Returns:
        발송 결과
    """
    logger.info("POST /api/test-email - Sending test email")
    
    try:
        # 환경 변수에서 이메일 주소 가져오기
        test_email = os.getenv('SMTP_FROM_EMAIL') or os.getenv('SMTP_USERNAME')
        
        if not test_email:
            raise HTTPException(
                status_code=500,
                detail="SMTP_FROM_EMAIL 또는 SMTP_USERNAME 환경 변수가 설정되지 않았습니다."
            )
        
        # 테스트 이메일 HTML 내용
        html_content = """
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>테스트 이메일</title>
</head>
<body style="margin: 0; padding: 0; font-family: 'Apple SD Gothic Neo', 'Malgun Gothic', sans-serif; background-color: #f5f5f5;">
    <div style="max-width: 600px; margin: 40px auto; background-color: #ffffff; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
        <!-- 헤더 -->
        <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 40px 20px; text-align: center;">
            <h1 style="color: #ffffff; margin: 0; font-size: 28px;">✅ 테스트 이메일</h1>
            <p style="color: #ffffff; margin: 10px 0 0 0; opacity: 0.9;">SMTP 설정 확인</p>
        </div>
        
        <!-- 본문 -->
        <div style="padding: 40px 30px;">
            <p style="font-size: 16px; line-height: 1.6; color: #333333; margin-bottom: 20px;">
                <strong>축하합니다! 🎉</strong>
            </p>
            
            <p style="font-size: 16px; line-height: 1.6; color: #333333; margin-bottom: 20px;">
                SMTP 이메일 설정이 정상적으로 작동하고 있습니다.
            </p>
            
            <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px; margin-top: 30px;">
                <p style="font-size: 14px; color: #666666; margin: 0; line-height: 1.6;">
                    ✅ <strong>SMTP 연결 성공</strong><br>
                    ✅ <strong>이메일 발송 가능</strong><br>
                    ✅ <strong>시스템 준비 완료</strong>
                </p>
            </div>
            
            <p style="font-size: 14px; line-height: 1.6; color: #999999; margin-top: 30px;">
                이제 먹는샘물 위반 알림 시스템을 사용할 수 있습니다!
            </p>
        </div>
        
        <!-- 푸터 -->
        <div style="background-color: #f8f9fa; padding: 30px; text-align: center; border-top: 1px solid #e9ecef;">
            <p style="font-size: 12px; color: #999999; margin: 0; line-height: 1.6;">
                Spring Water Notification System<br>
                테스트 이메일 - """ + datetime.now().strftime("%Y-%m-%d %H:%M:%S") + """
            </p>
        </div>
    </div>
</body>
</html>
        """
        
        # 이메일 발송
        success = email_service.send_email(
            to_email=test_email,
            subject="🧪 [테스트] 먹는샘물 알림 시스템 - SMTP 설정 확인",
            html_content=html_content
        )
        
        if success:
            return {
                "status": "success",
                "message": f"테스트 이메일을 {test_email}로 발송했습니다. 받은편지함을 확인해주세요.",
                "email": test_email
            }
        else:
            raise HTTPException(
                status_code=500,
                detail="이메일 발송에 실패했습니다. SMTP 설정을 확인해주세요."
            )
            
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error sending test email: {e}", exc_info=True)
        raise HTTPException(
            status_code=500,
            detail=f"테스트 이메일 발송 중 오류가 발생했습니다: {str(e)}"
        )



if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
