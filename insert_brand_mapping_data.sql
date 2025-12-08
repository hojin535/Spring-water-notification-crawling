-- 브랜드 매핑 데이터 삽입 스크립트
-- 🎓 교육용 프로젝트 데이터
use Spring_water_notification;
-- create table mcee_violations; 
-- select *
-- from mcee_violations;
-- ============================================
-- 1. 취수원 데이터 삽입
-- ============================================

INSERT INTO water_sources (취수원업체명, 데이터출처, 최종확인일) VALUES
('㈜서윤', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜설악생수', '식약처 품목제조신고 2024.12', '2024-12-08'),
('티엠™', '식약처 품목제조신고 2024.12', '2024-12-08'),
('강원샘물㈜', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜동해샘물', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜태백산수음료', '식약처 품목제조신고 2024.12', '2024-12-08'),
('해태에이치티비㈜ 철원공장', '식약처 품목제조신고 2024.12', '2024-12-08'),
('해태에이치티비㈜ 평창공장', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜크리스탈샘물', '식약처 품목제조신고 2024.12', '2024-12-08'),
('연천에프앤비', '식약처 품목제조신고 2024.12', '2024-12-08'),
('씨에이치음료㈜ 양주공장', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜포천그린', '식약처 품목제조신고 2024.12', '2024-12-08'),
('우리샘물㈜', '식약처 품목제조신고 2024.12', '2024-12-08'),
('포천음료㈜', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜포천샘물', '식약처 품목제조신고 2024.12', '2024-12-08'),
('산수음료㈜', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜동원에프앤비 연천공장', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜백학음료', '식약처 품목제조신고 2024.12', '2024-12-08'),
('한국청정음료㈜', '식약처 품목제조신고 2024.12', '2024-12-08'),
('풀무원샘물㈜', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜포천에스엠', '식약처 품목제조신고 2024.12', '2024-12-08'),
('썬샤인㈜', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜그린라이프', '식약처 품목제조신고 2024.12', '2024-12-08'),
('지리산청학동샘물㈜', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜하이엠샘물', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜호진지리산보천', '식약처 품목제조신고 2024.12', '2024-12-08'),
('샘소슬㈜', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜순정샘물', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜엘케이샘물', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜지리산산청샘물', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜동천수가야산샘물', '식약처 품목제조신고 2024.12', '2024-12-08'),
('산청음료㈜', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜화인바이오', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜상원', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜동천수 상주공장', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜로진', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜청도샘물', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜동천수', '식약처 품목제조신고 2024.12', '2024-12-08'),
('하이트진로음료㈜ 세종공장', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜알프스샘물', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜삼정샘물', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜회천', '식약처 품목제조신고 2024.12', '2024-12-08'),
('미소음료㈜', '식약처 품목제조신고 2024.12', '2024-12-08'),
('맑은물㈜', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜동원에프앤비', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜로터스', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜더조은워터', '식약처 품목제조신고 2024.12', '2024-12-08'),
('한국공항㈜', '식약처 품목제조신고 2024.12', '2024-12-08'),
('제주특별자치도개발공사', '식약처 품목제조신고 2024.12', '2024-12-08'),
('백봉음료', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜금산인삼골', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜대산에스엠', '식약처 품목제조신고 2024.12', '2024-12-08'),
('하이트진로음료㈜ 천안공장', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜대정', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜금천게르마늄', '식약처 품목제조신고 2024.12', '2024-12-08'),
('씨에이치음료㈜', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜동원F&B중부공장', '식약처 품목제조신고 2024.12', '2024-12-08'),
('하이트진로음료㈜', '식약처 품목제조신고 2024.12', '2024-12-08'),
('㈜울릉샘물', '식약처 품목제조신고 2024.12', '2024-12-08');
ON DUPLICATE KEY UPDATE 
    데이터출처 = VALUES(데이터출처),
    최종확인일 = VALUES(최종확인일);

-- ============================================
-- 2. 브랜드 데이터 삽입
-- ============================================

-- ㈜서윤
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '오대산샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜서윤';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '거평오대산샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜서윤';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '하이원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜서윤';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '설악산샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜서윤';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '강원오대산샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜서윤';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '하이원사랑수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜서윤';

-- ㈜설악생수
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '설악산청정암반수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜설악생수';

-- 티엠™
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '코리워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '티엠™';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '로미겐워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '티엠™';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '강원설청수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '티엠™';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '새힘 4031', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '티엠™';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '다효수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '티엠™';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '셀바인워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '티엠™';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '이뮤니프 미네랄워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '티엠™';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '미네랄워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '티엠™';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '이뮤니프 미네랄워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '티엠™';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '수미수 미네랄워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '티엠™';

-- 강원샘물㈜
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '청정강원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '강원샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '강원설악샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '강원샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '청정이동샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '강원샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '설악산수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '강원샘물㈜';

-- ㈜동해샘물
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동해약천골지장수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동해샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '지장청수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동해샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동해지장수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동해샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '황토지장수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동해샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '네추럴 미네랄 워터 큐어링(Natural Mineral Water Curing)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동해샘물';

-- ㈜태백산수음료
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '어스워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜태백산수음료';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '만나워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜태백산수음료';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '약산', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜태백산수음료';

-- 해태에이치티비㈜ 철원공장
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '휘오 다이아몬드', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '해태에이치티비㈜ 철원공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '휘오 다이아몬드EC', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '해태에이치티비㈜ 철원공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '휘오 순수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '해태에이치티비㈜ 철원공장';

-- 해태에이치티비㈜ 평창공장
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '강원평창수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '해태에이치티비㈜ 평창공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '빼어날수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '해태에이치티비㈜ 평창공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '640M봉평샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '해태에이치티비㈜ 평창공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '봉평샘물640', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '해태에이치티비㈜ 평창공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '휘오 순수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '해태에이치티비㈜ 평창공장';

-- ㈜크리스탈샘물
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '크리스탈', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜크리스탈샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '스마일365+수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜크리스탈샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '모닝캄', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜크리스탈샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'NEW크리스탈', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜크리스탈샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '물은NU', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜크리스탈샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동아오츠카 마신다', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜크리스탈샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐나수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜크리스탈샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐라수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜크리스탈샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜크리스탈샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사베이직수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜크리스탈샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '퓨어랜드 PURE 秀', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜크리스탈샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '퓨어랜드 PURE SOO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜크리스탈샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '아쿠아시스', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜크리스탈샘물';

-- 연천에프앤비
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '석수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '연천에프앤비';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '퓨리스', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '연천에프앤비';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '연천에프앤비';

-- 씨에이치음료㈜ 양주공장
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'ICIS(아이시스)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '씨에이치음료㈜ 양주공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '하늘샘', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '씨에이치음료㈜ 양주공장';

-- ㈜포천그린
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '디포레', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜포천그린';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜포천그린';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원맛있는샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜포천그린';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '이동크리스탈', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜포천그린';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜포천그린';

-- 우리샘물㈜
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '기쁜우리샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '우리샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '또니피앙', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '우리샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '레씨엠', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '우리샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가평우리샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '우리샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '우리샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '와우워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '우리샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '이동크리스탈', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '우리샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '크리스탈', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '우리샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '모닝캄', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '우리샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '석수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '우리샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '스파클', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '우리샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '우리샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원샘물 by Nature', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '우리샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '천년맑은산수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '우리샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가평우리샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '우리샘물㈜';

-- 포천음료㈜
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '에브리워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '포천음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'TROPICOOL HANOM', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '포천음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '포천음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '일화 광천수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '포천음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'ZERO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '포천음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가벼운샘', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '포천음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '마트명가 운악산 무병장水', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '포천음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '스파클', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '포천음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '맑은샘수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '포천음료㈜';

-- ㈜포천샘물
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '스파클', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜포천샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜포천샘물';

-- 산수음료㈜
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '산수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '아워워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '고마운샘', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'Everyday 산수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'i''m eco 산수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 're:i''m eco', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '깨끗한샘', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가벼운샘', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 're:고마운샘', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 're:가벼운샘', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '티니핑워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '석수 18.9', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '석수 13', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사수ECO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '쉐프큐 QNC 샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'CABINET DE POISSONS(캐비네 드 쁘아쏭)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가야 g water', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가야 g water ECO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '나이스워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'K119메가워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '스파클', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원 워터루틴', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '깨끗한수수SOOSOO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산수음료㈜';

-- ㈜동원에프앤비 연천공장
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원에프앤비 연천공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '미네마인', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원에프앤비 연천공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'Wake up beauty(웨이크업 뷰티)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원에프앤비 연천공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '아쿠아포레', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원에프앤비 연천공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '마이워터(MY WATER)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원에프앤비 연천공장';

-- ㈜백학음료
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'Homeplus Signature 맑은샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜백학음료';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '미네랄워터(MINERAL WATER)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜백학음료';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '미네랄워터 ECO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜백학음료';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'maxx 미네랄워터 ECO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜백학음료';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '아이시스(ICIS)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜백학음료';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '롯데DMZ', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜백학음료';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '아이시스 ECO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜백학음료';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'PARADISE', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜백학음료';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'NATURAL MINERAL WATER', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜백학음료';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '내츄럴 미네랄 워터 ECO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜백학음료';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '유어스(youus) DMZ맑은샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜백학음료';

-- 한국청정음료㈜
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '이동크리스탈', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '한국청정음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '몽베스트', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '한국청정음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '하루이리터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '한국청정음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '트루워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '한국청정음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '오프라이스', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '한국청정음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '오프라이스 원보틀 에디션(기부용)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '한국청정음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '맑은샘수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '한국청정음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '깊을수록 ECO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '한국청정음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가야 g water', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '한국청정음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가야 g water ECO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '한국청정음료㈜';

-- 풀무원샘물㈜
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '풀무원샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원 워터루틴', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '풀무원샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원 퓨어', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '풀무원샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원오투 미니 워터팩', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '풀무원샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원샘물 리그린', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '풀무원샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'JUNCO SINCE 1997', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '풀무원샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '트루워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '풀무원샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '커클랜드시그니춰 먹는샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '풀무원샘물㈜';

-- ㈜포천에스엠
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '스파클', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜포천에스엠';

-- 썬샤인㈜
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '-', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '썬샤인㈜';

-- ㈜그린라이프
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '-', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜그린라이프';

-- 지리산청학동샘물㈜
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원샘물 by Nature', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '지리산청학동샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '지리산청학동샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원 맛있는 샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '지리산청학동샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '석수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '지리산청학동샘물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '퓨리스', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '지리산청학동샘물㈜';

-- ㈜하이엠샘물
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '스파클', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜하이엠샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜하이엠샘물';

-- ㈜호진지리산보천
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '오(eau)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜호진지리산보천';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '쉐프큐QNC샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜호진지리산보천';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '지리산산수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜호진지리산보천';

-- 샘소슬㈜
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '아이스워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '샘소슬㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'ICE WATER', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '샘소슬㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원 맛있는샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '샘소슬㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '샘소슬㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '풀무원 워터루틴', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '샘소슬㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동아오츠카 마신다', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '샘소슬㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '석수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '샘소슬㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '퓨리스', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '샘소슬㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '스파클', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '샘소슬㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '이디야워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '샘소슬㈜';

-- ㈜순정샘물
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '다르다', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜순정샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜순정샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동아오츠카 마신다', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜순정샘물';

-- ㈜엘케이샘물
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '지리산수워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜엘케이샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'ECO JIRISAN SOO WATER', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜엘케이샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'I''m 3H 지리산水', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜엘케이샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'ECO I''m 3H 지리산水', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜엘케이샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '지리산 산수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜엘케이샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '화이트', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜엘케이샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'ECO화이트', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜엘케이샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '일화 광천수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜엘케이샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '맑은나라 지리산水', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜엘케이샘물';

-- ㈜지리산산청샘물
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '화이트', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜지리산산청샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'ECO 화이트', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜지리산산청샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '맑은샘지리산', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜지리산산청샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '지리산을 그대로 담은 뽀로로샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜지리산산청샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '숲속의 맑은샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜지리산산청샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '지리산 청정수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜지리산산청샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '깊을수록 ECO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜지리산산청샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가야 g water', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜지리산산청샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가야 g water ECO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜지리산산청샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가야 water', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜지리산산청샘물';

-- ㈜동천수가야산샘물
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가야산천년수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동천수가야산샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '천년수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동천수가야산샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '얼수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동천수가야산샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '나는물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동천수가야산샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동아오츠카마신다', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동천수가야산샘물';

-- 산청음료㈜
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'HEYROO미네랄워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산청음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'youus(유어스) 맑은샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산청음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '미네랄워터ECO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산청음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'Homeplus Signature 맑은샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산청음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '맑은샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산청음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '하루이리터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산청음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '아이시스', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산청음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'ICIS', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산청음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '아이시스 8.0', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산청음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'ICIS 8.0', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산청음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '내몸애70%', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산청음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'PARADISE', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '산청음료㈜';

-- ㈜화인바이오
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '지리산물하나', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜화인바이오';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '지리산물하나eco', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜화인바이오';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '미네랄워터(MINERAL WATER)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜화인바이오';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'YOUUS지리산맑은샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜화인바이오';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '지리산수(JIRISANSOO)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜화인바이오';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'NATURAL MINERAL WATER', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜화인바이오';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '우리샘물수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜화인바이오';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '추신水', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜화인바이오';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '지리산암반수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜화인바이오';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '㈜정상북한산리조트 네추럴미네랄워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜화인바이오';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '정식품 지리산 심천수(深泉水)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜화인바이오';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '정식품 지리산 심천수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜화인바이오';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '유진샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜화인바이오';

-- ㈜상원
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '아인수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜상원';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '칠보석아인수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜상원';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'PH8.4 SEVEN JEWELS', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜상원';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '일월아침에 水', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜상원';

-- ㈜동천수 상주공장
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '천년수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동천수 상주공장';

-- ㈜로진
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '소백산수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로진';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '물은감로수(물은GAMROSU)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로진';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '소백', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로진';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로진';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '미네마인', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로진';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '이디야워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로진';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '보고잇수(bogoitsu)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로진';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'Golden city', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로진';

-- ㈜청도샘물
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '푸르미네', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜청도샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'Icis(아이시스) 8.0', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜청도샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'Icis(아이시스)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜청도샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '깊은산맑은물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜청도샘물';

-- ㈜동천수
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '속리산 천년수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동천수';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가야 g water', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동천수';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동천수';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '천년수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동천수';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동아오츠카 마신다', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동천수';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가야 g water ECO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동천수';

-- 하이트진로음료㈜ 세종공장
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '석수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜ 세종공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '퓨리스', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜ 세종공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜ 세종공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사베이직수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜ 세종공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜ 세종공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '미네랄워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜ 세종공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '알파수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜ 세종공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'THE SHILLA', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜ 세종공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '코레버행복할수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜ 세종공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'I*POP', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜ 세종공장';

-- ㈜알프스샘물
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '스파클', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜알프스샘물';

-- ㈜삼정샘물
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '스파클', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜삼정샘물';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜삼정샘물';

-- ㈜회천
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '지리산 천년수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜회천';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '셀밸런水', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜회천';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '지리산 산수려', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜회천';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'New서울생수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜회천';

-- 미소음료㈜
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '석수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '미소음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '퓨리스', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '미소음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '스파클', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '미소음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '순창샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '미소음료㈜';

-- 맑은물㈜
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '하나로샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '맑은물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '하나로샘물 라벨프리', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '맑은물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '주화산 천연수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '맑은물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '오감워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '맑은물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '남양 천연수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '맑은물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '남양 天然水', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '맑은물㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '백미당 암반水', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '맑은물㈜';

-- ㈜동원에프앤비
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원에프앤비';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '미네마인', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원에프앤비';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '수풀림', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원에프앤비';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '수풀림 무라벨', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원에프앤비';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동원샘물 무라벨', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원에프앤비';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동원샘물 프레시', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원에프앤비';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '에이크업뷰티 무라벨', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원에프앤비';

-- ㈜로터스
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '순창샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로터스';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '올스탠다드샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로터스';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '행복지수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로터스';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '로터스워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로터스';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '안심워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로터스';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로터스';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '포프리워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로터스';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '보고잇수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로터스';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동아오츠카 마신다', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로터스';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '내장산샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로터스';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '북청물장수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로터스';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '상하샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로터스';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '순수본', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜로터스';

-- ㈜더조은워터
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '깊을수록 ECO 무라벨', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜더조은워터';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '깊을수록', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜더조은워터';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가야 g water', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜더조은워터';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가야 g water ECO', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜더조은워터';

-- 한국공항㈜
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '한진제주퓨어워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '한국공항㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '한진제주퓨어워터 디어베이비', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '한국공항㈜';

-- 제주특별자치도개발공사
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '제주삼다수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '제주특별자치도개발공사';

-- 백봉음료
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '칠갑산맑은물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '백봉음료';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '설악산수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '백봉음료';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '금강샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '백봉음료';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '이동샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '백봉음료';

-- ㈜금산인삼골
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '금산수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜금산인삼골';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '가스트로 테이블', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜금산인삼골';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'PARADISE CITY', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜금산인삼골';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'Connect Terrace', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜금산인삼골';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '쟈뎅까페리얼워터큐브', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜금산인삼골';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '석수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜금산인삼골';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '본도시락미네랄워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜금산인삼골';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'FOOD AVENUE LOTTE DEPARTMENT STORE', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜금산인삼골';

-- ㈜대산에스엠
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '스파클', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜대산에스엠';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '스파클 넥라벨', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜대산에스엠';

-- 하이트진로음료㈜ 천안공장
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '퓨리스', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜ 천안공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '석수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜ 천안공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '퓨리스 넥라벨', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜ 천안공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '석수 넥라벨', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜ 천안공장';

-- ㈜대정
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '스파클', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜대정';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '스파클 무라벨', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜대정';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '맛있는물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜대정';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사수 무라벨', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜대정';

-- ㈜금천게르마늄
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '헬시언', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜금천게르마늄';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '용천옥수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜금천게르마늄';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '웰아이수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜금천게르마늄';

-- 씨에이치음료㈜
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '아이시스8.0', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '씨에이치음료㈜';

-- ㈜동원F&B중부공장
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원F&B중부공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '웨이크업뷰티', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원F&B중부공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '수풀림', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원F&B중부공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '샘이깊은물동원샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원F&B중부공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '동원샘물 미네마인', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원F&B중부공장';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '마이워터(MY WATER)', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜동원F&B중부공장';

-- 하이트진로음료㈜
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '석수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '퓨리스', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '진로석수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '미네랄워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사베이직수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '탐사샘물', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'THE SHILLA', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '낙원그룹', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'I*POP', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '서가앤쿡프레시워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '물한빙', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '코레버행복할수', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, 'PARK HYATT SEOUL', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '조이워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '루솔', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '하이트진로음료㈜';

-- ㈜울릉샘물
INSERT INTO brands (water_source_id, 브랜드명, 데이터출처, 최종확인일, 활성상태) 
SELECT id, '휘오 울림워터', '식약처 품목제조신고 2024.12', '2024-12-08', TRUE FROM water_sources WHERE 취수원업체명 = '㈜울릉샘물';

-- ============================================
-- 3. 데이터 확인
-- ============================================

SELECT '=== 취수원 데이터 삽입 완료 ===' as 상태;
SELECT COUNT(*) as 취수원수 FROM water_sources;

SELECT '=== 브랜드 데이터 삽입 완료 ===' as 상태;
SELECT COUNT(*) as 브랜드수 FROM brands;

-- 취수원별 브랜드 수 확인
SELECT 
    ws.취수원업체명,
    COUNT(b.id) as 브랜드수
FROM water_sources ws
LEFT JOIN brands b ON ws.id = b.water_source_id
GROUP BY ws.id, ws.취수원업체명
ORDER BY 브랜드수 DESC
LIMIT 20;
