# 이메일 알림 시스템 설정 가이드

이 문서는 먹는샘물 위반 알림 이메일 시스템을 설정하는 방법을 설명합니다.

## 1. 데이터베이스 스키마 설정

새로운 테이블을 데이터베이스에 추가해야 합니다.

```bash
# MySQL에 접속
mysql -u your_username -p mcee_violations

# 또는 SSH 터널을 통해 접속한 경우:
mysql -h 127.0.0.1 -P 3306 -u your_username -p mcee_violations
```

스키마 파일 실행:

```sql
source /path/to/database_setup_notifications.sql;
```

또는 파일 내용을 직접 복사하여 실행할 수 있습니다.

## 2. Gmail SMTP 설정 (권장)

### 2.1. Google 계정 2단계 인증 활성화

1. [Google 계정](https://myaccount.google.com/) 접속
2. **보안** 메뉴 선택
3. **2단계 인증** 활성화

### 2.2. 앱 비밀번호 생성

1. [앱 비밀번호 페이지](https://myaccount.google.com/apppasswords) 접속
2. 앱 선택: **메일**
3. 기기 선택: **기타 (맞춤 이름)**
4. 이름 입력: `Spring Water Notification`
5. **생성** 클릭
6. 생성된 16자리 비밀번호 복사

### 2.3. 환경 변수 설정

`.env` 파일을 편집하여 다음 내용을 추가/수정합니다:

```bash
# SMTP 설정
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USERNAME=your-email@gmail.com
SMTP_PASSWORD=abcd efgh ijkl mnop  # 앱 비밀번호 (공백 포함)
SMTP_FROM_EMAIL=your-email@gmail.com
SMTP_FROM_NAME=Spring Water Notification

# 이메일 인증 링크용 베이스 URL
BASE_URL=http://localhost:8000  # 프로덕션에서는 실제 도메인으로 변경

# 알림 기능 활성화
NOTIFICATION_ENABLED=true
```

**주의사항:**

- `SMTP_PASSWORD`는 일반 Gmail 비밀번호가 아닌 **앱 비밀번호**를 사용해야 합니다.
- `BASE_URL`은 프로덕션 환경에서는 실제 도메인으로 변경해야 합니다.

## 3. Python 패키지 설치

```bash
# 가상환경 활성화 (이미 활성화되어 있다면 생략)
source .venv/bin/activate

# 새로운 패키지 설치
pip install -r requirements.txt
```

## 4. 서버 실행

```bash
# 개발 모드로 실행
uvicorn app.main:app --reload

# 또는
python -m uvicorn app.main:app --reload
```

## 5. API 테스트

### 5.1. 구독 신청

```bash
curl -X POST http://localhost:8000/api/subscribe \
  -H "Content-Type: application/json" \
  -d '{"email":"your-email@gmail.com"}'
```

또는 Python 테스트 스크립트 사용:

```bash
python test_subscription.py
```

### 5.2. 이메일 확인

구독 신청 후 이메일을 확인하면 구독 확인 링크가 포함된 이메일이 도착합니다.

### 5.3. 구독 확인

이메일의 "구독 확인하기" 버튼을 클릭하거나, 다음 URL에 접속:

```
http://localhost:8000/api/subscribe/confirm/{token}
```

### 5.4. 알림 테스트

수동 크롤링을 실행하여 새로운 위반이 감지되면 알림이 발송됩니다:

```bash
curl -X POST http://localhost:8000/api/crawl/manual
```

## 6. 문제 해결

### 이메일이 발송되지 않는 경우

1. **환경 변수 확인**

   ```bash
   # .env 파일이 올바르게 설정되었는지 확인
   cat .env | grep SMTP
   ```

2. **SMTP 연결 테스트**

   ```python
   import smtplib

   try:
       server = smtplib.SMTP('smtp.gmail.com', 587)
       server.starttls()
       server.login('your-email@gmail.com', 'your-app-password')
       print("✅ SMTP 연결 성공!")
       server.quit()
   except Exception as e:
       print(f"❌ SMTP 연결 실패: {e}")
   ```

3. **로그 확인**
   - 서버 콘솔에서 에러 메시지 확인
   - `logger.error` 메시지 확인

### 구독이 활성화되지 않는 경우

1. **데이터베이스 확인**

   ```sql
   -- 구독자 목록 확인
   SELECT * FROM email_subscribers;

   -- 활성 구독자만 확인
   SELECT * FROM active_subscribers;
   ```

2. **토큰 확인**
   ```sql
   -- 특정 이메일의 토큰 확인
   SELECT email, subscription_token, is_active
   FROM email_subscribers
   WHERE email = 'your-email@gmail.com';
   ```

## 7. 프로덕션 배포 시 주의사항

1. **BASE_URL 변경**

   ```bash
   BASE_URL=https://your-domain.com
   ```

2. **CORS 설정 수정**

   - `app/main.py`의 `CORSMiddleware` 설정에서 `allow_origins`를 특정 도메인만 허용하도록 변경

3. **HTTPS 사용**

   - 이메일 확인 링크는 HTTPS를 사용하도록 설정

4. **이메일 발송 제한**
   - Gmail 무료 계정: 하루 500통 제한
   - 더 많은 발송이 필요한 경우 SendGrid 또는 AWS SES 사용 고려

## 8. API 엔드포인트

### 구독 관리

- `POST /api/subscribe` - 이메일 구독 신청
- `GET /api/subscribe/confirm/{token}` - 이메일 인증 확인
- `GET /api/unsubscribe/{token}` - 구독 취소

### 기존 API

- `GET /` - 헬스 체크
- `GET /api/violations` - 위반 목록 조회
- `POST /api/crawl/manual` - 수동 크롤링 실행
- `POST /api/violations/explain` - AI 위반 설명
