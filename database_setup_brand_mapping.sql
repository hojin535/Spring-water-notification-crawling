-- 브랜드 매핑 데이터베이스 스크립트
-- 취수원 - 브랜드 1:N 관계 매핑

USE mcee_violations;

-- ============================================
-- 1. 취수원 테이블 (1)
-- ============================================
CREATE TABLE IF NOT EXISTS water_sources (
    -- 기본 키
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '자동 증가 ID',
    
    -- 취수원 정보
    취수원업체명 VARCHAR(200) NOT NULL UNIQUE COMMENT '취수원 업체명 (violations 테이블의 업체명과 매칭)',
    취수원소재지 VARCHAR(300) COMMENT '취수원 소재지',
    취수원종류 VARCHAR(50) COMMENT '취수원 종류 (지하수, 암반수 등)',
    허가번호 VARCHAR(100) COMMENT '먹는물 제조업 허가번호',
    
    -- 메타 정보
    데이터출처 VARCHAR(200) COMMENT '데이터 출처 (예: 식약처 품목제조신고 2024.12)',
    최종확인일 DATE COMMENT '데이터 최종 확인 날짜',
    비고 TEXT COMMENT '기타 비고사항',
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    
    -- 인덱스
    INDEX idx_취수원업체명 (취수원업체명),
    INDEX idx_취수원소재지 (취수원소재지)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='취수원 정보 테이블';

-- ============================================
-- 2. 브랜드 테이블 (N)
-- ============================================
CREATE TABLE IF NOT EXISTS brands (
    -- 기본 키
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '자동 증가 ID',
    
    -- 외래 키 (취수원 1:N 관계)
    water_source_id INT NOT NULL COMMENT '취수원 ID (foreign key)',
    
    -- 브랜드 정보
    브랜드명 VARCHAR(200) NOT NULL COMMENT '브랜드명 (예: 제주삼다수)',
    제조사 VARCHAR(200) COMMENT '제조사명 (예: 제주특별자치도개발공사)',
    대표제품명 VARCHAR(200) COMMENT '대표 제품명',
    제품라인 TEXT COMMENT '제품 라인업 (JSON 배열 형태로 저장 가능)',
    
    -- 추가 정보
    브랜드로고URL VARCHAR(500) COMMENT '브랜드 로고 이미지 URL',
    공식홈페이지 VARCHAR(500) COMMENT '공식 홈페이지 URL',
    시장점유율 DECIMAL(5,2) COMMENT '시장 점유율 (%)',
    연간생산량 BIGINT COMMENT '연간 생산량 (리터)',
    
    -- 메타 정보
    데이터출처 VARCHAR(200) COMMENT '데이터 출처',
    최종확인일 DATE COMMENT '데이터 최종 확인 날짜',
    활성상태 BOOLEAN DEFAULT TRUE COMMENT '현재 판매 중 여부',
    비고 TEXT COMMENT '기타 비고사항',
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    
    -- 외래 키 제약조건
    FOREIGN KEY (water_source_id) REFERENCES water_sources(id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    
    -- 인덱스
    INDEX idx_브랜드명 (브랜드명),
    INDEX idx_제조사 (제조사),
    INDEX idx_water_source_id (water_source_id),
    INDEX idx_활성상태 (활성상태)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='브랜드 정보 테이블 (취수원과 1:N 관계)';

-- ============================================
-- 3. 뷰: 브랜드-취수원 조인 뷰
-- ============================================
CREATE OR REPLACE VIEW brand_water_source_mapping AS
SELECT 
    b.id as brand_id,
    b.브랜드명,
    b.제조사,
    b.대표제품명,
    b.제품라인,
    b.활성상태,
    ws.id as water_source_id,
    ws.취수원업체명,
    ws.취수원소재지,
    ws.취수원종류,
    ws.허가번호,
    b.데이터출처 as 브랜드_데이터출처,
    ws.데이터출처 as 취수원_데이터출처,
    b.최종확인일 as 브랜드_최종확인일,
    ws.최종확인일 as 취수원_최종확인일
FROM brands b
INNER JOIN water_sources ws ON b.water_source_id = ws.id
ORDER BY b.브랜드명 ASC;

-- ============================================
-- 4. 뷰: 위반사항 + 브랜드 조인 뷰 (핵심 뷰)
-- ============================================
CREATE OR REPLACE VIEW violations_with_brands AS
SELECT 
    v.id as violation_id,
    v.순번,
    v.품목,
    v.업체명,
    v.업체소재지,
    v.제품명,
    v.처분명,
    v.처분일자,
    v.처분기간,
    v.공표마감일자,
    v.위반내용,
    v.상세URL,
    -- 취수원 정보
    ws.id as water_source_id,
    ws.취수원업체명,
    ws.취수원소재지,
    -- 브랜드 정보 (집계)
    GROUP_CONCAT(DISTINCT b.브랜드명 ORDER BY b.브랜드명 SEPARATOR ', ') as 연관브랜드목록,
    COUNT(DISTINCT b.id) as 연관브랜드수
FROM violations v
LEFT JOIN water_sources ws ON v.업체명 = ws.취수원업체명
LEFT JOIN brands b ON ws.id = b.water_source_id AND b.활성상태 = TRUE
WHERE v.품목 = '먹는샘물'
GROUP BY 
    v.id, v.순번, v.품목, v.업체명, v.업체소재지, v.제품명,
    v.처분명, v.처분일자, v.처분기간, v.공표마감일자, v.위반내용, v.상세URL,
    ws.id, ws.취수원업체명, ws.취수원소재지
ORDER BY v.처분일자 DESC;

-- ============================================
-- 5. 뷰: 브랜드별 위반 통계
-- ============================================
CREATE OR REPLACE VIEW brand_violation_stats AS
SELECT 
    b.id as brand_id,
    b.브랜드명,
    b.제조사,
    ws.취수원업체명,
    COUNT(DISTINCT v.id) as 총위반건수,
    MAX(v.처분일자) as 최근위반일,
    MIN(v.처분일자) as 최초위반일,
    GROUP_CONCAT(DISTINCT v.처분명 ORDER BY v.처분일자 DESC SEPARATOR ' | ') as 위반내역
FROM brands b
INNER JOIN water_sources ws ON b.water_source_id = ws.id
LEFT JOIN violations v ON ws.취수원업체명 = v.업체명 AND v.품목 = '먹는샘물'
GROUP BY b.id, b.브랜드명, b.제조사, ws.취수원업체명
HAVING 총위반건수 > 0
ORDER BY 총위반건수 DESC, 최근위반일 DESC;

-- ============================================
-- 6. 샘플 데이터 삽입 (예시)
-- ============================================

-- 취수원 샘플 데이터
INSERT INTO water_sources (취수원업체명, 취수원소재지, 취수원종류, 데이터출처, 최종확인일) VALUES
('제주특별자치도개발공사', '제주특별자치도', '암반수', '식약처 품목제조신고 2024.12', '2024-12-08'),
('강원샘물 주식회사', '강원도 평창군', '지하수', '식약처 품목제조신고 2024.12', '2024-12-08'),
('롯데칠성음료 주식회사', '경기도 이천시', '지하암반수', '식약처 품목제조신고 2024.12', '2024-12-08')
ON DUPLICATE KEY UPDATE 
    취수원소재지 = VALUES(취수원소재지),
    취수원종류 = VALUES(취수원종류),
    데이터출처 = VALUES(데이터출처),
    최종확인일 = VALUES(최종확인일);

-- 브랜드 샘플 데이터
INSERT INTO brands (water_source_id, 브랜드명, 제조사, 대표제품명, 제품라인, 데이터출처, 최종확인일, 활성상태) VALUES
-- 제주삼다수
((SELECT id FROM water_sources WHERE 취수원업체명 = '제주특별자치도개발공사' LIMIT 1), 
 '제주삼다수', '제주특별자치도개발공사', '제주삼다수', 
 '["제주삼다수 500ml", "제주삼다수 2L", "제주삼다수 무라벨"]', 
 '식약처 품목제조신고 2024.12', '2024-12-08', TRUE),

-- 평창수
((SELECT id FROM water_sources WHERE 취수원업체명 = '강원샘물 주식회사' LIMIT 1), 
 '평창수', '강원샘물 주식회사', '평창수', 
 '["평창수 500ml", "평창수 2L"]', 
 '식약처 품목제조신고 2024.12', '2024-12-08', TRUE),

-- 아이시스8.0
((SELECT id FROM water_sources WHERE 취수원업체명 = '롯데칠성음료 주식회사' LIMIT 1), 
 '아이시스8.0', '롯데칠성음료 주식회사', '아이시스8.0', 
 '["아이시스8.0 500ml", "아이시스8.0 2L", "아이시스ECO"]', 
 '식약처 품목제조신고 2024.12', '2024-12-08', TRUE)
ON DUPLICATE KEY UPDATE 
    브랜드명 = VALUES(브랜드명),
    제조사 = VALUES(제조사),
    대표제품명 = VALUES(대표제품명),
    제품라인 = VALUES(제품라인),
    데이터출처 = VALUES(데이터출처),
    최종확인일 = VALUES(최종확인일),
    활성상태 = VALUES(활성상태);

-- ============================================
-- 7. 유용한 쿼리 예시
-- ============================================

-- 특정 브랜드의 취수원 및 위반 내역 조회
-- SELECT * FROM violations_with_brands WHERE 연관브랜드목록 LIKE '%삼다수%';

-- 특정 취수원이 공급하는 브랜드 목록
-- SELECT * FROM brand_water_source_mapping WHERE 취수원업체명 = '제주특별자치도개발공사';

-- 위반 건수가 있는 브랜드 통계
-- SELECT * FROM brand_violation_stats;

-- 활성 브랜드 전체 목록
-- SELECT 브랜드명, 제조사, 취수원업체명 FROM brand_water_source_mapping WHERE 활성상태 = TRUE;

-- 취수원별 공급 브랜드 수
-- SELECT 
--     ws.취수원업체명,
--     COUNT(b.id) as 브랜드수,
--     GROUP_CONCAT(b.브랜드명 SEPARATOR ', ') as 브랜드목록
-- FROM water_sources ws
-- LEFT JOIN brands b ON ws.id = b.water_source_id
-- GROUP BY ws.id, ws.취수원업체명
-- ORDER BY 브랜드수 DESC;
