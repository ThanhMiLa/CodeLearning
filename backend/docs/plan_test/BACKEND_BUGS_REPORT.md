# 🐛 BÁO CÁO CÁC LỖI BACKEND PHÁT HIỆN TRONG QUÁ TRÌNH VIẾT UNIT TEST
Dự án: **CodeLearning Platform Backend**  
Thời gian tạo: 2026-09-04  
Mục đích: Ghi nhận các hàm backend bị lỗi logic, sai cú pháp, hoặc ném ngoại lệ không đúng thiết kế để người dùng kiểm tra lại sau.

---

| STT | Class / File | Hàm / Phương thức | Mô tả lỗi phát hiện | Trạng thái / Ghi chú |
| :---: | :--- | :--- | :--- | :--- |
| 1 | `PaymentCronJob.java` & `PaymentService.java` | `scanPendingTransactions`, `createDepositPayment` | `WebClient.builder()` khởi tạo trực tiếp trong phương thức thay vì inject Bean | **ĐÃ GIẢI QUYẾT (RESOLVED)**: Đã tái cấu trúc tầng client chuyên biệt `PayOsClient` / `PayOsClientImpl` và cấu hình Bean `payosWebClient` tập trung tại `WebClientConfig`. Di dời logic chữ ký HMAC-SHA256 vào client. Phân loại lỗi qua `PayOsErrorType`. Đã xây dựng bộ unit test độc lập 100% không phụ thuộc mạng cho cả 3 class `PayOsClientImplTest`, `PaymentServiceTest`, `PaymentCronJobTest`. *(Ghi nhận Technical Debt: `@Transactional` trong `PaymentService.createDepositPayment` mở kết nối DB trong lúc gọi HTTP PayOS).* |

---
## Tóm tắt kết quả kiểm thử Backend:
- Tổng số test cases đã thực thi: **378 tests**
- Số test cases PASS: **378 (100%)**
- Số test cases FAIL: **0**
- Số test cases ERROR: **0**
- Số test cases SKIPPED: **0**
- Toàn bộ các module Auth, User, Course, Lesson, Chapter, Quiz, Payment (kèm PayOsClient), Cart, Order, Wallet, Online Judge (bao gồm Testcase Generation), Contest, Email Webhook, Security Decoder và Exception Handling đều đã được bao phủ unit test độc lập với tỷ lệ pass 100%.
