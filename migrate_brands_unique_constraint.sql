-- 브랜드 테이블에 UNIQUE 제약 조건 추가
-- 같은 취수원에서 같은 이름의 브랜드가 중복 삽입되는 것을 방지

-- 1. 혹시 모를 중복 데이터 제거 (이미 삭제했지만 안전장치)
DELETE b1 FROM brands b1
INNER JOIN (
    SELECT water_source_id, 브랜드명, MIN(id) as min_id
    FROM brands
    GROUP BY water_source_id, 브랜드명
    HAVING COUNT(*) > 1
) b2
ON b1.water_source_id = b2.water_source_id 
AND b1.브랜드명 = b2.브랜드명
AND b1.id > b2.min_id;

-- 2. UNIQUE 제약 조건 추가
ALTER TABLE brands 
ADD UNIQUE KEY unique_brand_per_source (water_source_id, 브랜드명);

-- 확인
SHOW CREATE TABLE brands;
