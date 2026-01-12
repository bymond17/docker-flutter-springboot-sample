# 🚀 Flutter + Spring Boot Docker Full-Stack Sample

이 프로젝트는 **Flutter Web** 프런트엔드와 **Spring Boot 3** 백엔드를 도커(Docker) 컨테이너로 통합 관리하는 샘플 프로젝트입니다. 도커를 통해 로컬 개발 환경을 일관되게 유지하고, 개발 서버(Ubuntu) 배포를 자동화할 수 있도록 구성되었습니다.

---

## 🛠 Tech Stack
- **Frontend**: Flutter 3.x (Web)
- **Backend**: Spring Boot 3.x (Java 17)
- **Infrastructure**: Docker, Docker Compose, Nginx

---

## 📂 Project Structure
```text
.
├── backend/               # Spring Boot Application
│   ├── src/               # Java 소스 코드
│   ├── build.gradle       # 빌드 설정 및 의존성
│   └── Dockerfile         # Multi-stage 빌드 (Gradle -> Corretto)
├── frontend/              # Flutter Web Application
│   ├── lib/               # Dart 소스 코드 (ApiService 포함)
│   ├── pubspec.yaml       # Flutter 패키지 관리
│   └── Dockerfile         # Multi-stage 빌드 (Ubuntu -> Nginx)
└── docker-compose.yml     # 전체 서비스 통합 설정
```

---

## 🚀 Quick Start (Local Development)

로컬에 Java나 Flutter SDK가 설치되어 있지 않아도 Docker만 있으면 실행 가능합니다.

1. **Repository Clone**
   ```bash
   git clone https://github.com/bymond17/docker-flutter-springboot-sample.git
   cd docker-flutter-springboot-sample
   ```

2. **Run Containers**
   ```bash
   # 모든 서비스 빌드 및 실행
   docker-compose up --build
   ```

3. **Access Link**
   - **Frontend**: [http://localhost](http://localhost)
   - **Backend API**: [http://localhost:8080/api/data](http://localhost:8080/api/data)

---

## 🌐 Ubuntu Server Deployment (Production)

개발/운영 서버로 배포할 때는 서버의 공인 IP를 인식하도록 환경 변수 설정을 권장합니다.

1. **환경 변수(.env) 설정**
   `frontend/` 폴더 내에 `.env` 파일을 생성하거나 `docker-compose.yml`에서 직접 주입합니다.
   ```text
   BASE_URL=http://your-server-ip:8080
   ```

2. **서버 배포 실행**
   ```bash
   # 백그라운드 모드로 실행
   docker-compose up --build -d
   ```

3. **우분투 방화벽 설정**
   ```bash
   sudo ufw allow 80/tcp
   sudo ufw allow 8080/tcp
   ```

---

## ⚙️ Key Configuration Details

### 1. Backend (Java 17)
- **CORS 설정**: 프런트엔드(80)와 백엔드(8080) 간 통신을 위해 `WebMvcConfigurer`에서 모든 오리진을 허용하도록 설정되어 있습니다.
- **Dockerfile 최적화**: 레이어 캐싱을 사용하여 소스 코드가 바뀌어도 라이브러리 다운로드 단계를 건너뜁니다. 베이스 이미지는 안정적인 `amazoncorretto:17`을 사용합니다.

### 2. Frontend (Flutter Web)
- **Nginx Serving**: Flutter 빌드 결과물(web)을 가벼운 Nginx 서버를 통해 정적 파일로 서빙합니다.
- **API Connection**: `api_service.dart`에서 컨테이너 간 네트워크 통신 주소를 관리합니다.

---

## 💡 Troubleshooting & Tips

- **코드 수정 반영**: Java 또는 Dart 코드를 수정했다면 반드시 `docker-compose up --build`를 실행해야 변경 사항이 이미지에 반영됩니다.
- **자동완성 (IntelliSense)**: IDE(VS Code/IntelliJ)에서 자동완성을 사용하려면 로컬 PC에도 Java 17과 Flutter SDK를 설치한 후, `backend`와 `frontend` 폴더를 각각 별도의 워크스페이스로 여는 것이 좋습니다.
- **빌드 속도**: 첫 빌드 시 Flutter SDK 및 Gradle 의존성 다운로드로 인해 시간이 다소 소요될 수 있습니다. (캐시 생성 후에는 빨라집니다.)

---

## 📄 License
This project is licensed under the MIT License.