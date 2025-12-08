#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
브랜드 매핑 데이터를 DB에 삽입하는 스크립트
프로젝트의 기존 database.py를 사용하여 SSH 터널링 지원
"""

import sys
import os
from pathlib import Path

# 프로젝트 루트를 Python path에 추가
project_root = Path(__file__).parent
sys.path.insert(0, str(project_root))

from app.database import get_sync_connection
from dotenv import load_dotenv

# 환경 변수 로드
load_dotenv()

# 브랜드 매핑 데이터
brand_mapping_data = {
    "㈜서윤": ["오대산샘물", "거평오대산샘물", "하이원샘물", "설악산샘물", "강원오대산샘물", "하이원사랑수"],
    "㈜설악생수": ["설악산청정암반수"],
    "티엠™": ["코리워터", "로미겐워터", "강원설청수", "새힘 4031", "다효수", "셀바인워터", "이뮤니프 미네랄워터", "미네랄워터", "이뮤니프 미네랄워터", "수미수 미네랄워터"],
    "강원샘물㈜": ["청정강원샘물", "강원설악샘물", "청정이동샘물", "설악산수"],
    "㈜동해샘물": ["동해약천골지장수", "지장청수", "동해지장수", "황토지장수", "네추럴 미네랄 워터 큐어링(Natural Mineral Water Curing)"],
    "㈜태백산수음료": ["어스워터", "만나워터", "약산"],
    "해태에이치티비㈜ 철원공장": ["휘오 다이아몬드", "휘오 다이아몬드EC", "휘오 순수"],
    "해태에이치티비㈜ 평창공장": ["강원평창수", "빼어날수", "640M봉평샘물", "봉평샘물640", "휘오 순수"],
    "㈜크리스탈샘물": ["크리스탈", "스마일365+수", "모닝캄", "NEW크리스탈", "물은NU", "동아오츠카 마신다", "탐나수", "탐라수", "탐사수", "탐사베이직수", "퓨어랜드 PURE 秀", "퓨어랜드 PURE SOO", "아쿠아시스"],
    "연천에프앤비": ["석수", "퓨리스", "동원샘물"],
    "씨에이치음료㈜ 양주공장": ["ICIS(아이시스)", "하늘샘"],
    "㈜포천그린": ["디포레", "풀무원샘물", "풀무원맛있는샘물", "이동크리스탈", "동원샘물"],
    "우리샘물㈜": ["기쁜우리샘물", "또니피앙", "레씨엠", "가평우리샘물", "탐사수", "와우워터", "이동크리스탈", "크리스탈", "모닝캄", "석수", "스파클", "풀무원샘물", "풀무원샘물 by Nature", "천년맑은산수"],
    "포천음료㈜": ["에브리워터", "TROPICOOL HANOM", "동원샘물", "일화 광천수", "ZERO", "가벼운샘", "마트명가 운악산 무병장水", "스파클", "맑은샘수"],
    "㈜포천샘물": ["스파클", "탐사수"],
    "산수음료㈜": ["산수", "아워워터", "고마운샘", "Everyday 산수", "i'm eco 산수", "re:i'm eco", "깨끗한샘", "가벼운샘", "re:고마운샘", "re:가벼운샘", "티니핑워터", "석수 18.9", "석수 13", "탐사수", "탐사수ECO", "쉐프큐 QNC 샘물", "CABINET DE POISSONS(캐비네 드 쁘아쏭)", "가야 g water", "가야 g water ECO", "나이스워터", "K119메가워터", "스파클", "풀무원샘물", "풀무원 워터루틴", "깨끗한수수SOOSOO"],
    "㈜동원에프앤비 연천공장": ["동원샘물", "미네마인", "Wake up beauty(웨이크업 뷰티)", "아쿠아포레", "마이워터(MY WATER)"],
    "㈜백학음료": ["Homeplus Signature 맑은샘물", "미네랄워터(MINERAL WATER)", "미네랄워터 ECO", "maxx 미네랄워터 ECO", "아이시스(ICIS)", "롯데DMZ", "아이시스 ECO", "PARADISE", "NATURAL MINERAL WATER", "내츄럴 미네랄 워터 ECO", "유어스(youus) DMZ맑은샘물"],
    "한국청정음료㈜": ["이동크리스탈", "몽베스트", "하루이리터", "트루워터", "오프라이스", "오프라이스 원보틀 에디션(기부용)", "맑은샘수", "깊을수록 ECO", "가야 g water", "가야 g water ECO"],
    "풀무원샘물㈜": ["풀무원샘물", "풀무원 워터루틴", "풀무원 퓨어", "풀무원오투 미니 워터팩", "풀무원샘물 리그린", "JUNCO SINCE 1997", "트루워터", "커클랜드시그니춰 먹는샘물"],
    "㈜포천에스엠": ["스파클"],
    "썬샤인㈜": ["-"],
    "㈜그린라이프": ["-"],
    "지리산청학동샘물㈜": ["풀무원샘물 by Nature", "풀무원샘물", "풀무원 맛있는 샘물", "석수", "퓨리스"],
    "㈜하이엠샘물": ["스파클", "동원샘물"],
    "㈜호진지리산보천": ["오(eau)", "쉐프큐QNC샘물", "지리산산수"],
    "샘소슬㈜": ["아이스워터", "ICE WATER", "풀무원 맛있는샘물", "풀무원샘물", "풀무원 워터루틴", "동아오츠카 마신다", "석수", "퓨리스", "스파클", "이디야워터"],
    "㈜순정샘물": ["다르다", "동원샘물", "동아오츠카 마신다"],
    "㈜엘케이샘물": ["지리산수워터", "ECO JIRISAN SOO WATER", "I'm 3H 지리산水", "ECO I'm 3H 지리산水", "지리산 산수", "화이트", "ECO화이트", "일화 광천수", "맑은나라 지리산水"],
    "㈜지리산산청샘물": ["화이트", "ECO 화이트", "맑은샘지리산", "지리산을 그대로 담은 뽀로로샘물", "숲속의 맑은샘물", "지리산 청정수", "깊을수록 ECO", "가야 g water", "가야 g water ECO", "가야 water"],
    "㈜동천수가야산샘물": ["가야산천년수", "천년수", "얼수", "나는물", "동아오츠카마신다"],
    "산청음료㈜": ["HEYROO미네랄워터", "youus(유어스) 맑은샘물", "미네랄워터ECO", "Homeplus Signature 맑은샘물", "맑은샘물", "하루이리터", "아이시스", "ICIS", "아이시스 8.0", "ICIS 8.0", "내몸애70%", "PARADISE"],
    "㈜화인바이오": ["지리산물하나", "지리산물하나eco", "미네랄워터(MINERAL WATER)", "YOUUS지리산맑은샘물", "지리산수(JIRISANSOO)", "NATURAL MINERAL WATER", "우리샘물수", "추신水", "지리산암반수", "㈜정상북한산리조트 네추럴미네랄워터", "정식품 지리산 심천수(深泉水)", "정식품 지리산 심천수", "유진샘물"],
    "㈜상원": ["아인수", "칠보석아인수", "PH8.4 SEVEN JEWELS", "일월아침에 水"],
    "㈜동천수 상주공장": ["천년수"],
    "㈜로진": ["소백산수", "물은감로수(물은GAMROSU)", "소백", "동원샘물", "미네마인", "이디야워터", "보고잇수(bogoitsu)", "Golden city"],
    "㈜청도샘물": ["푸르미네", "Icis(아이시스) 8.0", "Icis(아이시스)", "깊은산맑은물"],
    "㈜동천수": ["속리산 천년수", "가야 g water", "탐사수", "천년수", "동아오츠카 마신다", "가야 g water ECO"],
    "하이트진로음료㈜ 세종공장": ["석수", "퓨리스", "탐사수", "탐사베이직수", "탐사샘물", "미네랄워터", "알파수", "THE SHILLA", "코레버행복할수", "I*POP"],
    "㈜알프스샘물": ["스파클"],
    "㈜삼정샘물": ["스파클", "탐사수"],
    "㈜회천": ["지리산 천년수", "셀밸런水", "지리산 산수려", "New서울생수"],
    "미소음료㈜": ["석수", "퓨리스", "스파클", "순창샘물"],
    "맑은물㈜": ["하나로샘물", "하나로샘물 라벨프리", "주화산 천연수", "오감워터", "남양 천연수", "남양 天然水", "백미당 암반水"],
    "㈜동원에프앤비": ["동원샘물", "미네마인", "수풀림", "수풀림 무라벨", "동원샘물 무라벨", "동원샘물 프레시", "에이크업뷰티 무라벨"],
    "㈜로터스": ["순창샘물", "올스탠다드샘물", "행복지수", "로터스워터", "안심워터", "탐사수", "포프리워터", "보고잇수", "동아오츠카 마신다", "내장산샘물", "북청물장수", "상하샘물", "순수본"],
    "㈜더조은워터": ["깊을수록 ECO 무라벨", "깊을수록", "가야 g water", "가야 g water ECO"],
    "한국공항㈜": ["한진제주퓨어워터", "한진제주퓨어워터 디어베이비"],
    "제주특별자치도개발공사": ["제주삼다수"],
    "백봉음료": ["칠갑산맑은물", "설악산수", "금강샘물", "이동샘물"],
    "㈜금산인삼골": ["금산수", "가스트로 테이블", "PARADISE CITY", "Connect Terrace", "쟈뎅까페리얼워터큐브", "석수", "본도시락미네랄워터", "FOOD AVENUE LOTTE DEPARTMENT STORE"],
    "㈜대산에스엠": ["스파클", "스파클 넥라벨"],
    "하이트진로음료㈜ 천안공장": ["퓨리스", "석수", "퓨리스 넥라벨", "석수 넥라벨"],
    "㈜대정": ["스파클", "스파클 무라벨", "맛있는물", "탐사수 무라벨"],
    "㈜금천게르마늄": ["헬시언", "용천옥수", "웰아이수"],
    "씨에이치음료㈜": ["아이시스8.0"],
    "㈜동원F&B중부공장": ["동원샘물", "웨이크업뷰티", "수풀림", "샘이깊은물동원샘물", "동원샘물 미네마인", "마이워터(MY WATER)"],
    "하이트진로음료㈜": ["석수", "퓨리스", "진로석수", "미네랄워터", "탐사수", "탐사베이직수", "탐사샘물", "THE SHILLA", "낙원그룹", "I*POP", "서가앤쿡프레시워터", "물한빙", "코레버행복할수", "PARK HYATT SEOUL", "조이워터", "루솔"],
    "㈜울릉샘물": ["휘오 울림워터"]
}


def insert_brand_mapping_data():
    """브랜드 매핑 데이터를 DB에 삽입"""
    
    print("🔗 데이터베이스 연결 중...")
    print("   (SSH 터널링이 설정되어 있다면 자동으로 사용됩니다)")
    
    conn = get_sync_connection()
    cursor = conn.cursor()
    
    try:
        print("\n📊 데이터 삽입 시작...\n")
        
        # 1. 취수원 데이터 삽입
        print("1️⃣ 취수원 데이터 삽입 중...")
        water_source_count = 0
        
        for water_source in brand_mapping_data.keys():
            cursor.execute("""
                INSERT INTO water_sources (취수원업체명, 데이터출처, 최종확인일)
                VALUES (%s, %s, %s)
                ON DUPLICATE KEY UPDATE 
                    데이터출처 = VALUES(데이터출처),
                    최종확인일 = VALUES(최종확인일)
            """, (water_source, '식약처 품목제조신고 2024.12', '2024-12-08'))
            water_source_count += 1
        
        conn.commit()
        print(f"   ✅ 취수원 {water_source_count}개 삽입 완료\n")
        
        # 2. 브랜드 데이터 삽입
        print("2️⃣ 브랜드 데이터 삽입 중...")
        brand_count = 0
        
        for water_source, brands in brand_mapping_data.items():
            # 취수원 ID 조회
            cursor.execute(
                "SELECT id FROM water_sources WHERE 취수원업체명 = %s",
                (water_source,)
            )
            result = cursor.fetchone()
            
            if not result:
                print(f"   ⚠️ 경고: 취수원 '{water_source}'를 찾을 수 없습니다.")
                continue
            
            water_source_id = result['id']
            
            # 브랜드 삽입
            for brand in brands:
                cursor.execute("""
                    INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태)
                    VALUES (%s, %s, %s, %s, %s)
                    ON DUPLICATE KEY UPDATE
                        데이터출처 = VALUES(데이터출처),
                        최종확인일 = VALUES(최종확인일)
                """, (water_source_id, brand, '식약처 품목제조신고 2024.12', '2024-12-08', True))
                brand_count += 1
            
            # 진행 상황 표시
            if brand_count % 50 == 0:
                print(f"   진행 중... {brand_count}개 브랜드 삽입됨")
        
        conn.commit()
        print(f"   ✅ 브랜드 {brand_count}개 삽입 완료\n")
        
        # 3. 결과 확인
        print("3️⃣ 삽입 결과 확인 중...\n")
        
        cursor.execute("SELECT COUNT(*) as count FROM water_sources")
        total_water_sources = cursor.fetchone()['count']
        
        cursor.execute("SELECT COUNT(*) as count FROM brands")
        total_brands = cursor.fetchone()['count']
        
        print("=" * 50)
        print("✅ 데이터 삽입 완료!")
        print("=" * 50)
        print(f"📊 총 취수원 수: {total_water_sources}개")
        print(f"📊 총 브랜드 수: {total_brands}개")
        print("=" * 50)
        
        # 취수원별 브랜드 수 상위 10개
        print("\n🏆 브랜드가 많은 취수원 TOP 10:\n")
        cursor.execute("""
            SELECT 
                ws.취수원업체명,
                COUNT(b.id) as brand_count
            FROM water_sources ws
            LEFT JOIN brands b ON ws.id = b.water_source_id
            GROUP BY ws.id, ws.취수원업체명
            ORDER BY brand_count DESC
            LIMIT 10
        """)
        
        for i, row in enumerate(cursor.fetchall(), 1):
            print(f"   {i:2d}. {row['취수원업체명']}: {row['brand_count']}개 브랜드")
        
        print("\n✨ 성공적으로 완료되었습니다!")
        
    except Exception as e:
        conn.rollback()
        print(f"\n❌ 오류 발생: {e}")
        raise
    
    finally:
        cursor.close()
        conn.close()
        print("\n🔚 데이터베이스 연결 종료")


if __name__ == "__main__":
    try:
        insert_brand_mapping_data()
    except KeyboardInterrupt:
        print("\n\n⚠️ 사용자에 의해 중단되었습니다.")
    except Exception as e:
        print(f"\n❌ 실행 실패: {e}")
        sys.exit(1)
