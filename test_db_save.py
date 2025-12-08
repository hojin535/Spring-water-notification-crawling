#!/usr/bin/env python3
"""
DB 저장 프로세스 시뮬레이션 및 디버깅
"""
import sys
import os

# 프로젝트 루트를 Python 경로에 추가
sys.path.insert(0, '/Users/hojin/github/Spring-water/Spring-water-notification-crawling')

from app.crawlers.mcee_crawler import get_all_violations_with_details
from app.database import get_db
from app.db_models import ViolationRecord

print("="*50)
print("DB 저장 프로세스 시뮬레이션")
print("="*50)

# 크롤링 수행
detailed_violations = get_all_violations_with_details()
print(f"\n크롤링된 데이터: {len(detailed_violations)}개")

# DB 세션 생성
db = next(get_db())

try:
    # 현재 DB에 저장된 데이터 확인
    existing_records = db.query(ViolationRecord).all()
    print(f"현재 DB에 저장된 데이터: {len(existing_records)}개\n")
    
    if existing_records:
        print("기존 레코드:")
        for record in existing_records:
            print(f"  - {record.업체명} (board_id: {record.board_id})")
    
    # 크롤링 데이터 처리 시뮬레이션
    print(f"\n{'='*50}")
    print("크롤링 데이터 처리 시뮬레이션")
    print(f"{'='*50}\n")
    
    current_board_ids = set()
    saved_count = 0
    updated_count = 0
    
    for item in detailed_violations:
        # board_id 생성
        board_id = f"{item.get('업체명', '')}_{item.get('처분일자', '')}".replace(" ", "_")
        current_board_ids.add(board_id)
        
        print(f"처리 중: {item.get('업체명')} (board_id: {board_id})")
        
        # 기존 레코드 확인
        existing = db.query(ViolationRecord).filter(
            ViolationRecord.board_id == board_id
        ).first()
        
        if existing:
            print(f"  → 기존 레코드 발견! 업데이트됨")
            updated_count += 1
        else:
            print(f"  → 새 레코드! 추가 예정")
            saved_count += 1
    
    print(f"\n{'='*50}")
    print(f"처리 결과 예상:")
    print(f"  - 새로 추가: {saved_count}개")
    print(f"  - 업데이트: {updated_count}개")
    print(f"{'='*50}")
    
    # 삭제될 레코드 확인
    print(f"\n{'='*50}")
    print("삭제 예정 레코드 확인")
    print(f"{'='*50}\n")
    
    records_to_delete = []
    for record in existing_records:
        if record.board_id not in current_board_ids:
            records_to_delete.append(record)
            print(f"  - {record.업체명} (board_id: {record.board_id})")
    
    if not records_to_delete:
        print("  (없음)")
    
    print(f"\n삭제 예정: {len(records_to_delete)}개")
    
finally:
    db.close()
