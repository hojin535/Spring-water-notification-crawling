# 먹는물영업자 위반현황 크롤링 서버

기후에너지환경부의 먹는물영업자 위반현황 페이지를 크롤링하여 데이터를 제공하는 Python FastAPI 서버입니다.

## 주요 특징

- **자동 갱신**: 1시간마다 자동으로 데이터 크롤링 (시작 시 크롤링 없음)
- **MySQL 저장**: 크롤링 결과를 MySQL 데이터베이스에 영구 저장
- **효율적**: API 호출 시마다 크롤링하지 않아 대상 사이트 부담 최소화
- **RESTful API**: 표준 REST API 제공
- **페이지네이션**: limit/offset 파라미터로 대량 데이터 효율적 조회

## 기술 스택

- **FastAPI**: 웹 API 프레임워크
- **Selenium**: 동적 페이지 크롤링
- **BeautifulSoup4**: HTML 파싱
- **Pydantic**: 데이터 검증
- **SQLAlchemy**: ORM (MySQL 연동)
- **APScheduler**: 주기적 작업 스케줄링
- **PyMySQL**: MySQL 드라이버

## 설치 방법

### 1. MySQL 데이터베이스 생성

```sql
CREATE DATABASE mcee_violations CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 2. 저장소 클론

```bash
git clone <repository-url>
cd Spring-water-notification-crawling
```

### 3. 가상환경 생성 및 활성화

```bash
python -m venv venv
source venv/bin/activate  # Mac/Linux
# 또는
venv\Scripts\activate  # Windows
```

### 4. 의존성 설치

```bash
pip install -r requirements.txt
```

### 5. 환경 변수 설정

`.env` 파일을 생성하고 다음 내용을 입력하세요:

```bash
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=yourpassword
MYSQL_DATABASE=mcee_violations
```

## 실행 방법

### 개발 서버 실행

```bash
uvicorn app.main:app --reload
```

서버가 `http://localhost:8000`에서 실행됩니다.

### API 문서 확인

서버 실행 후 브라우저에서 다음 URL을 방문하세요:

- Swagger UI: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc`

## API 엔드포인트

### 1. 헬스 체크

```
GET /
```

서버 상태 및 DB 정보를 확인합니다.

**응답 예시:**

```json
{
  "status": "ok",
  "message": "MCEE Crawler API",
  "version": "3.0.0",
  "database": {
    "total_records": 10,
    "last_updated": "2025-12-02T14:00:00"
  }
}
```

### 2. 위반 목록 조회

```
GET /api/violations?limit=100&offset=0
```

위반 목록을 DB에서 조회합니다.

**쿼리 파라미터:**

- `limit`: 반환할 최대 레코드 수 (기본: 100)
- `offset`: 건너뛸 레코드 수 (페이지네이션, 기본: 0)

**특징:**

- DB에서 조회 (빠름)
- 1시간마다 자동 갱신
- 페이지네이션 지원

**응답 예시:**

```json
[
  {
    "순번": "2",
    "품목": "먹는샘물",
    "업체명": "백봉음료",
    "제품명": "",
    "처분명": "자가품질검사 일부 미실시 등",
    "처분일자": "2025-09-01",
    "공표마감일자": "2025-09-30",
    "상세URL": "https://www.mcee.go.kr/..."
  }
]
```

### 3. 위반 상세 정보 조회 (전체)

```
GET /api/violations/detailed?limit=100&offset=0
```

모든 항목의 상세 정보를 DB에서 조회합니다.

**쿼리 파라미터:**

- `limit`: 반환할 최대 레코드 수 (기본: 100)
- `offset`: 건너뛸 레코드 수 (페이지네이션, 기본: 0)

**특징:**

- DB에서 조회
- 위반내용 포함
- 페이지네이션 지원

**응답 예시:**

```json
[
  {
    "품목": "먹는샘물",
    "업체명": "백봉음료",
    "업체소재지": "",
    "제품명": "",
    "업종명": "",
    "공표마감일자": "2025-09-30",
    "처분명": "자가품질검사 일부 미실시 등",
    "처분기간": "2025-09-01 ~ 2025-09-01",
    "위반내용": "자가품질검사 일부미실시\n무기물질 함량 표시기준을 위반한 먹는 샘물을 판매제조등 영업상 사용",
    "처분일자": "2025-09-01"
  }
]
```

### 4. 특정 업체 위반 내역 조회

```
GET /api/violations/company/{company_name}
```

특정 업체의 모든 위반 내역을 조회합니다.

**경로 파라미터:**

- `company_name`: 업체명 (부분 일치 검색)

**예시:**

```bash
curl http://localhost:8000/api/violations/company/백봉음료
```

### 5. 수동 크롤링 실행 (관리자용)

```
POST /api/crawl/manual
```

즉시 크롤링을 실행하여 DB에 저장합니다.

**응답 예시:**

```json
{
  "status": "ok",
  "message": "크롤링이 시작되었습니다. 완료까지 1-2분 정도 소요될 수 있습니다."
}
```

### 6. 특정 항목 상세 조회

```
GET /api/violations/{board_id}
```

특정 boardId의 상세 정보를 가져옵니다 (**실시간 크롤링**).

**매개변수:**

- `board_id`: 게시물 ID (예: 1766080)

**특징:**

- 실시간 크롤링 (캐시 사용 안 함)
- 최신 데이터 보장

### 7. 캐시 수동 갱신 (관리자용)

```
POST /api/cache/refresh
```

즉시 캐시를 수동으로 갱신합니다.

**응답 예시:**

```json
{
  "status": "ok",
  "message": "캐시 갱신이 시작되었습니다."
}
```

## 프로젝트 구조

```
Spring-water-notification-crawling/
├── app/
│   ├── __init__.py
│   ├── main.py                    # FastAPI 서버
│   ├── database.py                # DB 연결 설정
│   ├── db_models.py               # SQLAlchemy 모델
│   ├── crawlers/
│   │   ├── __init__.py
│   │   └── mcee_crawler.py       # 크롤링 로직
│   ├── models/
│   │   ├── __init__.py
│   │   └── violation.py          # Pydantic 모델
│   └── utils/
│       ├── __init__.py
│       └── selenium_driver.py    # Selenium 설정
├── requirements.txt
├── .gitignore
├── .env.example
├── .env                           # 환경 변수 (직접 생성)
└── README.md
```

## 주의사항

- **초기 크롤링 없음**: 서버가 시작될 때 크롤링을 수행하지 않습니다. 첫 번째 크롤링은 서버 시작 후 1시간 뒤에 실행됩니다.
- **수동 실행**: 즉시 데이터가 필요한 경우 `/api/crawl/manual` 엔드포인트를 호출하세요.
- **MySQL 필수**: MySQL 데이터베이스가 미리 생성되어 있어야 합니다.
- **자동 테이블 생성**: 서버 시작 시 필요한 테이블이 자동으로 생성됩니다.
- **크롤링 주기**: 데이터는 1시간마다 자동으로 갱신됩니다.
- **ChromeDriver**: Selenium은 ChromeDriver를 사용하며, webdriver-manager가 자동으로 관리합니다.
- **서버 부하**: 크롤링 시 대상 사이트에 부하를 주지 않도록 적절한 간격(1초)을 두고 요청합니다.

## 라이선스

MIT License
