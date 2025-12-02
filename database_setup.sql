-- 먹는물영업자 위반현황 데이터베이스 스크립트
-- 데이터베이스: mcee_violations

-- ============================================
-- 1. 데이터베이스 생성 (필요한 경우)
-- ============================================
CREATE DATABASE IF NOT EXISTS mcee_violations 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE mcee_violations;

-- ============================================
-- 2. violations 테이블 생성
-- ============================================
CREATE TABLE IF NOT EXISTS violations (
    -- 기본 키
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '자동 증가 ID',
    
    -- 기본 정보 필드
    순번 VARCHAR(50) COMMENT '순번',
    품목 VARCHAR(100) COMMENT '품목 (먹는샘물 등)',
    업체명 VARCHAR(200) COMMENT '업체명',
    업체소재지 VARCHAR(300) COMMENT '업체 소재지',
    제품명 VARCHAR(200) COMMENT '제품명',
    업종명 VARCHAR(100) COMMENT '업종명',
    
    -- 처분 정보 필드
    처분명 VARCHAR(300) COMMENT '처분명',
    처분일자 VARCHAR(20) COMMENT '처분일자 (YYYY-MM-DD)',
    처분기간 VARCHAR(100) COMMENT '처분기간',
    공표마감일자 VARCHAR(20) COMMENT '공표마감일자 (YYYY-MM-DD)',
    
    -- 위반 내용
    위반내용 TEXT COMMENT '위반내용 상세',
    
    -- 추가 정보
    상세URL VARCHAR(500) COMMENT '상세 페이지 URL',
    board_id VARCHAR(50) UNIQUE COMMENT '게시물 고유 ID',
    
    -- 메타 정보
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    
    -- 인덱스
    INDEX idx_업체명 (업체명),
    INDEX idx_처분일자 (처분일자),
    INDEX idx_품목 (품목),
    INDEX idx_board_id (board_id),
    INDEX idx_created_at (created_at),
    INDEX idx_updated_at (updated_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='먹는물영업자 위반현황 테이블';

-- ============================================
-- 3. spring_water 뷰 생성
-- ============================================
-- 먹는샘물 관련 데이터만 조회하는 뷰
CREATE OR REPLACE VIEW spring_water AS
SELECT 
    id,
    순번,
    품목,
    업체명,
    업체소재지,
    제품명,
    업종명,
    처분명,
    처분일자,
    처분기간,
    공표마감일자,
    위반내용,
    상세URL,
    board_id,
    created_at,
    updated_at
FROM violations
WHERE 품목 = '먹는샘물'
ORDER BY 처분일자 DESC;

-- ============================================
-- 4. 추가 뷰 (선택사항)
-- ============================================

-- 최근 위반 현황 뷰 (최근 6개월)
CREATE OR REPLACE VIEW recent_violations AS
SELECT 
    id,
    순번,
    품목,
    업체명,
    제품명,
    처분명,
    처분일자,
    공표마감일자,
    위반내용,
    created_at,
    updated_at
FROM violations
WHERE 처분일자 >= DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 6 MONTH), '%Y-%m-%d')
ORDER BY 처분일자 DESC;

-- 업체별 위반 횟수 집계 뷰
CREATE OR REPLACE VIEW company_violation_stats AS
SELECT 
    업체명,
    품목,
    COUNT(*) as 위반횟수,
    MIN(처분일자) as 최초위반일,
    MAX(처분일자) as 최근위반일,
    GROUP_CONCAT(DISTINCT 처분명 SEPARATOR '; ') as 처분명목록
FROM violations
GROUP BY 업체명, 품목
ORDER BY 위반횟수 DESC, 최근위반일 DESC;

-- ============================================
-- 5. 데이터 확인 쿼리
-- ============================================

-- 테이블 구조 확인
-- DESCRIBE violations;

-- spring_water 뷰 데이터 확인
-- SELECT * FROM spring_water LIMIT 10;

-- 전체 레코드 수 확인
-- SELECT COUNT(*) as total_records FROM violations;
-- SELECT COUNT(*) as spring_water_records FROM spring_water;

-- 품목별 집계
-- SELECT 품목, COUNT(*) as count FROM violations GROUP BY 품목;
