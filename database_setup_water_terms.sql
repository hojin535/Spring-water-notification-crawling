-- 수질 검사 용어 사전 테이블 생성 스크립트
USE mcee_violations;

-- ============================================
-- water_terms 테이블 생성
-- ============================================
CREATE TABLE IF NOT EXISTS water_terms (
    -- 기본 키
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '자동 증가 ID',
    
    -- 용어 정보
    term VARCHAR(100) NOT NULL UNIQUE COMMENT '수질 검사 용어',
    description TEXT NOT NULL COMMENT '쉬운 설명',
    
    -- 분류 정보
    category VARCHAR(50) NOT NULL COMMENT '카테고리 (microbe, heavy_metal, chemical, aesthetic)',
    category_name VARCHAR(100) NOT NULL COMMENT '카테고리 한글명',
    risk_level VARCHAR(20) NOT NULL COMMENT '위험도 (high, critical, warning, check)',
    
    -- 데이터 출처
    source VARCHAR(50) DEFAULT 'manual' COMMENT '데이터 출처',
    
    -- 메타 정보
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    
    -- 인덱스
    INDEX idx_category (category),
    INDEX idx_risk_level (risk_level),
    INDEX idx_term (term)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='수질 검사 용어 사전 테이블';
