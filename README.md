# 🚀 Flutter + Spring Boot Docker Full-Stack Sample

이 프로젝트는 **Flutter Web** 프런트엔드와 **Spring Boot 3** 백엔드를 도커(Docker) 컨테이너로 통합 관리하는 샘플 프로젝트입니다. 멀티 스테이지 빌드와 레이어 캐싱을 적용하여 빌드 속도를 최적화하였으며, 개발 서버(Ubuntu) 배포에 최적화되어 있습니다.

---

## 🛠 Tech Stack
- **Frontend**: Flutter 3.x (Web)
- **Backend**: Spring Boot 3.x (Java 17 / Amazon Corretto)
- **Infrastructure**: Docker, Docker Compose, Nginx

---

## 📂 Project Structure
```text
.
├── backend/               # Spring Boot Application
│   ├── src/               # Java 소스 코드
│   ├── build.gradle       # 빌드 설정 (Dependency Caching 적용)
│   └── Dockerfile         # Multi-stage 빌드 (Gradle -> Amazon Corretto)
├── frontend/              # Flutter Web Application
│   ├── lib/               # Dart 소스 코드 (ApiService 포함)
│   ├── pubspec.yaml       # Flutter 패키지 관리
│   └── Dockerfile         # Multi-stage 빌드 (Ubuntu -> Nginx)
└── docker-compose.yml     # 전체 서비스 오케스트레이션 및 네트워크 설정
```

---

## 🚀 Quick Start (Local Development)

로컬에 Java나 Flutter SDK가 설치되어 있지 않아도 Docker만 있으면 즉시 실행 가능합니다.

1. **Repository Clone**
   ```bash
   git clone https://github.com/bymond17/docker-flutter-springboot-sample.git
   cd docker-flutter-springboot-sample
   ```

2. **Run Containers**
   ```bash
   # 서비스 빌드 및 백그라운드 실행
   docker-compose up --build -d
   ```

3. **Access Link**
   - **Frontend**: [http://localhost](http://localhost)
   - **Backend API**: [http://localhost:8080/api/data](http://localhost:8080/api/data)

---

## 🌐 Ubuntu Server Deployment (Production)

개발/운영 서버 배포 시 외부 접속을 위해 API 주소 설정을 확인해야 합니다.

1. **API 주소 설정 (프런트엔드)**
   `frontend/lib/services/api_service.dart` 파일의 `baseUrl`을 서버의 공인 IP로 수정합니다.
   ```dart
   static const String baseUrl = "http://YOUR_SERVER_IP:8080";
   ```

2. **서버 배포 실행**
   ```bash
   docker-compose up --build -d
   ```

3. **우분투 방화벽 설정**
   ```bash
   sudo ufw allow 80/tcp
   sudo ufw allow 8080/tcp
   ```

---

## ⚙️ Key Optimization Details

### 1. Backend (Dependency Caching)
`build.gradle` 파일을 먼저 복사하여 의존성을 미리 다운로드합니다. 소스 코드가 변경되어도 라이브러리 다운로드 단계를 건너뛰어 재빌드 속도가 비약적으로 향상됩니다.

### 2. Frontend (Flutter SDK Caching)
Dockerfile 내에서 Flutter SDK 설치 레이어를 상단에 배치하여 캐싱합니다. 또한, 최종 이미지는 `nginx:stable-alpine`을 사용하여 이미지 크기를 최소화했습니다.

### 3. Docker Compose
- **Restart Policy**: `always` 설정을 통해 서버 재부팅 시 컨테이너 자동 실행을 보장합니다.
- **Logging**: `max-size: 10m` 설정을 통해 로그 파일이 서버 용량을 과다하게 점유하는 것을 방지합니다.

---

## ✅ 정상 구동 확인 방법
정상적으로 실행되었다면 터미널 로그(`docker-compose logs -f`)에서 다음을 확인하세요.

1. **Backend**: `Tomcat started on port(s): 8080` 로그 출력 여부
2. **Frontend**: 브라우저 접속 시 Flutter 로고와 함께 백엔드 데이터("Hello from Spring Boot!") 출력 여부

---

## 💡 Troubleshooting

- **반영 안 됨**: 코드 수정 후 반영되지 않는다면 `docker-compose build --no-cache` 명령어를 사용하세요.
- **포트 충돌**: 80 또는 8080 포트가 이미 사용 중이라면 `docker-compose.yml`의 `ports` 설정을 변경하세요.

---

## 📄 License
This project is licensed under the MIT License.