# 🐳 Docker 배포 가이드

간단하게 Docker로 배포하는 방법입니다.

## 📋 사전 준비

### Docker 설치

```bash
# macOS (Homebrew 사용)
brew install --cask docker

# Linux (Ubuntu/Debian)
curl -fsSL https://get.docker.com | sudo sh

# 설치 확인
docker --version
docker-compose --version
```

---

## 🚀 배포 방법

### 1️⃣ 환경 변수 설정

`.env` 파일이 이미 있는지 확인하고, 없으면 `.env.example`을 복사:

```bash
cp .env.example .env
nano .env  # 또는 원하는 에디터로 수정
```

### 2️⃣ Docker 이미지 빌드

```bash
docker build -t spring-water-notification .
```

### 3️⃣ 컨테이너 실행

**방법 A: docker-compose 사용 (권장)**

```bash
# 백그라운드 실행
docker-compose up -d

# 로그 확인
docker-compose logs -f
```

**방법 B: docker run 사용**

```bash
docker run -d \
  -p 8000:8000 \
  --name spring-water-notification \
  --env-file .env \
  spring-water-notification
```

### 4️⃣ 접속 확인

```bash
# API 확인
curl http://localhost:8000/

# 브라우저에서
# http://localhost:8000/docs
```

---

## 🔧 자주 사용하는 명령어

### 컨테이너 관리

```bash
# 실행 중인 컨테이너 확인
docker ps

# 로그 확인
docker-compose logs -f

# 컨테이너 중지
docker-compose down

# 컨테이너 재시작
docker-compose restart

# 컨테이너 완전 삭제
docker-compose down -v
```

### 업데이트 배포

```bash
# 코드 수정 후

# 1. 이미지 다시 빌드
docker-compose build

# 2. 컨테이너 재시작
docker-compose up -d

# 또는 한 번에
docker-compose up -d --build
```

---

## 🌐 서버에 배포하기

### 1. 서버에 파일 업로드

```bash
# 필요한 파일만 서버로 복사
scp -r .env docker-compose.yml Dockerfile requirements.txt app/ user@your-server.com:/app/spring-water/
```

### 2. 서버에서 실행

```bash
# 서버 접속
ssh user@your-server.com

# 디렉토리 이동
cd /app/spring-water

# 실행
docker-compose up -d

# 로그 확인
docker-compose logs -f
```

### 3. 방화벽 설정 (필요시)

```bash
# 포트 8000 열기
sudo ufw allow 8000/tcp
```

---

## 🐛 문제 해결

### 포트가 이미 사용 중인 경우

```bash
# 8000 포트를 사용하는 프로세스 확인
lsof -i :8000

# 또는 다른 포트 사용
# docker-compose.yml에서 "8000:8000" → "8080:8000" 으로 변경
```

### 컨테이너가 계속 재시작되는 경우

```bash
# 로그 확인
docker-compose logs

# 컨테이너 내부 진입해서 디버깅
docker-compose exec app bash
```

### 이미지 다시 빌드

```bash
# 캐시 없이 새로 빌드
docker-compose build --no-cache

# 기존 이미지 삭제
docker rmi spring-water-notification
```

---

## ✨ 완료!

이제 `http://localhost:8000`에서 API가 실행 중입니다!

- API 문서: http://localhost:8000/docs
- 상태 확인: http://localhost:8000/
