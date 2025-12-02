-- AI 설명 캐시 테이블 생성
-- 동일한 위반 내역에 대해 AI 설명을 캐싱하여 비용 절감 및 응답 속도 개선

CREATE TABLE IF NOT EXISTS violation_explanation_cache (
    id INT PRIMARY KEY AUTO_INCREMENT,
    
    -- 캐시 키 (처분명+위반내용의 SHA-256 해시)
    cache_key VARCHAR(64) NOT NULL UNIQUE COMMENT '처분명+위반내용의 해시값',
    
    -- 원본 데이터
    처분명 VARCHAR(300) NOT NULL,
    위반내용 TEXT NOT NULL,
    
    -- AI 생성 결과
    easy_explanation TEXT NOT NULL COMMENT 'AI 생성 쉬운 설명',
    related_terms_json TEXT COMMENT '관련 전문 용어 JSON',
    
    -- 메타 정보
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    accessed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '마지막 접근 시간',
    access_count INT DEFAULT 0 COMMENT '사용 횟수',
    
    -- 인덱스
    INDEX idx_cache_key (cache_key),
    INDEX idx_created_at (created_at),
    INDEX idx_accessed_at (accessed_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='AI 생성 위반 설명 캐시';

-- 통계 확인 쿼리
-- SELECT COUNT(*) as total_cached, 
--        SUM(access_count) as total_accesses,
--        AVG(access_count) as avg_accesses_per_item
-- FROM violation_explanation_cache;
