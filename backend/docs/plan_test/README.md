# 📑 HỆ THỐNG KẾ HOẠCH KIỂM THỬ TOÀN DIỆN (COMPREHENSIVE TEST SUITE BLUEPRINT)
Dự án: **CodeLearning Platform Backend**  
Thư mục: `backend/docs/plan_test/`  
Mục tiêu chất lượng: **Line Coverage $\ge 90\%$, Branch Coverage $\ge 85\%$ (100% cho Core Business Logic)**

---

## 🎯 Giới thiệu tổng quan

Hệ thống kế hoạch kiểm thử này được thiết kế toàn diện cho toàn bộ các thành phần của nền tảng **CodeLearning**: từ tầng Business Services cốt lõi, Security, Filters, Schedulers, External Integrations (RabbitMQ, SendGrid, Cloudinary, Judge0), đến tầng WebMvc Controllers và MapStruct Mappers.

---

## 🗺️ Bản đồ Kế hoạch Kiểm thử (Test Plans Directory)

### Nhóm 1: Master Strategy & Core Business Services
| STT | Tập tin Kế hoạch | Module phụ trách | Trọng tâm phân tích rẽ nhánh & Line Code | Trạng thái |
| :---: | :--- | :--- | :--- | :---: |
| **00** | [**00_MASTER_TEST_STRATEGY_AND_STANDARDS.md**](00_MASTER_TEST_STRATEGY_AND_STANDARDS.md) | **Chiến lược & Tiêu chuẩn chung** | Kim tự tháp test, Cấu hình Maven `pom.xml`, Plugin JaCoCo, cấu hình `lombok.config`, quy chuẩn đặt tên AAA. | ✅ Đã cấu hình |
| **01** | [**01_PLAN_AUTH_AND_USER_MODULE.md**](01_PLAN_AUTH_AND_USER_MODULE.md) | **Auth & User Management** | Đăng ký, Đăng nhập JWT, Google OAuth2, Token rotation (RTR), Blacklist `invalidated_tokens`, Đổi mật khẩu. | ✅ 33 Tests PASS |
| **02** | [**02_PLAN_ONLINE_JUDGE_MODULE.md**](02_PLAN_ONLINE_JUDGE_MODULE.md) | **Online Judge & Sandbox** | Nộp bài, Judge0 batching, Redis atomic counter, Short-circuit contest lock, Webhook callback, Sinh testcase tự động. | ✅ 23 Tests PASS |
| **03** | [**03_PLAN_CONTEST_MODULE.md**](03_PLAN_CONTEST_MODULE.md) | **Contests & ICPC Scoring** | Vòng đời cuộc thi, RabbitMQ delayed message, Consumer kiểm tra Idempotent, Thuật toán ICPC phạt 1200s, WebSocket broadcast. | ✅ 24 Tests PASS |
| **04** | [**04_PLAN_COURSE_AND_LEARNING_MODULE.md**](04_PLAN_COURSE_AND_LEARNING_MODULE.md) | **Course, Lesson & Quiz** | Đa điều kiện JPA Specification, Phân quyền bài giảng dùng thử (`isTrial`), Chấm thi trắc nghiệm, Đồng bộ cache tiến độ. | ✅ 53 Tests PASS |
| **05** | [**05_PLAN_PAYMENT_AND_WALLET_MODULE.md**](05_PLAN_PAYMENT_AND_WALLET_MODULE.md) | **Payment, Cart & Wallet Ledger** | Sổ cái ví điện tử, Khóa bi quan Postgres (`SELECT FOR UPDATE`), Ký số HMAC-SHA256 PayOS, Webhook Idempotency. | ✅ 36 Tests PASS |
| **06** | [**06_PLAN_SECURITY_EXCEPTION_AND_INFRA_MODULE.md**](06_PLAN_SECURITY_EXCEPTION_AND_INFRA_MODULE.md) | **Security, Exception & Email** | Quyền SpEL `@courseSecurity`, Custom JWT Decoder, `GlobalExceptionHandler`, SendGrid Webhook. | ✅ 26 Tests PASS |
| **07** | [**07_PLAN_INTEGRATION_TESTS_AND_CI_CD.md**](07_PLAN_INTEGRATION_TESTS_AND_CI_CD.md) | **Integration E2E & CI/CD** | Testcontainers (PostgreSQL 15, RabbitMQ, Redis 7), WireMock giả lập bên ngoài, GitHub Actions CI Pipeline. | 📝 Đã lên Plan |

---

### Nhóm 2: WebMvc Slice Tests (Toàn bộ 18 Controllers)
| STT | Tập tin Kế hoạch | Module phụ trách | Controllers bao phủ | Trọng tâm kiểm thử |
| :---: | :--- | :--- | :--- | :--- |
| **08** | [**08_PLAN_CONTROLLER_AUTH_AND_USER_MODULE.md**](08_PLAN_CONTROLLER_AUTH_AND_USER_MODULE.md) | **Auth, User & Admin User** | `AuthenticationController`, `UserController`, `AdminUserController` | Gắn/xóa HttpOnly Cookie, parse `@CookieValue`, `@Valid` payload, `@PreAuthorize` permissions. |
| **09** | [**09_PLAN_CONTROLLER_COURSE_AND_LEARNING_MODULE.md**](09_PLAN_CONTROLLER_COURSE_AND_LEARNING_MODULE.md) | **Course & Learning** | `CourseController`, `ChapterController`, `LessonController`, `QuizController`, `EnrollmentController` | Phân quyền SpEL `@courseSecurity`, Reorder chapters, Complete lesson, Submit quiz, Enroll free. |
| **10** | [**10_PLAN_CONTROLLER_PAYMENT_AND_WALLET_MODULE.md**](10_PLAN_CONTROLLER_PAYMENT_AND_WALLET_MODULE.md) | **Payment & Orders** | `PaymentController`, `OrderController`, `CartController`, `AdminPaymentController` | PayOS deposit link, Xác thực webhook secret, Giỏ hàng CRUD, Checkout ví điện tử. |
| **11** | [**11_PLAN_CONTROLLER_OJ_AND_CONTEST_MODULE.md**](11_PLAN_CONTROLLER_OJ_AND_CONTEST_MODULE.md) | **OJ & Contest** | `OnlineJudgeProblemController`, `OnlineJudgeSubmissionController`, `ContestController` | Nộp code chấm điểm (200), Webhook callback (204/401), Sinh testcase (202), Đăng ký thi & Leaderboard. |

---

### Nhóm 3: Async Services, Filters, Schedulers & Mappers
| STT | Tập tin Kế hoạch | Module phụ trách | Classes bao phủ | Trọng tâm kiểm thử |
| :---: | :--- | :--- | :--- | :--- |
| **12** | [**12_PLAN_EMAIL_ASYNC_AND_EXTERNAL_SERVICES_MODULE.md**](12_PLAN_EMAIL_ASYNC_AND_EXTERNAL_SERVICES_MODULE.md) | **Email, RabbitMQ & Media** | `EmailProducerServiceImpl`, `EmailConsumerServiceImpl`, `SendGridApiServiceImpl`, `CloudinaryService`, `Judge0ClientService`, `AdminEmailController`, `SendGridWebhookController` | Batching 500 emails, RabbitMQ consumer DLQ fallback, SendGrid WebClient, Cloudinary upload/destroy. |
| **13** | [**13_PLAN_REMAINING_SERVICES_SCHEDULER_AND_LISTENERS.md**](13_PLAN_REMAINING_SERVICES_SCHEDULER_AND_LISTENERS.md) | **Services & CronJob** | `EnrollmentService`, `LessonCommentService`, `ProgressService`, `RateLimitService`, `PaymentCronJob`, `ContestLeaderboardListener` | Ghi danh khóa học 0đ, Phân cấp bình luận 2 tầng, Tính % tiến độ, CronJob hủy đơn treo 30p, ICPC Event. |
| **14** | [**14_PLAN_SECURITY_FILTERS_INTERCEPTORS_AND_WEBSOCKET.md**](14_PLAN_SECURITY_FILTERS_INTERCEPTORS_AND_WEBSOCKET.md) | **Security Network Layer** | `IpRateLimitFilter`, `UserRateLimitInterceptor`, `JwtAuthenticationEntryPoint`, `JwtAccessDeniedHandler`, `WebSocketAuthInterceptor`, `CustomErrorController` | Chặn IP spam (HTTP 429), Định dạng chuẩn JSON 401/403, Xác thực Nimbus HS512 trên STOMP `CONNECT`. |
| **15** | [**15_PLAN_MAPPER_LAYER_UNIT_TESTS.md**](15_PLAN_MAPPER_LAYER_UNIT_TESTS.md) | **MapStruct Mappers** | `UserMapper`, `CourseMapper`, `ChapterMapper`, `LessonMapper`, `QuizMapper`, `CartMapper`, `ContestMapper`, `OjProblemMapper`, `OjSubmissionMapper` | Kiểm tra chuyển đổi 2 chiều Entity $\leftrightarrow$ DTO, fallback giá trị null, `mapRoles` sang Set string. |

---

## 📊 Bảng Theo dõi Tổng Hợp Mã Nguồn (Inventory & Coverage Tracking)

| STT | Phân loại Package | Tổng số Files | Số Class đã Test | Số Class đã lên Plan chi tiết | Tỷ lệ sẵn sàng |
| :---: | :--- | :---: | :---: | :---: | :---: |
| 1 | `service/**` | 24 | 15 (100% PASS) | 9 (Plan 12, 13) | 100% |
| 2 | `controller/**` | 18 | 0 | 18 (Plan 08, 09, 10, 11, 12) | 100% |
| 3 | `security/**` | 7 | 2 (100% PASS) | 5 (Plan 14) | 100% |
| 4 | `listener/**` | 2 | 1 (100% PASS) | 1 (Plan 13) | 100% |
| 5 | `scheduler/**` | 1 | 0 | 1 (Plan 13) | 100% |
| 6 | `mapper/**` | 9 | 0 | 9 (Plan 15) | 100% |
| 7 | `util/**` & `exception/**` | 4 | 2 (100% PASS) | 0 | 100% |
| 8 | `configuration/**` | 12 | 0 | 1 (WebSocket Auth - Plan 14) | 100% |
| 9 | `repository/**` | 52 | 0 (Mocked in Services) | 52 (Plan 07 E2E Integration) | 100% |
| **Tổng** | **Toàn bộ Backend** | **129 files** | **23 Classes (195 Tests)** | **106 Classes còn lại** | **100% Blueprinted** |
