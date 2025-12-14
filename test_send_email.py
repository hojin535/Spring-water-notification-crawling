"""
테스트용 이메일 발송 스크립트
email_subscribers 테이블에서 id가 5인 구독자에게 테스트 이메일 발송
"""
import asyncio
import sys
from sqlalchemy.orm import Session

# 프로젝트 루트를 Python 경로에 추가
sys.path.insert(0, '/Users/hojin/github/Spring-water/Spring-water-notification-crawling')

from app.database import get_db
from app.db_models import EmailSubscriber, ViolationRecord
from app.services.notification_service import notification_service


async def send_test_email():
    """id가 5인 구독자에게 테스트 이메일 발송"""
    
    # DB 세션 생성
    db = next(get_db())
    
    try:
        # 1. id가 5인 구독자 조회
        subscriber = db.query(EmailSubscriber).filter(
            EmailSubscriber.id == 5
        ).first()
        
        if not subscriber:
            print("❌ Error: id가 5인 구독자를 찾을 수 없습니다.")
            return
        
        print(f"✅ 구독자 정보:")
        print(f"   - ID: {subscriber.id}")
        print(f"   - Email: {subscriber.email}")
        print(f"   - 활성 상태: {subscriber.is_active}")
        print()
        
        # 2. 테스트용 위반 데이터 조회 (최근 3개)
        violations = db.query(ViolationRecord).order_by(
            ViolationRecord.처분일자.desc()
        ).limit(3).all()
        
        if not violations:
            print("❌ Error: 위반 데이터가 없습니다.")
            return
        
        print(f"✅ 위반 데이터: {len(violations)}건")
        for v in violations:
            print(f"   - {v.업체명} ({v.처분일자})")
        print()
        
        # 3. 이메일 발송
        print("📧 이메일 발송 중...")
        stats = await notification_service.send_notifications_async(
            db=db,
            violations=violations,
            subscribers=[subscriber]
        )
        
        print()
        print("=" * 50)
        print("📊 발송 결과:")
        print(f"   - 총 발송: {stats['total']}건")
        print(f"   - 성공: {stats['success']}건")
        print(f"   - 실패: {stats['failed']}건")
        print("=" * 50)
        
        if stats['success'] > 0:
            print(f"\n✅ 성공! {subscriber.email}로 이메일이 발송되었습니다!")
            print("\n💡 이메일에 포함된 내용:")
            print("   - 위반 업체 정보")
            print("   - 🏭 취수원(OEM) 정보")
            print("   - 🏷️ 브랜드 매핑 데이터")
            print("   - 💡 AI 쉬운 설명")
            print("   - 📚 전문용어 해설")
        else:
            print(f"\n❌ 실패! 이메일 발송에 실패했습니다.")
            print("   SMTP 설정을 확인해주세요 (.env.local)")
        
    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
    finally:
        db.close()


if __name__ == "__main__":
    print("=" * 50)
    print("🧪 테스트 이메일 발송 시작")
    print("=" * 50)
    print()
    
    asyncio.run(send_test_email())
