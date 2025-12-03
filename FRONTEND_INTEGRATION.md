# 프론트엔드 통합 가이드 - 이메일 알림 기능

## 📋 프론트엔드 투두리스트

### 1. UI/UX 구현

- [ ] **이메일 구독 폼 UI**

  - [ ] 이메일 입력 필드
  - [ ] 구독 신청 버튼
  - [ ] 로딩 상태 표시
  - [ ] 성공/실패 메시지 표시

- [ ] **구독 상태 확인 페이지**

  - [ ] URL 파라미터에서 토큰 추출
  - [ ] 구독 확인 API 호출
  - [ ] 확인 결과 표시
  - [ ] 리다이렉트 로직

- [ ] **구독 취소 페이지**
  - [ ] URL 파라미터에서 토큰 추출
  - [ ] 구독 취소 API 호출
  - [ ] 취소 결과 표시

### 2. API 연동

- [ ] **구독 신청 API 연동**

  - [ ] POST `/api/subscribe`
  - [ ] 이메일 유효성 검증
  - [ ] 에러 핸들링
  - [ ] 응답 처리

- [ ] **구독 확인 API 연동**

  - [ ] GET `/api/subscribe/confirm/{token}`
  - [ ] 토큰 파싱
  - [ ] 응답 처리

- [ ] **구독 취소 API 연동**
  - [ ] GET `/api/unsubscribe/{token}`
  - [ ] 토큰 파싱
  - [ ] 응답 처리

### 3. 사용자 경험 개선

- [ ] **폼 유효성 검증**

  - [ ] 이메일 형식 검증
  - [ ] 중복 제출 방지
  - [ ] 입력 필드 포커스 관리

- [ ] **피드백 메시지**

  - [ ] 성공 메시지 (토스트/모달)
  - [ ] 에러 메시지 (명확한 안내)
  - [ ] 재시도 안내

- [ ] **접근성**
  - [ ] 키보드 네비게이션
  - [ ] 스크린 리더 지원
  - [ ] ARIA 라벨

---

## 🔌 백엔드 API 명세

### 1. 이메일 구독 신청

**Endpoint:** `POST /api/subscribe`

**Request Body:**

```json
{
  "email": "user@example.com"
}
```

**Response (성공 - 200):**

```json
{
  "status": "success",
  "message": "구독 확인 이메일을 발송했습니다. 이메일을 확인해주세요.",
  "email": "user@example.com"
}
```

**Response (이미 구독 중 - 200):**

```json
{
  "status": "already_subscribed",
  "message": "이미 구독 중인 이메일입니다.",
  "email": "user@example.com"
}
```

**Response (재발송 - 200):**

```json
{
  "status": "resent",
  "message": "확인 이메일을 재발송했습니다. 이메일을 확인해주세요.",
  "email": "user@example.com"
}
```

**Error Response (500):**

```json
{
  "detail": "이메일 발송에 실패했습니다. 잠시 후 다시 시도해주세요."
}
```

---

### 2. 이메일 구독 확인

**Endpoint:** `GET /api/subscribe/confirm/{token}`

**URL Parameters:**

- `token` (string): 이메일에 포함된 구독 확인 토큰

**Response (첫 확인 - 200):**

```json
{
  "status": "success",
  "message": "구독이 확인되었습니다! 새로운 위반이 발견되면 이메일로 알림을 보내드립니다.",
  "email": "user@example.com"
}
```

**Response (이미 확인됨 - 200):**

```json
{
  "status": "already_confirmed",
  "message": "이미 구독이 확인된 이메일입니다.",
  "email": "user@example.com"
}
```

**Error Response (404):**

```json
{
  "detail": "유효하지 않은 구독 확인 링크입니다."
}
```

---

### 3. 구독 취소

**Endpoint:** `GET /api/unsubscribe/{token}`

**URL Parameters:**

- `token` (string): 이메일에 포함된 구독 취소 토큰

**Response (성공 - 200):**

```json
{
  "status": "success",
  "message": "구독이 취소되었습니다. 더 이상 알림을 받지 않습니다."
}
```

**Response (이미 취소됨 - 200):**

```json
{
  "status": "already_unsubscribed",
  "message": "이미 구독이 취소된 이메일입니다."
}
```

**Error Response (404):**

```json
{
  "detail": "유효하지 않은 구독 취소 링크입니다."
}
```

---

## 💻 프론트엔드 구현 예시

### React 예시

#### 1. 이메일 구독 폼 컴포넌트

```tsx
import { useState } from "react";

export function EmailSubscriptionForm() {
  const [email, setEmail] = useState("");
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState<{
    type: "success" | "error";
    text: string;
  } | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setMessage(null);

    try {
      const response = await fetch("http://localhost:8000/api/subscribe", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ email }),
      });

      const data = await response.json();

      if (response.ok) {
        setMessage({ type: "success", text: data.message });
        setEmail(""); // 입력 필드 초기화
      } else {
        setMessage({
          type: "error",
          text: data.detail || "오류가 발생했습니다.",
        });
      }
    } catch (error) {
      setMessage({ type: "error", text: "네트워크 오류가 발생했습니다." });
    } finally {
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="subscription-form">
      <h2>먹는샘물 위반 알림 구독</h2>
      <p>새로운 위반 사례가 발견되면 이메일로 알려드립니다.</p>

      <div className="form-group">
        <input
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder="이메일 주소를 입력하세요"
          required
          disabled={loading}
          className="email-input"
        />
        <button type="submit" disabled={loading} className="submit-button">
          {loading ? "처리 중..." : "구독하기"}
        </button>
      </div>

      {message && (
        <div className={`message ${message.type}`}>{message.text}</div>
      )}
    </form>
  );
}
```

#### 2. 구독 확인 페이지

```tsx
import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";

export function SubscriptionConfirmPage() {
  const { token } = useParams<{ token: string }>();
  const navigate = useNavigate();
  const [status, setStatus] = useState<"loading" | "success" | "error">(
    "loading"
  );
  const [message, setMessage] = useState("");

  useEffect(() => {
    const confirmSubscription = async () => {
      try {
        const response = await fetch(
          `http://localhost:8000/api/subscribe/confirm/${token}`
        );
        const data = await response.json();

        if (response.ok) {
          setStatus("success");
          setMessage(data.message);

          // 3초 후 메인 페이지로 리다이렉트
          setTimeout(() => {
            navigate("/");
          }, 3000);
        } else {
          setStatus("error");
          setMessage(data.detail || "구독 확인에 실패했습니다.");
        }
      } catch (error) {
        setStatus("error");
        setMessage("네트워크 오류가 발생했습니다.");
      }
    };

    if (token) {
      confirmSubscription();
    }
  }, [token, navigate]);

  return (
    <div className="confirm-page">
      {status === "loading" && <p>구독을 확인하는 중...</p>}
      {status === "success" && (
        <div className="success">
          <h2>✅ 구독 완료!</h2>
          <p>{message}</p>
        </div>
      )}
      {status === "error" && (
        <div className="error">
          <h2>❌ 오류 발생</h2>
          <p>{message}</p>
        </div>
      )}
    </div>
  );
}
```

#### 3. 구독 취소 페이지

```tsx
import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";

export function UnsubscribePage() {
  const { token } = useParams<{ token: string }>();
  const [status, setStatus] = useState<"loading" | "success" | "error">(
    "loading"
  );
  const [message, setMessage] = useState("");

  useEffect(() => {
    const unsubscribe = async () => {
      try {
        const response = await fetch(
          `http://localhost:8000/api/unsubscribe/${token}`
        );
        const data = await response.json();

        if (response.ok) {
          setStatus("success");
          setMessage(data.message);
        } else {
          setStatus("error");
          setMessage(data.detail || "구독 취소에 실패했습니다.");
        }
      } catch (error) {
        setStatus("error");
        setMessage("네트워크 오류가 발생했습니다.");
      }
    };

    if (token) {
      unsubscribe();
    }
  }, [token]);

  return (
    <div className="unsubscribe-page">
      {status === "loading" && <p>구독을 취소하는 중...</p>}
      {status === "success" && (
        <div className="success">
          <h2>구독이 취소되었습니다</h2>
          <p>{message}</p>
        </div>
      )}
      {status === "error" && (
        <div className="error">
          <h2>오류 발생</h2>
          <p>{message}</p>
        </div>
      )}
    </div>
  );
}
```

---

## 🎨 UI/UX 권장사항

### 1. 이메일 구독 폼 배치

**권장 위치:**

- 메인 페이지 하단 (Footer 위)
- 위반 목록 페이지 사이드바
- 별도의 "알림 설정" 페이지

**디자인 가이드:**

- 명확한 CTA (Call-to-Action)
- 개인정보 처리 방침 링크
- 구독의 이점 명시

### 2. 사용자 흐름

```
1. 사용자가 이메일 입력 및 구독 신청
   ↓
2. 성공 메시지 표시 ("이메일을 확인해주세요")
   ↓
3. 사용자가 이메일 확인
   ↓
4. 확인 링크 클릭
   ↓
5. 확인 페이지 표시 ("구독이 완료되었습니다")
   ↓
6. 자동으로 메인 페이지로 리다이렉트
```

### 3. 에러 메시지 가이드

| 상황             | 메시지                                                    |
| ---------------- | --------------------------------------------------------- |
| 이메일 형식 오류 | "올바른 이메일 주소를 입력해주세요"                       |
| 이미 구독 중     | "이미 구독 중인 이메일입니다"                             |
| 네트워크 오류    | "일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요" |
| 서버 오류        | "이메일 발송에 실패했습니다. 관리자에게 문의하세요"       |

---

## 🔧 라우팅 설정

### React Router 예시

```tsx
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { EmailSubscriptionForm } from "./components/EmailSubscriptionForm";
import { SubscriptionConfirmPage } from "./pages/SubscriptionConfirmPage";
import { UnsubscribePage } from "./pages/UnsubscribePage";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route
          path="/subscribe/confirm/:token"
          element={<SubscriptionConfirmPage />}
        />
        <Route path="/unsubscribe/:token" element={<UnsubscribePage />} />
      </Routes>
    </BrowserRouter>
  );
}
```

**중요:** 백엔드의 `BASE_URL` 환경 변수를 프론트엔드 도메인으로 설정해야 이메일 링크가 올바르게 작동합니다.

---

## 📱 반응형 디자인

### 모바일 최적화

- 큰 터치 영역 (최소 44x44px)
- 읽기 쉬운 폰트 크기 (최소 16px)
- 간결한 폼 레이아웃

### CSS 예시

```css
.subscription-form {
  max-width: 500px;
  margin: 0 auto;
  padding: 2rem;
}

.email-input {
  width: 100%;
  padding: 12px 16px;
  font-size: 16px;
  border: 1px solid #ddd;
  border-radius: 8px;
  margin-bottom: 1rem;
}

.submit-button {
  width: 100%;
  padding: 12px 24px;
  font-size: 16px;
  font-weight: bold;
  color: white;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: transform 0.2s;
}

.submit-button:hover:not(:disabled) {
  transform: translateY(-2px);
}

.submit-button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.message {
  padding: 12px 16px;
  border-radius: 8px;
  margin-top: 1rem;
}

.message.success {
  background-color: #d4edda;
  color: #155724;
  border: 1px solid #c3e6cb;
}

.message.error {
  background-color: #f8d7da;
  color: #721c24;
  border: 1px solid #f5c6cb;
}
```

---

## 🧪 테스트 체크리스트

### 기능 테스트

- [ ] 유효한 이메일로 구독 신청
- [ ] 잘못된 형식의 이메일로 구독 신청
- [ ] 이미 구독 중인 이메일로 재구독
- [ ] 구독 확인 링크 클릭
- [ ] 구독 취소 링크 클릭
- [ ] 잘못된 토큰으로 접근

### UI/UX 테스트

- [ ] 로딩 상태 표시
- [ ] 성공/실패 메시지 표시
- [ ] 중복 제출 방지
- [ ] 키보드 네비게이션
- [ ] 모바일 반응형

---

## 📝 주의사항

1. **CORS 설정**: 프론트엔드 도메인이 다른 경우 백엔드의 CORS 설정 확인 필요
2. **BASE_URL**: `.env` 파일의 `BASE_URL`을 프론트엔드 도메인으로 변경
3. **개인정보 처리**: 개인정보 처리 방침 및 동의 절차 추가 권장
4. **스팸 방지**: reCAPTCHA 등 스팸 방지 기능 추가 고려

---

## 🔗 백엔드 연락처 정보

- API Base URL: `http://localhost:8000` (개발 환경)
- 문서: [EMAIL_SETUP_GUIDE.md](./EMAIL_SETUP_GUIDE.md)
- 테스트: `curl -X POST http://localhost:8000/api/test-email`
