#!/usr/bin/env python3
"""
상세 크롤링 테스트 및 디버깅
"""
import sys
import os
import json

# 프로젝트 루트를 Python 경로에 추가
sys.path.insert(0, '/Users/hojin/github/Spring-water/Spring-water-notification-crawling')

from app.crawlers.mcee_crawler import get_all_violations_with_details

print("="*50)
print("테스트: 전체 상세 정보 크롤링")
print("="*50)

try:
    detailed_violations = get_all_violations_with_details()
    print(f"\n✅ 성공: {len(detailed_violations)}개의 상세 위반 항목 발견\n")
    
    if detailed_violations:
        for i, item in enumerate(detailed_violations, 1):
            print(f"\n{'='*50}")
            print(f"항목 {i}")
            print(f"{'='*50}")
            print(json.dumps(item, ensure_ascii=False, indent=2))
            
            # board_id 생성 확인
            board_id = f"{item.get('업체명', '')}_{item.get('처분일자', '')}".replace(" ", "_")
            print(f"\n생성될 board_id: {board_id}")
            
except Exception as e:
    print(f"\n❌ 오류 발생: {e}")
    import traceback
    traceback.print_exc()
