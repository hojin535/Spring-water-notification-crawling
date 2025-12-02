#!/usr/bin/env python3
"""
크롤링 테스트 스크립트
"""
import sys
import os

# 프로젝트 루트를 Python 경로에 추가
sys.path.insert(0, '/Users/hojin/github/Spring-water/Spring-water-notification-crawling')

from app.crawlers.mcee_crawler import get_violation_list, get_all_violations_with_details

print("="*50)
print("테스트: 위반 목록 크롤링")
print("="*50)

try:
    violations = get_violation_list()
    print(f"\n✅ 성공: {len(violations)}개의 위반 항목 발견")
    
    if violations:
        print("\n첫 번째 항목:")
        print(violations[0])
        
        print("\n"+"="*50)
        print("테스트: 상세 정보 크롤링 (첫 3개만)")
        print("="*50)
        
        # 첫 3개만 테스트
        from app.crawlers.mcee_crawler import get_violation_detail
        for i, item in enumerate(violations[:3], 1):
            if item.get('상세URL'):
                print(f"\n{i}. {item['업체명']} 크롤링 중...")
                detail = get_violation_detail(item['상세URL'])
                print(f"   ✅ 완료: {len(detail)} 필드")
            
except Exception as e:
    print(f"\n❌ 오류 발생: {e}")
    import traceback
    traceback.print_exc()
