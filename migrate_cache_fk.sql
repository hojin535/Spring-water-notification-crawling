-- violation_explanation_cache 테이블에 FK 추가
-- 기존 데이터 삭제 후 새로운 구조로 재생성

USE mcee_violations;

-- 1. 기존 테이블 삭제
DROP TABLE IF EXISTS violation_explanation_cache;

-- 2. FK 포함하여 재생성
CREATE TABLE violation_explanation_cache (
    id INT PRIMARY KEY AUTO_INCREMENT,
    
    -- violations 테이블 참조 (FK) - 필수 아님 (null 허용)
    -- API로 직접 요청하는 경우 violation_id가 없을 수 있음
    violation_id INT NULL COMMENT 'violations 테이블 ID (있는 경우)',
    
    -- 캐시 키 (중복 방지용, 필수)
    cache_key VARCHAR(64) NOT NULL UNIQUE COMMENT '처분명+위반내용의 해시값',
    
    -- 원본 데이터
    처분명 VARCHAR(300) NOT NULL,
    위반내용 TEXT NOT NULL,
    
    -- AI 생성 결과
    easy_explanation TEXT NOT NULL COMMENT 'AI 생성 쉬운 설명',
    related_terms_json TEXT COMMENT '관련 전문 용어 JSON',
    
    -- 메타 정보
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    accessed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    access_count INT DEFAULT 0,
    
    -- 인덱스
    INDEX idx_violation_id (violation_id),
    INDEX idx_cache_key (cache_key),
    INDEX idx_created_at (created_at),
    
    -- 외래키 (violation_id가 있는 경우에만 제약, violations 삭제 시 자동 삭제)
    FOREIGN KEY (violation_id) REFERENCES violations(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='AI 생성 위반 설명 캐시 (FK 연결)';

-- 실행 완료 메시지
SELECT 'violation_explanation_cache 테이블이 FK와 함께 재생성되었습니다.' AS message;
