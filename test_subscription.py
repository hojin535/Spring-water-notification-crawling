"""
이메일 구독 테스트 스크립트
"""
import requests
import json

BASE_URL = "http://localhost:8000"

def test_subscribe():
    """이메일 구독 신청 테스트"""
    print("\n=== 1. 이메일 구독 신청 테스트 ===")
    
    url = f"{BASE_URL}/api/subscribe"
    data = {
        "email": "test@example.com"  # 테스트용 이메일 주소로 변경하세요
    }
    
    response = requests.post(url, json=data)
    print(f"Status Code: {response.status_code}")
    print(f"Response: {json.dumps(response.json(), indent=2, ensure_ascii=False)}")
    
    if response.status_code == 200:
        print("\n✅ 구독 신청 성공!")
        print("📧 이메일을 확인하여 구독을 완료하세요.")
    else:
        print("\n❌ 구독 신청 실패")


def test_already_subscribed():
    """이미 구독 중인 이메일로 재신청 테스트"""
    print("\n=== 2. 이미 구독 중인 이메일 테스트 ===")
    
    url = f"{BASE_URL}/api/subscribe"
    data = {
        "email": "test@example.com"
    }
    
    response = requests.post(url, json=data)
    print(f"Status Code: {response.status_code}")
    print(f"Response: {json.dumps(response.json(), indent=2, ensure_ascii=False)}")


def test_confirm_subscription(token):
    """구독 확인 테스트"""
    print(f"\n=== 3. 구독 확인 테스트 ===")
    
    url = f"{BASE_URL}/api/subscribe/confirm/{token}"
    
    response = requests.get(url)
    print(f"Status Code: {response.status_code}")
    print(f"Response: {json.dumps(response.json(), indent=2, ensure_ascii=False)}")
    
    if response.status_code == 200:
        print("\n✅ 구독 확인 성공!")
    else:
        print("\n❌ 구독 확인 실패")


def test_unsubscribe(token):
    """구독 취소 테스트"""
    print(f"\n=== 4. 구독 취소 테스트 ===")
    
    url = f"{BASE_URL}/api/unsubscribe/{token}"
    
    response = requests.get(url)
    print(f"Status Code: {response.status_code}")
    print(f"Response: {json.dumps(response.json(), indent=2, ensure_ascii=False)}")
    
    if response.status_code == 200:
        print("\n✅ 구독 취소 성공!")
    else:
        print("\n❌ 구독 취소 실패")


def test_health_check():
    """서버 상태 확인"""
    print("\n=== 0. 서버 상태 확인 ===")
    
    url = f"{BASE_URL}/"
    
    try:
        response = requests.get(url)
        print(f"Status Code: {response.status_code}")
        print(f"Response: {json.dumps(response.json(), indent=2, ensure_ascii=False)}")
        return True
    except Exception as e:
        print(f"❌ 서버 연결 실패: {e}")
        print("서버가 실행 중인지 확인하세요 (uvicorn app.main:app)")
        return False


if __name__ == "__main__":
    print("=" * 60)
    print("이메일 구독 API 테스트")
    print("=" * 60)
    
    # 서버 상태 확인
    if not test_health_check():
        exit(1)
    
    # 1. 구독 신청
    test_subscribe()
    
    # 2. 이미 구독 중인 이메일로 재신청
    # test_already_subscribed()
    
    # 3. 구독 확인 (토큰은 이메일에서 확인하거나 DB에서 직접 조회)
    # test_confirm_subscription("your-subscription-token-here")
    
    # 4. 구독 취소 (토큰은 DB에서 직접 조회)
    # test_unsubscribe("your-unsubscribe-token-here")
    
    print("\n" + "=" * 60)
    print("테스트 완료")
    print("=" * 60)
    print("\n📝 다음 단계:")
    print("1. 이메일에서 구독 확인 링크를 클릭하세요")
    print("2. 데이터베이스를 확인하여 구독이 활성화되었는지 확인하세요")
    print("3. 수동 크롤링을 실행하여 알림이 발송되는지 테스트하세요")
    print("   curl -X POST http://localhost:8000/api/crawl/manual")
