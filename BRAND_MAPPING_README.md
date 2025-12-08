# 🎓 교육용 프로젝트 | Academic Project Only

**본 프로젝트는 대학 수업의 팀 프로젝트입니다.**  
**실제 서비스가 아니며, 교육 및 포트폴리오 목적으로만 사용됩니다.**

---

## 📋 브랜드 매핑 데이터베이스 구조

### 1️⃣ **테이블 구조**

#### `water_sources` (취수원 테이블)

- 1개의 취수원은 여러 브랜드에 물을 공급할 수 있음 (1:N 관계의 "1")
- 주요 필드:
  - `취수원업체명`: violations 테이블의 업체명과 매칭
  - `취수원소재지`, `취수원종류`, `허가번호`
  - `데이터출처`, `최종확인일`

#### `brands` (브랜드 테이블)

- N개의 브랜드가 1개의 취수원을 사용 (1:N 관계의 "N")
- 주요 필드:
  - `water_source_id`: 취수원 외래 키
  - `브랜드명`, `제조사`, `대표제품명`
  - `제품라인` (JSON 배열)
  - `활성상태`: 현재 판매 중 여부

### 2️⃣ **관계 구조**

```
water_sources (1) ──────< brands (N)
     ↓
violations (업체명 매칭)
```

### 3️⃣ **주요 뷰**

#### `violations_with_brands`

- 위반사항 + 연관 브랜드 정보를 조인한 뷰
- 위반 발생 시 어떤 브랜드들이 영향받는지 바로 확인 가능

#### `brand_violation_stats`

- 브랜드별 위반 통계
- 총 위반 건수, 최근/최초 위반일, 위반 내역

---

## 🚀 사용 방법

### 1. DB 스키마 생성

```bash
mysql -u [username] -p mcee_violations < database_setup_brand_mapping.sql
```

### 2. TypeScript 타입

- `types/violations.ts`: 모든 타입 정의
- `lib/brands-api.ts`: API 클라이언트 함수

### 3. 주요 API 함수

```typescript
// 브랜드 검색
const brands = await searchBrandsByName("삼다수");

// 취수원이 공급하는 브랜드 조회
const brands = await fetchBrandsByWaterSourceName("제주특별자치도개발공사");

// 위반사항 + 브랜드 정보
const violations = await fetchViolationsWithBrands();

// 브랜드별 위반 통계
const stats = await fetchBrandViolationStats();
```

---

## ⚠️ 면책사항

본 데이터베이스 구조는:

- ✅ 교육 목적으로 설계됨
- ✅ 공공데이터 기반 (식약처)
- ❌ 실제 배포 서비스 아님
- ❌ 법적 효력 없음

---

## 📊 샘플 데이터

스키마 파일에 3개의 샘플 데이터가 포함되어 있습니다:

- 제주삼다수
- 평창수
- 아이시스8.0

실제 프로젝트에서는 더 많은 브랜드 데이터를 추가해야 합니다.
