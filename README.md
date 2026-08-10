# CodeLearning Platform 🚀

<div align="center">
  <a href="https://www.codelearning.io.vn/" target="_blank">
    <img src="https://img.shields.io/badge/Live_Demo-https://www.codelearning.io.vn/-blue?style=for-the-badge&logo=vercel&logoColor=white" alt="Live Demo" />
  </a>

  <p align="center">
    <b>An enterprise-grade Full-Stack E-learning & Online Judge platform featuring automated multi-language code evaluation, real-time contest execution, and integrated financial transactions.</b>
  </p>

  <h3>🌐 Visit the Live Demo Website at: <a href="https://www.codelearning.io.vn/">www.codelearning.io.vn</a></h3>

  <br/>

  <!-- Frontend Badges -->
  [![React](https://img.shields.io/badge/React-19-blue.svg?logo=react)](https://react.dev/)
  [![TypeScript](https://img.shields.io/badge/TypeScript-5.0-blue.svg?logo=typescript)](https://www.typescriptlang.org/)
  [![Vite](https://img.shields.io/badge/Vite-6.0-purple.svg?logo=vite)](https://vitejs.dev/)
  [![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-v4-38B2AC.svg?logo=tailwind-css)](https://tailwindcss.com/)

  <!-- Backend & Infra Badges -->
  [![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.5.7-brightgreen.svg?logo=springboot)](https://spring.io/projects/spring-boot)
  [![Java 21](https://img.shields.io/badge/Java-21-orange.svg?logo=openjdk)](https://www.oracle.com/java/technologies/downloads/)
  [![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue.svg?logo=postgresql)](https://www.postgresql.org/)
  [![Redis](https://img.shields.io/badge/Redis-7-red.svg?logo=redis)](https://redis.io/)
  [![RabbitMQ](https://img.shields.io/badge/RabbitMQ-3-orange.svg?logo=rabbitmq)](https://www.rabbitmq.com/)
  [![Docker](https://img.shields.io/badge/Docker-Supported-blue.svg?logo=docker)](https://www.docker.com/)
  [![PayOS](https://img.shields.io/badge/Payment-PayOS-green.svg)](https://payos.vn/)
</div>

An advanced **Full-Stack E-learning & Online Judge (OJ) platform** engineered with **Spring Boot 3.5.7**, **Java 21**, and **React 19**. It integrates automated code execution sandboxes, real-time status updates via WebSockets, event-driven contest scheduling, and secure payment processing.

Designed with enterprise-grade architectures (Layered Monolith, Monorepo, Event-Driven, Asynchronous execution), this project demonstrates practical solutions to high concurrency, resource management, performance optimization, and web application security.

---

## 🌟 Key Features

### ⚡ 1. Online Judge (Automated Code Evaluation System)
* **Monaco Code Editor**: Integrated feature-rich code editor (VS Code-like interface) supporting code completion, syntax highlighting, and custom themes across multiple programming languages (C++, Java, Python, JavaScript, etc.).
* **Asynchronous Sandbox Evaluation (Judge0)**: Submits source code to the evaluation sandbox asynchronously via **Spring WebFlux** & Webhooks, providing exact testcase verdicts (`Accepted`, `Wrong Answer`, `TLE`, `MLE`, `Compile Error`).
* **Real-time Status Updates (WebSocket STOMP)**: Pushes real-time evaluation progress and final submission results directly from backend to frontend clients via WebSockets without requiring page refreshes.
* **Short-Circuit Evaluation Logic**: Automatically halts judgment and returns immediate failure upon encountering the first failed testcase, conserving sandbox computing resources during live contests.

### 💳 2. Cart & Payment Gateway (Cart & PayOS Integration)
* **Cart & Order Management**: Allows users to add multiple courses to cart, apply promotional vouchers/discount codes, and create seamless checkout orders.
* **PayOS Payment Gateway Integration**: Automatically generates dynamic banking QR codes for instant, hassle-free bank transfers.
* **Transaction Safety (Idempotency & Pessimistic Locking)**: Processes PayOS webhook callbacks reliably using Postgres pessimistic locking (`SELECT FOR UPDATE` via `findByUserIdWithLock`) to credit wallets and activate courses securely, preventing race conditions.

### 🛡️ 3. Authentication & Security (Authentication & Authorization)
* **Multi-Factor / Multi-Provider Auth**: Supports standard Email/Password authentication as well as **Google OAuth2 Single Sign-On (SSO)**.
* **Secure Token Management (JWT + RTR)**: Resolves JWT tokens dynamically from either standard `Authorization` headers or secure `HttpOnly`, `SameSite` cookies (mitigating XSS/CSRF attacks). Enforces **Refresh Token Rotation (RTR)** to issue fresh token pairs while blacklisting revoked tokens (`invalidated_tokens`).
* **Dynamic Authorization (Dynamic RBAC & Contextual SpEL)**: Role-based access control (`STUDENT`, `INSTRUCTOR`, `ADMIN`) with fine-grained method-level security (`@PreAuthorize`) evaluating SpEL expressions to verify resource ownership and course enrollment before granting access.

### ✉️ 4. Enterprise Async Email Pipeline (RabbitMQ & SendGrid Integration)
* **Batch Processing & Message Queue**: Chunks recipient lists into batches (500 users/batch) and dispatches them asynchronously through **RabbitMQ** (`email.exchange` & `bulk.email.queue`).
* **SendGrid Dynamic Templates**: Integrates SendGrid API v3 with dynamic template data binding for personalized bulk email delivery.
* **DLQ Recovery & Webhook Telemetry**: Stores failed delivery attempts in a DLQ database table (`FailedEmailQueueEntity`) for retries, and verifies SendGrid Webhook signatures (`X-Twilio-Email-Event-Webhook-Signature`) to record real-time delivery telemetry (`delivered`, `open`, `click`, `bounce`).


---

## 🗺️ System Architecture

### 1. Asynchronous Webhook-Driven Online Judge (OJ) Flow
To prevent blocking main application threads during long-running code evaluation in the sandbox, the evaluation process is decoupled into a non-blocking asynchronous flow using **Spring WebFlux (WebClient)**, **Redis Atomic Counter**, and **WebSocket (STOMP)**.

```mermaid
sequenceDiagram
    autonumber
    actor Student as Student (Web Client)
    participant API as Spring Boot Backend
    participant Redis as Redis Cache
    participant Sandbox as Judge0 Sandbox
    participant DB as PostgreSQL DB

    Student->>API: Submit Code (Problem ID, Language, Source Code)
    activate API
    API->>DB: Save Submission & Details (Status: PENDING)
    API->>Sandbox: Batch Submission Request (Async WebClient)
    activate Sandbox
    Sandbox-->>API: Return Batch Tokens (UUIDs)
    deactivate Sandbox
    API->>Student: Return Submission ID (Immediate HTTP 200)
    deactivate API
    
    Note over Student: Shows Progress Bar (WebSocket listener active)

    loop Webhook Callbacks per Testcase
        Sandbox->>API: PUT /online-judge/webhooks (Token, Verdict, CPU/Memory)
        activate API
        API->>DB: Update Testcase Status (AC, WA, TLE, etc.)
        API->>Redis: Increment Atomic Progress Counter (opsForValue().increment)
        
        alt Contest Mode: Short-Circuit Logic (First Failure)
            API->>Redis: Lock result using setIfAbsent("oj_failed:submissionId")
            Note over API, Redis: If locking succeeds, mark final verdict (e.g. WA) & skip waiting for remaining testcases
            API->>DB: Mark Submission as COMPLETED (Verdict: WA)
            API->>Student: Push Final Result via WebSocket STOMP
        else Normal Mode: All Testcases Completed
            Redis-->>API: Counter reaches N (Total Testcases)
            API->>DB: Calculate Final Verdict & Save
            API->>Student: Push Final Result via WebSocket STOMP
            API->>Redis: Clear Redis keys (Deregister counter & lock)
        end
        deactivate API
    end
```

---

### 2. PayOS Payment & Checkout Flow (Idempotent Webhook, Late Payment & Cron Reconciliation)
To process financial transactions reliably without money loss, race conditions, or duplicate payments, the checkout workflow combines **PayOS Dynamic Banking QR Codes**, **HMAC-SHA256 Signature Verification**, **PostgreSQL Pessimistic Locking (`SELECT FOR UPDATE`)**, **Late Payment Handling (`LATE_SUCCESS`)**, and **Active CronJob Reconciliation**.

```mermaid
sequenceDiagram
    autonumber
    actor Customer as User / Student
    participant API as Spring Boot Backend
    participant Cron as Payment CronJob (Every 5 mins)
    participant PayOS as PayOS Gateway API
    participant DB as PostgreSQL DB (Pessimistic Lock)

    Customer->>API: POST /payments/deposit (Create Deposit Request)
    activate API
    API->>DB: Save PaymentTransaction (Status: PENDING)
    API->>PayOS: Request Payment Link (v2/payment-requests)
    activate PayOS
    PayOS-->>API: Return Checkout Payload (Payment Link, Dynamic QR Code)
    deactivate PayOS
    API-->>Customer: Return Checkout QR Code & Redirect URL
    deactivate API

    alt Path A: Standard Asynchronous Webhook Delivery
        PayOS->>API: POST /payment/payos-webhook (Webhook Payload & Signature Header)
        activate API
        API->>API: Verify Webhook Signature (HMAC-SHA256 Checksum)
        
        alt Idempotency Guard: Already SUCCESS or LATE_SUCCESS
            API-->>PayOS: Return HTTP 200 OK (Ignore duplicate webhook)
        else Transaction PENDING or CANCELLED
            API->>DB: Acquire Lock via findByUserIdWithLock (SELECT FOR UPDATE)
            activate DB
            alt Transaction Status was CANCELLED or EXPIRED (Late Payment)
                API->>DB: Mark Status -> LATE_SUCCESS (Prevent Customer Money Loss)
            else Transaction Status was PENDING
                API->>DB: Mark Status -> SUCCESS
            end
            API->>DB: Credit Wallet Balance & Write Wallet Transaction Ledger
            DB-->>API: Commit Transaction & Release Lock
            deactivate DB
            API-->>PayOS: Return HTTP 200 OK (Webhook Processed)
        end
        deactivate API

    else Path B: Active CronJob Reconciliation (Missed Webhooks & Auto Expiry)
        Cron->>DB: Scan Pending Transactions (Status == PENDING)
        activate Cron
        loop For each Pending Transaction (> 5 mins)
            Cron->>PayOS: GET /v2/payment-requests/{orderCode}
            activate PayOS
            PayOS-->>Cron: Return Transaction Status (PAID / CANCELLED / PENDING)
            deactivate PayOS
            
            alt PayOS Status == PAID (Missed Webhook Recovery)
                Cron->>API: Trigger Fallback Processing (Lock Wallet & Credit Balance)
                API->>DB: Mark Status -> SUCCESS / LATE_SUCCESS & Update Wallet
            else PayOS Status == CANCELLED / EXPIRED or PENDING > 30 mins
                Cron->>DB: Force Update Status -> CANCELLED (Release Stale Tx)
            end
        end
        deactivate Cron
    end
```

---

### 3. Security Architecture & Dynamic Authorization
The security subsystem is built around **Spring Security** configured as an **OAuth2 Resource Server** with token verification against a token blacklist.

```mermaid
graph TD
    A[Client Request] --> B[SecurityFilterChain]
    B --> C[CorsFilter / CsrfFilter]
    C --> D[BearerTokenResolver]
    D -->|Extract JWT from Authorization Header OR HttpOnly Cookie| E[BearerTokenAuthenticationFilter]
    E --> F[OAuth2AuthenticationProvider]
    F --> G[CustomJwtDecoder]
    G -->|Introspect: Check JTI Blacklist| H(AuthenticationService)
    H -->|Query DB invalidated_tokens| I[(PostgreSQL)]
    I -->|Return validity status| G
    G -->|Decode & Verify Signature| J[NimbusJwtDecoder]
    J --> K[JwtAuthenticationConverter]
    K -->|Map scopes to GrantedAuthorities| L[SecurityContextHolder]
    L --> M[Method Security Filter: @PreAuthorize]
    M -->|Evaluate SpEL invoking @courseSecurity| N[CourseSecurity Bean]
    N -->|Perform Contextual DB Checks| I
    N -->|Allow Access| O[Controller Endpoint]
```

---

### 4. Asynchronous Bulk Email Pipeline (RabbitMQ & SendGrid Integration)
To handle mass email distribution efficiently without HTTP request timeouts or API rate-limit violations, the system utilizes **RabbitMQ Message Queues**, **SendGrid Dynamic Templates**, **Database DLQ**, and **Webhook Signature Telemetry**.

```mermaid
sequenceDiagram
    autonumber
    actor Admin as Admin / System Event
    participant Producer as EmailProducerService
    participant Rabbit as RabbitMQ (email.exchange)
    participant Consumer as EmailConsumerService (@RabbitListener)
    participant SendGrid as SendGrid API v3
    participant DB as PostgreSQL DB
    participant Webhook as SendGrid Webhook Controller

    Admin->>Producer: POST /api/admin/email/send-campaign (Target & Template ID)
    activate Producer
    Producer->>DB: Fetch Valid Target Users (isEmailValid == true)
    Producer->>Producer: Chunk Recipients into Batches (500 users/batch with Batch ID)
    Producer->>Rabbit: Publish BulkEmailMessage to email.exchange (Routing: email.bulk)
    Producer-->>Admin: Return HTTP 200 OK (Batch Dispatched Asynchronously)
    deactivate Producer

    activate Consumer
    Rabbit->>Consumer: Consume BulkEmailMessage from bulk.email.queue
    Consumer->>Consumer: Map Batch Data into SendGrid Personalizations
    
    alt Successful SendGrid API Call
        Consumer->>SendGrid: POST /v3/mail/send (Template ID & Personalizations)
        activate SendGrid
        SendGrid-->>Consumer: Return HTTP 202 Accepted
        deactivate SendGrid
    else API Error / Delivery Failure
        Consumer->>DB: Save Payload to FailedEmailQueueEntity (Status: PENDING_RETRY)
    end
    deactivate Consumer

    note over SendGrid, Webhook: Asynchronous Delivery Tracking via SendGrid Webhook Callback
    SendGrid->>Webhook: POST /api/webhooks/sendgrid (Events & Signature Header)
    activate Webhook
    Webhook->>Webhook: Verify Signature (X-Twilio-Email-Event-Webhook-Signature)
    Webhook->>DB: Save Telemetry Log to EmailDeliveryLogEntity (Delivered / Open / Bounce)
    Webhook-->>SendGrid: Return HTTP 200 OK
    deactivate Webhook
```

---


## 🛠️ Tech Stack & Dependencies

| Layer | Technology / Library |
| :--- | :--- |
| **Frontend Framework** | React 19, TypeScript 5, Vite 6 |
| **UI & Styling** | Tailwind CSS v4, Framer Motion, Lucide Icons |
| **Code Editor & Tools** | `@monaco-editor/react`, Axios, i18next |
| **Realtime Communication** | SockJS-client, STOMPjs (WebSockets) |
| **Backend Framework** | Java 21, Spring Boot 3.5.7 (WebFlux, OAuth2 Resource Server, Data JPA) |
| **Database & Caching** | PostgreSQL 15, Redis 7 |
| **Message Broker** | RabbitMQ 3 (with `rabbitmq_delayed_message_exchange` plugin) |
| **Sandbox Engine** | Judge0 API v1.13.1 Sandbox |
| **Integrations** | PayOS SDK (Payment Gateway), Cloudinary (Media Hosting) |
| **DevOps & Containers** | Docker, Docker Compose (Dev/Prod Profiles), NGINX |

---

## 📂 Monorepo Project Structure

```text
codelearning-platform/
├── backend/                      # Spring Boot 3.5.7 Backend Application
│   ├── src/main/java/com/thanhmila/codelearning/
│   │   ├── configuration/        # Bean configs (Redis, RabbitMQ, WebClient, PayOS, etc.)
│   │   ├── controller/           # REST Controllers (Auth, Course, Contest, OJ, Payment, User)
│   │   ├── dto/                  # Data Transfer Objects
│   │   ├── entity/               # JPA Entities mapped to PostgreSQL
│   │   ├── exception/            # Global Exception Handlers
│   │   ├── listener/             # RabbitMQ Queue Consumers
│   │   ├── repository/           # Spring Data JPA Repositories (Projections, Specifications)
│   │   ├── security/             # Security configs, Custom JWT Decoder & SpEL Evaluators
│   │   └── service/              # Core Business Logic Services
│   ├── Dockerfile                # Multi-stage Dockerfile for Backend
│   ├── Dockerfile.rabbitmq       # RabbitMQ Dockerfile with Delayed Exchange plugin
│   └── pom.xml                   # Maven dependencies
├── frontend/                     # React 19 + TypeScript + Vite Frontend Application
│   ├── src/
│   │   ├── api/                  # Axios API Clients & Endpoints
│   │   ├── components/           # Reusable UI Components (Monaco Editor, Modals, Navbar)
│   │   ├── pages/                # Page Components (Home, OJ, Courses, Contest, Cart, Admin)
│   │   ├── context/              # React Context (Auth, Theme, Cart)
│   │   └── layouts/              # Main App & Dashboard Layouts
│   ├── Dockerfile                # NGINX Container Dockerfile
│   └── package.json              # Node.js dependencies
├── database/                     # Database Initialization Scripts
│   └── init.sql                  # PostgreSQL Schema & Seed Data
├── docs/                         # Detailed System Architecture & Workflow Specs
│   ├── project_analysis_report.md
│   ├── workflow_judge0.md
│   ├── generation_testcase_automation.md
│   ├── rabbitmq_contest_status_workflow.md
│   └── workflow_cart_payment.md
├── docker-compose.dev.yml        # Orchestration for Development Environment
├── docker-compose.prod.yml       # Orchestration for Production Environment
├── judge0.conf                   # Judge0 Sandbox Configuration
└── README.md                     # Monorepo Documentation
```

---

## 🚀 Getting Started & Local Setup

### 📋 Prerequisites
Ensure you have the following installed on your machine:
* [Docker & Docker Compose](https://www.docker.com/)
* [JDK 21](https://www.oracle.com/java/technologies/downloads/) (Optional for manual backend run)
* [Node.js 20+](https://nodejs.org/) & `npm` (Optional for manual frontend run)

---

### 1. Environment Variables Setup

#### Backend Environment (`backend/.env`):
Create a `.env` file in the `backend/` directory:
```env
# SERVER CONFIG
PORT=8080
ALLOWED_ORIGINS=http://localhost:3000,http://localhost:5173

# POSTGRES DB
DB_HOST=localhost
DB_PORT=5432
DB_NAME=codelearning
DB_USERNAME=postgres
DB_PASSWORD=your_secure_password

# REDIS
REDIS_HOST=localhost
REDIS_PORT=6379

# RABBITMQ
RABBITMQ_HOST=localhost
RABBITMQ_PORT=5672
RABBITMQ_USERNAME=guest
RABBITMQ_PASSWORD=guest

# SECURITY (JWT)
JWT_SIGNER_KEY=your_super_secret_32_characters_key_here
JWT_ACCESS_COOKIE_NAME=access_token
JWT_REFRESH_COOKIE_NAME=refresh_token

# THIRD-PARTY INTEGRATIONS
CLOUDINARY_CLOUD_NAME=your_cloudinary_name
CLOUDINARY_API_KEY=your_cloudinary_key
CLOUDINARY_API_SECRET=your_cloudinary_secret

PAYOS_CLIENT_ID=your_payos_client_id
PAYOS_API_KEY=your_payos_api_key
PAYOS_CHECKSUM_KEY=your_payos_checksum_key

# JUDGE0 (OJ SANDBOX)
JUDGE0_API_URL=http://localhost:2358
JUDGE0_WEBHOOK_URL=http://your-public-ip-or-ngrok/online-judge/webhooks/submissions
```

#### Frontend Environment (`frontend/.env`):
Create a `.env` file in the `frontend/` directory:
```env
VITE_API_BASE_URL=http://localhost:8080
VITE_GOOGLE_CLIENT_ID=your_google_oauth_client_id
```

---

### 2. Run via Docker Compose (Recommended)

Run all services (Database, Redis, RabbitMQ, Judge0 Sandbox, Backend, and Frontend) using Docker Compose profiles:

#### Development Environment:
```bash
docker compose -f docker-compose.dev.yml --profile backend --profile frontend --profile judge0 up -d
```

#### Production Environment:
```bash
docker compose -f docker-compose.prod.yml --profile backend --profile frontend --profile judge0 up -d
```

> [!NOTE]
> Docker Compose is configured with `healthchecks`. Services will start in order, waiting for PostgreSQL, Redis, and RabbitMQ to become healthy before launching the Spring Boot Backend and React Frontend.

---

### 3. Manual Local Execution (Alternative)

#### A. Run Infrastructure Dependencies Only:
```bash
docker compose -f docker-compose.dev.yml up -d db redis rabbitmq judge0-server judge0-workers judge0-db judge0-redis
```

#### B. Start Backend (Spring Boot):
```bash
cd backend
mvn clean package -DskipTests
mvn spring-boot:run
```
Backend will start at `http://localhost:8080`.

#### C. Start Frontend (Vite + React):
```bash
cd frontend
npm install
npm run dev
```
Frontend will be available at `http://localhost:5173`.

---

## 📚 Detailed System Documentation & Design Specs

For in-depth analysis and workflow specifications of individual subsystems, refer to the documents in the [/docs](docs) directory:
* [📄 Architectural Review & Security Audit](docs/project_analysis_report.md) - System architecture design decisions, bottlenecks & solutions.
* [🔌 Online Judge (OJ) Integration Specification](docs/workflow_judge0.md) - Deep dive into Judge0 sandbox communication & Webhook handling.
* [⚙️ Testcase Automation Engine Workflow](docs/generation_testcase_automation.md) - Auto-generation of test inputs & expected outputs via sandbox.
* [⏱️ RabbitMQ Delayed Contest Scheduling](docs/rabbitmq_contest_status_workflow.md) - Reliable scheduled updates using RabbitMQ delayed exchanges.
* [💳 Cart, Orders & PayOS Wallet Ledger](docs/workflow_cart_payment.md) - Financial transaction ledger, cart processing, and PayOS integration.

---

## 👩‍💻 Author

* **Võ Ngọc Thanh (Thanh_MiLa)** - [GitHub Profile](https://github.com/ThanhMiLa)
* **Role:** Full-Stack & System Engineer
