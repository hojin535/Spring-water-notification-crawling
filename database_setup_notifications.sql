-- ============================================
-- 이메일 알림 시스템 데이터베이스 스키마
-- ============================================

USE mcee_violations;

-- ============================================
-- 1. email_subscribers 테이블 생성
-- ============================================
CREATE TABLE IF NOT EXISTS email_subscribers (
    -- 기본 키
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '자동 증가 ID',
    
    -- 이메일 정보
    email VARCHAR(255) NOT NULL UNIQUE COMMENT '구독자 이메일 주소',
    
    -- 구독 상태
    is_active BOOLEAN DEFAULT FALSE COMMENT '구독 활성화 여부 (이메일 인증 후 true)',
    subscription_token VARCHAR(64) UNIQUE COMMENT '구독 확인 토큰 (이메일 인증용)',
    unsubscribe_token VARCHAR(64) UNIQUE COMMENT '구독 취소 토큰',
    
    -- 일시 정보
    subscribed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '구독 신청일시',
    confirmed_at TIMESTAMP NULL COMMENT '이메일 인증 완료일시',
    last_notified_at TIMESTAMP NULL COMMENT '마지막 알림 발송일시',
    unsubscribed_at TIMESTAMP NULL COMMENT '구독 취소일시',
    
    -- 메타 정보
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    
    -- 인덱스
    INDEX idx_email (email),
    INDEX idx_is_active (is_active),
    INDEX idx_subscription_token (subscription_token),
    INDEX idx_unsubscribe_token (unsubscribe_token)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='이메일 구독자 테이블';

-- ============================================
-- 2. notification_history 테이블 생성
-- ============================================
CREATE TABLE IF NOT EXISTS notification_history (
    -- 기본 키
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '자동 증가 ID',
    
    -- 관계
    subscriber_id INT NOT NULL COMMENT '구독자 ID (email_subscribers 참조)',
    violation_id INT NOT NULL COMMENT '위반 ID (violations 참조)',
    
    -- 알림 정보
    email_subject VARCHAR(500) COMMENT '이메일 제목',
    email_sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '이메일 발송일시',
    is_success BOOLEAN DEFAULT TRUE COMMENT '발송 성공 여부',
    error_message TEXT COMMENT '발송 실패 시 에러 메시지',
    
    -- 메타 정보
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    
    -- 인덱스
    INDEX idx_subscriber_id (subscriber_id),
    INDEX idx_violation_id (violation_id),
    INDEX idx_email_sent_at (email_sent_at),
    INDEX idx_is_success (is_success),
    
    -- 외래 키
    FOREIGN KEY (subscriber_id) REFERENCES email_subscribers(id) ON DELETE CASCADE,
    FOREIGN KEY (violation_id) REFERENCES violations(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='알림 발송 기록 테이블';

-- ============================================
-- 3. 유용한 뷰 생성
-- ============================================

-- 활성 구독자 뷰
CREATE OR REPLACE VIEW active_subscribers AS
SELECT 
    id,
    email,
    confirmed_at,
    last_notified_at,
    created_at
FROM email_subscribers
WHERE is_active = TRUE
  AND unsubscribed_at IS NULL
ORDER BY confirmed_at DESC;

-- 알림 통계 뷰
CREATE OR REPLACE VIEW notification_stats AS
SELECT 
    DATE(email_sent_at) as notification_date,
    COUNT(*) as total_notifications,
    SUM(CASE WHEN is_success = TRUE THEN 1 ELSE 0 END) as successful_notifications,
    SUM(CASE WHEN is_success = FALSE THEN 1 ELSE 0 END) as failed_notifications,
    COUNT(DISTINCT subscriber_id) as unique_subscribers,
    COUNT(DISTINCT violation_id) as unique_violations
FROM notification_history
GROUP BY DATE(email_sent_at)
ORDER BY notification_date DESC;

-- ============================================
-- 4. 데이터 확인 쿼리
-- ============================================

-- 활성 구독자 수 확인
-- SELECT COUNT(*) as active_subscriber_count FROM active_subscribers;

-- 최근 알림 발송 내역 확인
-- SELECT * FROM notification_history ORDER BY email_sent_at DESC LIMIT 10;

-- 오늘의 알림 통계
-- SELECT * FROM notification_stats WHERE notification_date = CURDATE();
