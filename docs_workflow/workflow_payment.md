# BÀI TOÁN THIẾT KẾ: HỆ THỐNG VÍ ĐIỆN TỬ VÀ THANH TOÁN (VIRTUAL WALLET ECOSYSTEM)

**Mục tiêu:** Chuyển đổi mô hình thanh toán khóa học trực tiếp sang mô hình nạp và sử dụng "Tiền ảo nội bộ" (Xu/Coin). Hệ thống cho phép User nạp tiền (VietQR), mua khóa học, nhận thưởng, hoàn tiền và yêu cầu rút tiền.

---

## 1. Nguyên tắc tối thượng (Core Principles)
1. **Kiểm toán dòng tiền (Audit Trail):** Tuyệt đối không bao giờ cập nhật cột `balance` một cách trực tiếp mà KHÔNG sinh ra một bản ghi lịch sử tương ứng.
2. **Ngân hàng trung ương (Central Bank):** Admin/Hệ thống không cần có Ví riêng. Hệ thống có quyền in tiền (Mint) hoặc thu hồi tiền (Burn) trực tiếp từ ví User thông qua các giao dịch hệ thống.
3. **Toàn vẹn dữ liệu (ACID):** Mọi thao tác trừ tiền/cộng tiền phải được bọc trong Transaction và sử dụng Cơ chế Khóa (Locking) để chống Race Condition.

---

## 2. Thiết kế Cơ sở dữ liệu (Database Schema)

### Bảng `wallets` (Quản lý số dư)
| Cột | Kiểu dữ liệu | Ràng buộc / Ý nghĩa |
| :--- | :--- | :--- |
| `id` | SERIAL | Primary Key |
| `user_id` | BIGINT | Foreign Key -> `users(id)`, UNIQUE |
| `balance` | NUMERIC(12,2) | Số dư hiện tại (DEFAULT 0). **CHECK (balance >= 0)** |
| `status` | VARCHAR | 'ACTIVE', 'LOCKED' (Khóa nếu phát hiện gian lận) |

### Bảng `wallet_transactions` (Lịch sử giao dịch - Sổ cái)
| Cột | Kiểu dữ liệu | Ràng buộc / Ý nghĩa |
| :--- | :--- | :--- |
| `id` | SERIAL | Primary Key |
| `wallet_id` | BIGINT | Foreign Key -> `wallets(id)` |
| `amount` | NUMERIC(12,2) | Số tiền giao dịch (Ví dụ: 500 hoặc -500) |
| `type` | VARCHAR | DEPOSIT (Nạp), PURCHASE (Mua), REWARD (Thưởng), REFUND (Hoàn), WITHDRAW (Rút) |
| `status` | VARCHAR | PENDING, SUCCESS, FAILED, CANCELLED |
| `reference_id` | VARCHAR | ID tham chiếu (Mã VietQR, ID khóa học, ID Contest) |
| `note` | VARCHAR | Ghi chú (VD: "Thưởng top 1 contest") |
| `created_by` | BIGINT | ID người thực hiện (User ID hoặc Admin ID) |

---

## 3. Chi tiết 4 Luồng Nghiệp Vụ (Workflows)

### Luồng 3.1: Nạp tiền vào hệ thống (Deposit) - Tích hợp VietQR
*Luồng này giao tiếp với ngân hàng thực tế thông qua dịch vụ trung gian (PayOS/SePay).*

1. **Khởi tạo (Client):** User nhập số tiền muốn nạp (VD: nạp 500k lấy 500 Xu).
2. **Tạo lệnh (Server):** Backend tạo record trong `wallet_transactions` (Type: `DEPOSIT`, Status: `PENDING`), sinh ra mã giao dịch duy nhất (VD: `NAPXU_123`).
3. **Hiển thị QR (Server -> Client):** Backend gọi API VietQR sinh ảnh QR nhúng sẵn số tiền và nội dung chuyển khoản là `NAPXU_123`. User dùng app ngân hàng quét và thanh toán.
4. **Nhận Webhook (Bank -> Server):** Ngân hàng nhận tiền -> PayOS/SePay bắn Webhook về Backend.
5. **Xác thực & Cộng tiền (Server):**
    * Xác thực chữ ký số (HMAC Signature) để chống giả mạo Webhook.
    * Check Idempotency (Trạng thái giao dịch phải là PENDING).
    * Cập nhật `wallet_transactions` -> `SUCCESS`.
    * Cộng tiền vào `wallets.balance`.

### Luồng 3.2: Mua Khóa Học (Course Purchase)
*Luồng này xử lý nội bộ 100%, không gọi ra ngoài internet.*

1. **Yêu cầu:** User bấm mua khóa học giá 500 Xu.
2. **Khóa ví (Pessimistic Lock):** Backend chạy lệnh `SELECT * FROM wallets WHERE user_id = ? FOR UPDATE;` để ngăn chặn User mở 2 tab mua 2 khóa học cùng lúc.
3. **Kiểm tra số dư:** Check `balance >= 500`. Nếu không đủ, throw Exception (Báo nạp thêm tiền).
4. **Trừ tiền & Lưu lịch sử:** * `UPDATE wallets SET balance = balance - 500`.
    * Tạo record `wallet_transactions` (Type: `PURCHASE`, Status: `SUCCESS`, ref_id: `course_id`).
5. **Cấp quyền:** Tạo record trong bảng `enrollments`.
6. **Commit Transaction:** Hoàn tất và nhả Lock.

### Luồng 3.3: Thưởng / Hoàn tiền (System Reward & Refund)
*Hệ thống đóng vai trò "Ngân hàng Trung ương", Admin không cần ví riêng.*

1. **Kích hoạt:** Admin bấm nút hoàn tiền cho User, hoặc Hệ thống tự động phát thưởng sau khi Contest kết thúc.
2. **Khóa ví:** Khóa ví của User nhận tiền (`FOR UPDATE`).
3. **Cộng tiền trực tiếp:** Tăng `balance` cho User.
4. **Ghi dấu vết (Audit Trail):** BẮT BUỘC tạo record `wallet_transactions` (Type: `REWARD` hoặc `REFUND`) với `note` giải thích lý do, `status` là `SUCCESS`, và `created_by` là ID của Admin thao tác.

### Luồng 3.4: Rút Tiền (Withdrawal / Payout)
*Phân tách giữa Môi trường thực tế (Bán tự động) và Môi trường Test/Dev (Giả lập tự động).*

1. **Yêu cầu Rút:** User nhập số lượng Xu muốn rút và thông tin STK Ngân hàng.
2. **Khóa và Trừ tiền ngay lập tức:** Backend dùng Lock, trừ thẳng số Xu trong ví User (để tránh đem đi mua khóa học), tạo `wallet_transactions` với trạng thái **`PENDING`**.

**Cách xử lý tiếp theo tùy thuộc môi trường:**
* **Môi trường Production (Thực tế - Khuyên dùng cho Startup):**
    * Gửi notification cho Admin.
    * Admin tự mở app ngân hàng trên điện thoại chuyển tiền thật cho User.
    * Admin lên trang quản trị Web bấm "Duyệt lệnh rút".
    * Backend chuyển status transaction thành `SUCCESS`. (Nếu từ chối, chuyển thành `FAILED` và cộng lại tiền cho User).
* **Môi trường Dev / Test Đồ án (Giả lập bằng Code):**
    * Sử dụng kiến trúc Dependency Injection, tiêm một `MockPayoutService`.
    * Chạy luồng bất đồng bộ `@Async`. Service giả vờ `Thread.sleep(3000)` để mô phỏng độ trễ của ngân hàng.
    * Sau 3 giây, tự động gọi Database chuyển status thành `SUCCESS` và bắn WebSocket báo về Frontend.

---

## 4. Các Vấn Đề Kỹ Thuật Trọng Tâm Đã Giải Quyết (Technical Highlights)

* **Data Consistency:** Áp dụng `@Transactional` nghiêm ngặt trên mọi luồng để đảm bảo tính chất ACID (Ví dụ: Không có chuyện tiền bị trừ mà khóa học không được cấp).
* **Race Condition / Concurrency Control:** Sử dụng DB-level Locking (`SELECT ... FOR UPDATE`) để ngăn chặn triệt để thảm họa Double-spending (tiêu tiền 2 lần trong cùng một tích tắc mili-giây).
* **Security & Anti-Fraud:** Phân quyền cứng luồng gọi API nạp/rút. Xác thực Webhook bằng mã băm HMAC SHA256. Bảng Ví luôn thiết lập constraint `CHECK (balance >= 0)` ở tầng Database làm chốt chặn cuối cùng.
* **Separation of Concerns (SoC) & Mocking:** Luồng Rút tiền được thiết kế ẩn sau một Interface, cho phép dễ dàng chuyển đổi giữa việc xử lý thủ công (Manual), gọi API Ngân hàng thật (Firm Banking), hoặc Giả lập (Mock Async) mà không phải đập đi viết lại Logic lõi.