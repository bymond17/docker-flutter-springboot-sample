# 🚀 Flutter + Spring Boot Docker Full-Stack Sample

이 프로젝트는 **Flutter Web**과 **Spring Boot 3**를 도커로 통합 관리하는 샘플입니다. 환경 변수(`.env`) 기반의 설정 관리와 멀티 스테이지 빌드를 통한 최적화된 배포 구조를 제공합니다.

---

## 🛠 Tech Stack
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=Flutter&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-6DB33F?style=for-the-badge&logo=Spring-Boot&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=Docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=Nginx&logoColor=white)

---

## 🚀 Quick Start (1분 실행)

1. **Repository Clone**
   ```bash
   git clone [https://github.com/bymond17/docker-flutter-springboot-sample.git](https://github.com/bymond17/docker-flutter-springboot-sample.git)
   cd docker-flutter-springboot-sample
   ```

2. **환경 변수 설정** (.env 파일 생성)
   ```text
   BASE_URL=http://localhost:8080
   ```

3. **실행**
   ```bash
   docker-compose up --build
   ```
   - **Frontend**: http://localhost
   - **Backend API**: http://localhost:8080/api/data

---

## 🔍 프로젝트 상세 분석 (Architecture & Flow)

<details>
<summary><b>1. 시스템 아키텍처 (Architecture)</b></summary>

```mermaid
graph TD
    subgraph "Docker Compose Network"
        F[Flutter Web Service<br/>Port: 80] <--> |"REST API (Port: 8080)"| B[Spring Boot API Service]
        B <--> |"Embedded"| DB[(H2 Database)]
    end
    User((User Browser)) <--> |"Web Access"| F
```
</details>

<details>
<summary><b>2. 데이터 흐름 (Data Interaction)</b></summary>

```mermaid
sequenceDiagram
    participant U as User Browser
    participant F as Flutter Frontend
    participant B as Spring Boot Backend
    participant D as H2 Database

    U->>F: 페이지 접속
    F->>B: GET /api/data (데이터 요청)
    B->>D: SELECT * FROM data (SQL 실행)
    D-->>B: 결과 데이터 반환
    B-->>F: JSON 데이터 응답
    F-->>U: 화면 업데이트 ("Hello from Spring Boot!")
```
</details>

<details>
<summary><b>3. 백엔드 구조 및 빌드 프로세스</b></summary>

#### 클래스 구조

```mermaid
classDiagram
    class UserController { +getData() }
    class UserService { +fetchData() }
    class UserRepository { <<interface>> +findAll() }
    UserController --> UserService
    UserService --> UserRepository
```

#### 빌드 생명주기

```mermaid
stateDiagram-v2
    [*] --> DockerComposeUp
    DockerComposeUp --> BackendBuild: Gradle 캐싱 빌드
    DockerComposeUp --> FrontendBuild: Flutter Web 빌드
    BackendBuild --> Running: 컨테이너 가동
    FrontendBuild --> Running: 컨테이너 가동
```
</details>

---

## ⚙️ 주요 최적화 포인트
- **환경 변수 주입**: `.env` 설정값이 Docker 빌드 타임을 거쳐 Flutter `--dart-define`으로 자동 주입됩니다.
- **레이어 캐싱**: `backend/Dockerfile`은 의존성(build.gradle)을 먼저 복사하여 재빌드 속도를 높였습니다.
- **멀티 스테이지 빌드**: 빌드 결과물만 `nginx:alpine`으로 복사하여 최종 이미지 크기를 최소화했습니다.

---

## 📄 License
MIT License