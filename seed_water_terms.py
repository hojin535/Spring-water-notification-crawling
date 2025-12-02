"""
수질 검사 용어 사전 데이터 시딩 스크립트
"""
from app.database import SessionLocal
from app.db_models import WaterTerm


# 준비된 원본 데이터 (Nested JSON)
raw_data = [
    {
        "category": "microbe",
        "category_name": "세균/미생물",
        "risk_level": "high",
        "items": {
            "일반세균(저온)": "물속에 사는 일반적인 균이에요. 너무 많으면 물이 오염됐다는 뜻이에요.",
            "일반세균(중온)": "물속에 사는 일반적인 균이에요. 깨끗한 물에는 아주 적어야 해요.",
            "총대장균군": "배탈을 일으키는 세균 식구들이에요. 절대 있으면 안 돼요!",
            "분원성연쇄상구균": "동물의 배설물에서 나오는 더러운 균이에요.",
            "녹농균": "몸이 약한 사람에게 병을 일으킬 수 있는 나쁜 균이에요.",
            "살모넬라": "심한 식중독과 장염을 일으키는 아주 위험한 균이에요.",
            "쉬겔라": "이질이라는 무서운 전염병을 일으키는 균이에요."
        }
    },
    {
        "category": "heavy_metal",
        "category_name": "중금속/유해물질",
        "risk_level": "critical",
        "items": {
            "납": "몸 밖으로 잘 빠져나가지 않고 뇌와 뼈를 아프게 하는 무서운 금속이에요.",
            "수은": "신경을 마비시키는 아주 위험한 독성 금속이에요.",
            "비소": "옛날에 사약으로 쓸 만큼 독성이 강한 물질이에요.",
            "카드뮴": "뼈를 약하게 만드는 나쁜 금속이에요.",
            "크롬": "피부와 몸속 장기에 나쁜 영향을 주는 금속이에요.",
            "시안": "청산가리라고도 불리는 아주 위험한 독이에요.",
            "불소": "치약 성분이지만, 마시는 물에 너무 많으면 이빨에 얼룩이 생겨요.",
            "우라늄": "땅속 광물에서 나오는 방사성 물질로 신장에 좋지 않아요."
        }
    },
    {
        "category": "chemical",
        "category_name": "화학물질/농약",
        "risk_level": "warning",
        "items": {
            "페놀": "소독약 냄새가 나게 하는 물질이에요. 불쾌하고 몸에도 나빠요.",
            "벤젠": "휘발유 냄새가 나는 물질로, 암을 일으킬 수 있어요.",
            "톨루엔": "페인트 냄새가 나는 물질이에요.",
            "다이아지논": "벌레를 잡는 농약 성분이에요. 물에 들어가면 안 돼요.",
            "파라티온": "아주 독한 농약 성분이에요.",
            "질산성 질소": "비료나 하수물이 섞이면 생겨요. 아기들이 숨 쉬는 걸 방해할 수 있어요.",
            "암모니아성 질소": "동물의 배설물이나 오염된 물이 섞였을 때 나타나요."
        }
    },
    {
        "category": "aesthetic",
        "category_name": "맛/냄새/심미적 영향",
        "risk_level": "check",
        "items": {
            "경도": "물에 미네랄(칼슘, 마그네슘)이 얼마나 녹아있는지 알려줘요. 너무 높으면 물맛이 텁텁해요.",
            "탁도": "물이 맑은지, 흙탕물처럼 뿌연지 확인하는 거예요.",
            "색도": "물에 색깔이 있는지 보는 거예요. 물은 투명해야 해요.",
            "수소이온농도": "물이 산성인지 알칼리성인지 확인하는 거예요(pH).",
            "맛": "물이 이상한 맛이 나지 않는지 확인해요.",
            "냄새": "물이 이상한 냄새가 나지 않는지 확인해요.",
            "철": "녹물이 나오는지 확인하는 거예요. 많으면 쇠 냄새가 나요.",
            "망간": "많으면 물맛을 떨어뜨리고 빨래에 검은 물을 들게 해요.",
            "염소이온": "바닷물이 섞였거나 하수가 섞였는지 확인할 때 봐요."
        }
    }
]


def main():
    """수질 검사 용어 데이터를 DB에 삽입"""
    print('🌱 수질 검사 사전 데이터 시딩을 시작합니다...')
    
    # DB 세션 생성
    db = SessionLocal()
    
    try:
        for group in raw_data:
            category = group["category"]
            category_name = group["category_name"]
            risk_level = group["risk_level"]
            items = group["items"]
            
            # items 딕셔너리를 반복하며 DB에 저장
            for term_key, description in items.items():
                # 기존 데이터가 있는지 확인
                existing_term = db.query(WaterTerm).filter(WaterTerm.term == term_key).first()
                
                if existing_term:
                    # 이미 존재하면 건너뛰기 (업데이트하지 않음)
                    print(f'⏭️  이미 존재함 (건너뜀): {term_key}')
                else:
                    # 새로 생성
                    new_term = WaterTerm(
                        term=term_key,
                        description=description,
                        category=category,
                        category_name=category_name,
                        risk_level=risk_level,
                        source='manual'
                    )
                    db.add(new_term)
                    print(f'✅ 생성됨: {term_key}')
        
        # 커밋
        db.commit()
        print('✨ 모든 데이터가 DB에 저장되었습니다!')
        
        # 저장된 데이터 확인
        total_count = db.query(WaterTerm).count()
        print(f'\n📊 총 {total_count}개의 수질 검사 용어가 저장되었습니다.')
        
        # 카테고리별 개수 출력
        print('\n📋 카테고리별 개수:')
        for group in raw_data:
            count = db.query(WaterTerm).filter(WaterTerm.category == group["category"]).count()
            print(f'  - {group["category_name"]}: {count}개')
            
    except Exception as e:
        print(f'❌ 오류 발생: {e}')
        db.rollback()
        raise
    finally:
        db.close()


if __name__ == "__main__":
    main()
