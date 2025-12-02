# SSH 터널링을 통한 MySQL 연결 가이드

## 개요

원격 서버의 MySQL에 SSH 터널을 통해 안전하게 연결합니다.

## 설정 방법

### 1. sshtunnel 패키지 설치

```bash
pip install sshtunnel==0.4.0
```

### 2. 환경 변수 설정 (.env 파일)

#### 방법 1: SSH 비밀번호 사용

```bash
# SSH 터널 활성화
USE_SSH_TUNNEL=true

# SSH 서버 정보
SSH_HOST=your-server.com
SSH_PORT=22
SSH_USER=your-username
SSH_PASSWORD=your-password

# MySQL 설정 (SSH 서버에서 본 MySQL 위치)
MYSQL_HOST=localhost  # SSH 서버 내부에서는 localhost
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=your-mysql-password
MYSQL_DATABASE=mcee_violations
```

#### 방법 2: SSH 키 사용 (권장)

```bash
# SSH 터널 활성화
USE_SSH_TUNNEL=true

# SSH 서버 정보
SSH_HOST=your-server.com
SSH_PORT=22
SSH_USER=your-username
SSH_KEY_PATH=/Users/yourname/.ssh/id_rsa  # SSH 키 파일 경로

# MySQL 설정
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=your-mysql-password
MYSQL_DATABASE=mcee_violations
```

### 3. 서버 실행

```bash
uvicorn app.main:app --reload
```

## 작동 방식

1. **앱 시작 시**: SSH 터널이 자동으로 생성됩니다
2. **연결**: 로컬 포트(자동 할당) → SSH 서버 → MySQL
3. **앱 종료 시**: SSH 터널이 자동으로 닫힙니다

## 직접 연결로 전환

SSH 터널 없이 직접 MySQL에 연결하려면:

```bash
USE_SSH_TUNNEL=false
MYSQL_HOST=mysql-server.com  # 외부에서 접근 가능한 MySQL 주소
MYSQL_PORT=3306
```

## 문제 해결

### SSH 연결 오류

```bash
# SSH 키 권한 확인
chmod 600 ~/.ssh/id_rsa

# SSH 연결 테스트
ssh -i ~/.ssh/id_rsa username@your-server.com
```

### MySQL 연결 오류

```bash
# SSH 서버에서 MySQL 연결 확인
mysql -u root -p -h localhost
```

### 로그 확인

서버 시작 시 다음 로그가 표시되어야 합니다:

```
Starting SSH tunnel to your-server.com:22...
SSH tunnel started successfully. Local port: 12345
Using SSH tunnel connection: 127.0.0.1:12345
```

## 보안 권장사항

1. **SSH 키 사용**: 비밀번호보다 SSH 키를 사용하세요
2. **.env 파일 보호**: `.gitignore`에 `.env` 추가
3. **방화벽 설정**: SSH 서버에서 MySQL 포트를 외부에 노출하지 마세요

## 예시 시나리오

### AWS EC2에서 RDS 연결

```bash
USE_SSH_TUNNEL=true
SSH_HOST=ec2-xx-xx-xx-xx.compute.amazonaws.com
SSH_USER=ec2-user
SSH_KEY_PATH=/Users/yourname/.ssh/ec2-key.pem
MYSQL_HOST=your-rds-endpoint.rds.amazonaws.com
MYSQL_PORT=3306
```

### 일반 Linux 서버

```bash
USE_SSH_TUNNEL=true
SSH_HOST=192.168.1.100
SSH_USER=ubuntu
SSH_PASSWORD=your-password
MYSQL_HOST=localhost
MYSQL_PORT=3306
```
