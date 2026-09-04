# 🐛 BÁO CÁO CÁC LỖI BACKEND PHÁT HIỆN TRONG QUÁ TRÌNH VIẾT UNIT TEST
Dự án: **CodeLearning Platform Backend**  
Thời gian tạo: 2026-09-04  
Mục đích: Ghi nhận các hàm backend bị lỗi logic, sai cú pháp, hoặc ném ngoại lệ không đúng thiết kế để người dùng kiểm tra lại sau.

---

| STT | Class / File | Hàm / Phương thức | Mô tả lỗi phát hiện | Lý do bỏ qua / Ghi chú |
| :---: | :--- | :--- | :--- | :--- |
| 1 | `PaymentCronJob.java` | `scanPendingTransactions` | `WebClient.builder()` khởi tạo trực tiếp trong phương thức thay vì inject `WebClient` Bean | Không thể mock trực tiếp phản hồi HTTP từ PayOS trong unit test (khác với `Judge0ClientService`). Đã test thành công các nhánh: danh sách rỗng, catch exception timeout hủy đơn > 30 phút, và giữ nguyên đơn < 30 phút. Đề xuất refactor sang inject Bean `WebClient` hoặc `PayOsClientService`. |

---
## Tóm tắt kết quả kiểm thử Backend:
- Tổng số test cases đã thực thi: **195 tests**
- Số test cases PASS: **195 (100%)**
- Số test cases FAIL: **0**
- Số test cases ERROR: **0**
- Số test cases SKIPPED: **0**
- Toàn bộ các module Auth, User, Course, Lesson, Chapter, Quiz, Payment, Cart, Order, Wallet, Online Judge (bao gồm Testcase Generation), Contest, Email Webhook, Security Decoder và Exception Handling đều đã được bao phủ unit test độc lập.
