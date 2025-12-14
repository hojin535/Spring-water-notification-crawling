"""
알림 서비스
새로운 위반 감지 및 이메일 알림 발송
"""
import logging
import re
from typing import List, Dict
from datetime import datetime
from sqlalchemy.orm import Session

from app.db_models import ViolationRecord, EmailSubscriber, NotificationHistory, WaterSource, Brand
from app.services.email_service import email_service
from app.services.ai_explainer import get_explainer

logger = logging.getLogger(__name__)


class NotificationService:
    """알림 서비스"""
    
    def __init__(self):
        self.last_violation_ids = set()
    
    def detect_new_violations(self, db: Session) -> List[ViolationRecord]:
        """
        새로운 위반 감지
        
        Args:
            db: 데이터베이스 세션
            
        Returns:
            새로운 위반 레코드 리스트
        """
        try:
            # 현재 DB의 모든 위반 ID 조회
            current_violations = db.query(ViolationRecord).all()
            current_ids = {v.id for v in current_violations}
            
            # 새로운 위반 감지
            if not self.last_violation_ids:
                # 첫 실행 시에는 모든 위반을 새로운 것으로 간주하지 않음
                logger.info(f"First run: Initializing with {len(current_ids)} existing violations")
                self.last_violation_ids = current_ids
                return []
            
            new_ids = current_ids - self.last_violation_ids
            
            if new_ids:
                logger.info(f"Detected {len(new_ids)} new violations")
                new_violations = db.query(ViolationRecord).filter(
                    ViolationRecord.id.in_(new_ids)
                ).all()
                
                # 상태 업데이트
                self.last_violation_ids = current_ids
                
                return new_violations
            else:
                logger.info("No new violations detected")
                self.last_violation_ids = current_ids
                return []
                
        except Exception as e:
            logger.error(f"Error detecting new violations: {e}")
            return []
    
    def get_active_subscribers(self, db: Session) -> List[EmailSubscriber]:
        """
        활성 구독자 목록 조회
        
        Args:
            db: 데이터베이스 세션
            
        Returns:
            활성 구독자 리스트
        """
        try:
            subscribers = db.query(EmailSubscriber).filter(
                EmailSubscriber.is_active == 1,
                EmailSubscriber.unsubscribed_at.is_(None)
            ).all()
            
            logger.info(f"Found {len(subscribers)} active subscribers")
            return subscribers
            
        except Exception as e:
            logger.error(f"Error getting active subscribers: {e}")
            return []
    
    def _normalize_company_name(self, name: str) -> str:
        """
        회사명을 정규화하여 매칭률을 높입니다.
        (주), ㈜, (株), 주식회사 등을 제거하고 공백을 정리합니다.
        """
        if not name:
            return ""
        
        normalized = name
        normalized = normalized.replace("㈜", "")
        normalized = normalized.replace("(주)", "")
        normalized = normalized.replace("(株)", "")
        normalized = normalized.replace("주식회사", "")
        normalized = normalized.replace("(주식회사)", "")
        normalized = re.sub(r'\s+', ' ', normalized)
        normalized = normalized.strip()
        
        return normalized
    
    def _get_brands_for_company(self, company_name: str, db: Session) -> List[Dict]:
        """
        업체명으로 브랜드 목록 조회
        
        Args:
            company_name: 업체명
            db: 데이터베이스 세션
            
        Returns:
            브랜드 정보 리스트
        """
        normalized_name = self._normalize_company_name(company_name)
        
        if len(normalized_name) <= 2:
            return []
        
        # WaterSource 조회
        water_sources = db.query(WaterSource).all()
        water_source = None
        
        for ws in water_sources:
            normalized_ws_name = self._normalize_company_name(ws.취수원업체명)
            if normalized_name in normalized_ws_name or normalized_ws_name in normalized_name:
                water_source = ws
                break
        
        if not water_source:
            return []
        
        # 브랜드 목록 조회
        brands = db.query(Brand).filter(
            Brand.water_source_id == water_source.id,
            Brand.활성상태 == True
        ).all()
        
        brands_list = []
        for brand in brands:
            brands_list.append({
                'id': brand.id,
                '브랜드명': brand.브랜드명,
                '데이터출처': brand.데이터출처,
                '활성상태': brand.활성상태
            })
        
        if brands_list:
            logger.info(f"Found {len(brands_list)} brands for company '{company_name}'")
        
        return brands_list
    
    async def _get_ai_explanation(self, 처분명: str, 위반내용: str, db: Session) -> Dict:
        """
        AI로 위반 내역 설명 생성
        
        Args:
            처분명: 처분명
            위반내용: 위반내용
            db: 데이터베이스 세션
            
        Returns:
            AI 설명 결과 {'쉬운설명': str, '관련용어': List[Dict]}
        """
        try:
            explainer = get_explainer()
            result = await explainer.explain_violation(
                처분명=처분명,
                위반내용=위반내용,
                db=db
            )
            
            # 관련용어 형식 변환 (explanation -> description)
            related_terms = []
            for term in result.get('related_terms', []):
                related_terms.append({
                    'term': term.get('term', ''),
                    'description': term.get('explanation', ''),  # explanation을 description로 변환
                    'category': term.get('category', ''),
                    'risk_level': term.get('risk_level', '')
                })
            
            return {
                '쉬운설명': result.get('easy_explanation', ''),
                '관련용어': related_terms
            }
        except Exception as e:
            logger.error(f"Error getting AI explanation: {e}")
            return {
                '쉬운설명': '',
                '관련용어': []
            }
    
    async def send_notifications_async(
        self,
        db: Session,
        violations: List[ViolationRecord],
        subscribers: List[EmailSubscriber]
    ) -> Dict[str, int]:
        """
        구독자들에게 알림 발송 (비동기)
        
        Args:
            db: 데이터베이스 세션
            violations: 새로운 위반 리스트
            subscribers: 구독자 리스트
            
        Returns:
            발송 결과 통계 {'total': 총 발송 수, 'success': 성공 수, 'failed': 실패 수}
        """
        stats = {'total': 0, 'success': 0, 'failed': 0}
        
        if not violations or not subscribers:
            logger.info("No violations or subscribers to notify")
            return stats
        
        # 위반 데이터를 dict로 변환 (브랜드 정보 및 AI 설명 추가)
        violations_data = []
        for v in violations:
            # 브랜드 정보 조회
            brands_list = self._get_brands_for_company(v.업체명, db)
            
            # AI 설명 조회
            ai_explanation = await self._get_ai_explanation(v.처분명, v.위반내용, db)
            
            violations_data.append({
                'id': v.id,
                '업체명': v.업체명,
                '제품명': v.제품명,
                '업체소재지': v.업체소재지,
                '처분명': v.처분명,
                '처분일자': v.처분일자,
                '공표마감일자': v.공표마감일자,
                '위반내용': v.위반내용,
                '상세URL': v.상세URL,
                '브랜드목록': brands_list,
                '쉬운설명': ai_explanation['쉬운설명'],
                '관련용어': ai_explanation['관련용어']
            })
        
        # 각 구독자에게 이메일 발송
        for subscriber in subscribers:
            stats['total'] += 1
            
            try:
                # 이메일 발송
                success = email_service.send_violation_alert(
                    email=subscriber.email,
                    violations=violations_data,
                    unsubscribe_token=subscriber.unsubscribe_token
                )
                
                if success:
                    stats['success'] += 1
                    
                    # 구독자의 마지막 알림 시간 업데이트
                    subscriber.last_notified_at = datetime.now()
                    
                    # 각 위반에 대한 알림 기록 저장
                    for violation in violations:
                        notification = NotificationHistory(
                            subscriber_id=subscriber.id,
                            violation_id=violation.id,
                            email_subject=f"⚠️ 새로운 먹는샘물 위반 {len(violations)}건 발견",
                            is_success=1,
                            error_message=None
                        )
                        db.add(notification)
                    
                else:
                    stats['failed'] += 1
                    
                    # 실패 기록 저장 (첫 번째 위반에만)
                    if violations:
                        notification = NotificationHistory(
                            subscriber_id=subscriber.id,
                            violation_id=violations[0].id,
                            email_subject=f"⚠️ 새로운 먹는샘물 위반 {len(violations)}건 발견",
                            is_success=0,
                            error_message="Email sending failed"
                        )
                        db.add(notification)
                
                db.commit()
                
            except Exception as e:
                logger.error(f"Error sending notification to {subscriber.email}: {e}")
                stats['failed'] += 1
                db.rollback()
        
        logger.info(f"Notification stats: {stats}")
        return stats
    
    def send_notifications(
        self,
        db: Session,
        violations: List[ViolationRecord],
        subscribers: List[EmailSubscriber]
    ) -> Dict[str, int]:
        """
        구독자들에게 알림 발송 (동기 래퍼)
        
        Args:
            db: 데이터베이스 세션
            violations: 새로운 위반 리스트
            subscribers: 구독자 리스트
            
        Returns:
            발송 결과 통계
        """
        import asyncio
        
        # 비동기 함수를 동기적으로 실행
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)
        try:
            return loop.run_until_complete(
                self.send_notifications_async(db, violations, subscribers)
            )
        finally:
            loop.close()
    
    def process_new_violations(self, db: Session) -> Dict[str, any]:
        """
        새로운 위반 감지 및 알림 발송 전체 프로세스
        
        Args:
            db: 데이터베이스 세션
            
        Returns:
            처리 결과 {'new_violations': 수, 'notifications_sent': 통계}
        """
        try:
            # 1. 새로운 위반 감지
            new_violations = self.detect_new_violations(db)
            
            if not new_violations:
                return {
                    'new_violations': 0,
                    'notifications_sent': {'total': 0, 'success': 0, 'failed': 0}
                }
            
            # 2. 활성 구독자 조회
            subscribers = self.get_active_subscribers(db)
            
            if not subscribers:
                logger.info(f"Found {len(new_violations)} new violations but no active subscribers")
                return {
                    'new_violations': len(new_violations),
                    'notifications_sent': {'total': 0, 'success': 0, 'failed': 0}
                }
            
            # 3. 알림 발송
            notification_stats = self.send_notifications(db, new_violations, subscribers)
            
            return {
                'new_violations': len(new_violations),
                'notifications_sent': notification_stats
            }
            
        except Exception as e:
            logger.error(f"Error processing new violations: {e}")
            return {
                'new_violations': 0,
                'notifications_sent': {'total': 0, 'success': 0, 'failed': 0},
                'error': str(e)
            }


# 싱글톤 인스턴스
notification_service = NotificationService()
