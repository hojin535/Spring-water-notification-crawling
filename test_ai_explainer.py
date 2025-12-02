"""
AI 설명 캐싱 기능 테스트
"""
import requests
import json
import time

# 테스트 데이터
test_data = {
    "처분명": "자가품질검사 일부 미실시 등",
    "위반내용": """자가품질검사 일부 미실시
무기물질 함량 표시기준을 위반한 먹는 샘물을 판매제조등 영업상 사용
취수정지 1개월(1호정)
1호정 원수 수질기준초과
총대장균군 : 검출 (기준 : 불검출)
일반세균(저온) : 37CFU/ml (기준 : 20CFU/mL 이하)"""
}

url = "http://localhost:8000/api/violations/explain"

print("🧪 AI 설명 캐싱 기능 테스트")
print("=" * 70)

# 첫 번째 호출 (캐시 미스 - AI 호출)
print("\n📞 첫 번째 호출 (캐시 미스 - AI API 호출 예상)")
start_time = time.time()
try:
    response1 = requests.post(url, json=test_data, timeout=30)
    elapsed1 = time.time() - start_time
    
    if response1.status_code == 200:
        result1 = response1.json()
        print(f"✅ 성공! (소요 시간: {elapsed1:.2f}초)")
        print(f"📝 설명: {result1['easy_explanation'][:100]}...")
        print(f"📚 관련 용어: {len(result1.get('related_terms', []))}개")
        
        # from_cache 키 확인 (응답에 포함되어 있지 않을 수도 있음)
        if 'from_cache' in result1:
            print(f"🗄️ 캐시 사용: {result1['from_cache']}")
    else:
        print(f"❌ 오류 (Status: {response1.status_code})")
        print(response1.text)
        exit(1)
except Exception as e:
    print(f"❌ 오류: {e}")
    exit(1)

print("\n" + "=" * 70)

# 두 번째 호출 (캐시 히트 - DB에서 가져오기)
print("\n📞 두 번째 호출 (캐시 히트 - DB에서 즉시 반환 예상)")
start_time = time.time()
try:
    response2 = requests.post(url, json=test_data, timeout=30)
    elapsed2 = time.time() - start_time
    
    if response2.status_code == 200:
        result2 = response2.json()
        print(f"✅ 성공! (소요 시간: {elapsed2:.2f}초)")
        print(f"📝 설명: {result2['easy_explanation'][:100]}...")
        print(f"📚 관련 용어: {len(result2.get('related_terms', []))}개")
        
        if 'from_cache' in result2:
            print(f"🗄️ 캐시 사용: {result2['from_cache']}")
    else:
        print(f"❌ 오류 (Status: {response2.status_code})")
        print(response2.text)
        exit(1)
except Exception as e:
    print(f"❌ 오류: {e}")
    exit(1)

print("\n" + "=" * 70)

# 성능 비교
print("\n📊 성능 비교")
print(f"첫 번째 호출 (AI): {elapsed1:.2f}초")
print(f"두 번째 호출 (캐시): {elapsed2:.2f}초")
if elapsed1 > elapsed2:
    speedup = elapsed1 / elapsed2
    print(f"⚡ 캐시가 {speedup:.1f}배 더 빠릅니다!")
else:
    print("⚠️ 두 번째 호출이 더 느림 (캐시가 작동하지 않았을 수 있음)")

print("\n" + "=" * 70)
print("\n✅ 테스트 완료!")
