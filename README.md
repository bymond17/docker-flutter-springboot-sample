# 🚀 Flutter + Spring Boot Docker Full-Stack Sample

이 프로젝트는 **Flutter Web** 프런트엔드와 **Spring Boot 3** 백엔드를 도커(Docker) 컨테이너로 통합 관리하는 샘플 프로젝트입니다. 환경 변수(`.env`)를 사용하여 하드코딩 없이 서버 IP를 관리하며, 멀티 스테이지 빌드와 레이어 캐싱으로 배포 효율을 극대화했습니다.

---

## 🛠 Tech Stack
- **Frontend**: Flutter 3.x (Web)
- **Backend**: Spring Boot 3.x (Java 17 / Amazon Corretto)
- **Infrastructure**: Docker, Docker Compose, Nginx

---

## 📂 Project Structure
```text
.
├── .env                 # [중요] 서버 IP 주소 설정 (Git 제외)
├── .gitignore           # .env 파일을 저장소에서 제외
├── docker-compose.yml   # 전체 서비스 오케스트레이션 및 환경 변수 전달
├── backend/             # Spring Boot 프로젝트
│   └── Dockerfile       # Gradle 의존성 캐싱 적용 빌드
└── frontend/            # Flutter Web 프로젝트
    └── Dockerfile       # 빌드 시점에 BASE_URL 주입 및 Nginx 배포
```

---

## 🚀 Quick Start (Local Development)

로컬에 개발 환경이 없어도 Docker만 있으면 1분 안에 실행 가능합니다.

1. **Repository Clone**
   ```bash
   git clone [https://github.com/bymond17/docker-flutter-springboot-sample.git](https://github.com/bymond17/docker-flutter-springboot-sample.git)
   cd docker-flutter-springboot-sample
   ```

2. **환경 변수 파일 생성**
   루트 폴더에 `.env` 파일을 만들고 로컬 주소를 입력합니다.
   ```text
   BASE_URL=http://localhost:8080
   ```

3. **Run Containers**
   ```bash
   docker-compose up --build
   ```

4. **접속 주소**
   - **Frontend**: [http://localhost](http://localhost)
   - **Backend API**: [http://localhost:8080/api/data](http://localhost:8080/api/data)

---

## 🌐 Ubuntu Server Deployment (Development)

우분투 서버 배포 시 소스 코드 수정 없이 `.env` 파일만으로 IP를 변경합니다.

1. **서버용 `.env` 설정**
   서버의 실제 공인 IP를 입력합니다.
   ```bash
   echo "BASE_URL=http://YOUR_SERVER_IP:8080" > .env
   ```

2. **배포 실행**
   ```bash
   docker-compose up --build -d
   ```

---

## ⚙️ Key Optimization & Architecture

### 1. 환경 변수 주입 (Environment Injections)
- **Flow**: `.env` ➔ `docker-compose.yml` ➔ `Dockerfile (ARG)` ➔ `Flutter (--dart-define)`
- 프런트엔드 `api_service.dart`에서 `String.fromEnvironment('BASE_URL')`를 사용하여 주입된 값을 동적으로 읽습니다.

### 2. Backend 최적화
- **Dependency Caching**: `build.gradle`을 먼저 복사하여 라이브러리 레이어를 캐싱하므로 소스 수정 시 재빌드 속도가 매우 빠릅니다.
- **Lightweight Image**: 실행 환경은 `amazoncorretto:17-al2023`을 사용하여 안정성과 가벼움을 동시에 챙겼습니다.

### 3. Frontend 최적화
- **Multi-stage Build**: Ubuntu 환경에서 빌드 후 실행 시에는 `Nginx:alpine` 환경으로 결과물만 복사하여 컨테이너 크기를 최소화했습니다.

---

## ✅ 정상 구동 확인 방법
정상적으로 실행되었다면 다음을 확인하세요.

1. **로그 확인**: `docker-compose logs -f` 입력 시 에러 없이 각 서비스가 시작되었는지 확인.
2. **화면 확인**: 브라우저에서 서버 접속 시 **"Hello from Spring Boot!"**라는 문구가 화면에 표시되면 프런트-백 통신 성공입니다.

---

## 💡 Troubleshooting
- **API 연결 실패**: `.env` 파일에 `http://` 프로토콜과 포트번호(`8080`)가 정확히 포함되었는지 확인하세요.
- **캐시 문제**: IP 수정 후 반영이 안 된다면 `docker-compose up --build`를 다시 실행하세요.

---

## 📄 License
This project is licensed under the MIT License.