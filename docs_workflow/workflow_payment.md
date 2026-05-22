# BÀI TOÁN THIẾT KẾ: HỆ THỐNG VÍ ĐIỆN TỬ VÀ THANH TOÁN (VIRTUAL WALLET ECOSYSTEM)

**Mục tiêu:** Chuyển đổi mô hình thanh toán khóa học trực tiếp sang mô hình nạp và sử dụng "Tiền ảo nội bộ" (Xu/Coin). Hệ thống phân tách rõ ràng luồng Giao dịch Tiền thật (Nạp/Rút VND qua PayOS/VietQR) và Giao dịch Tiền ảo nội bộ (Mua khóa học, Nhận thưởng, Hoàn Xu).

---

## 1. Nguyên tắc tối thượng (Core Principles)
1. **Kiểm toán dòng tiền (Audit Trail):** Tuyệt đối không bao giờ cập nhật cột `balance` một cách trực tiếp mà KHÔNG sinh ra một bản ghi lịch sử tương ứng.
2. **Ngân hàng trung ương (Central Bank):** Admin/Hệ thống không cần có Ví riêng. Hệ thống có quyền in tiền (Mint) hoặc thu hồi tiền (Burn) trực tiếp từ ví User thông qua các giao dịch hệ thống.
3. **Toàn vẹn dữ liệu (ACID):** Mọi thao tác trừ tiền/cộng tiền phải được bọc trong Transaction và sử dụng Cơ chế Khóa (Locking) để chống Race Condition.

---

## 2. Thiết kế Cơ sở dữ liệu (Database Schema)

### Bảng `wallets` (Quản lý số dư Xu)
| Cột | Kiểu dữ liệu | Ràng buộc / Ý nghĩa |
| :--- | :--- | :--- |
| `id` | SERIAL | Primary Key |
| `user_id` | BIGINT | Foreign Key -> `users(id)`, UNIQUE |
| `balance` | NUMERIC(12,2) | Số dư Xu hiện tại (DEFAULT 0.00). **CHECK (balance >= 0)** |
| `status` | ENUM | `wallet_status`: 'ACTIVE', 'LOCKED' |

### Bảng `payment_transactions` (Tiền thật: Nạp qua VietQR, Rút về thẻ)
| Cột | Kiểu dữ liệu | Ràng buộc / Ý nghĩa |
| :--- | :--- | :--- |
| `id` | SERIAL | Primary Key |
| `wallet_id` | BIGINT | Foreign Key -> `wallets(id)` |
| `transaction_code`| VARCHAR(50)| Mã giao dịch duy nhất (UNIQUE) sinh tự động, gửi cho PayOS |
| `amount` | NUMERIC(12,2) | Số tiền thật giao dịch (VND) |
| `type` | ENUM | `payment_transaction_type`: DEPOSIT (Nạp tiền), WITHDRAW (Rút tiền) |
| `status` | ENUM | `transaction_status`: PENDING, SUCCESS, FAILED, CANCELLED |
| `note` | TEXT | Ghi chú giao dịch tiền thật |

### Bảng `wallet_transactions` (Tiền ảo: Sổ cái lưu vết biến động Xu)
| Cột | Kiểu dữ liệu | Ràng buộc / Ý nghĩa |
| :--- | :--- | :--- |
| `id` | SERIAL | Primary Key |
| `wallet_id` | BIGINT | Foreign Key -> `wallets(id)` |
| `amount` | NUMERIC(12,2) | Mức biến động Xu (Ví dụ: 500.00 hoặc -500.00) |
| `type` | ENUM | `wallet_transaction_type`: DEPOSIT, PURCHASE, REWARD, REFUND, WITHDRAW |
| `status` | ENUM | `transaction_status`: PENDING, SUCCESS, FAILED, CANCELLED |
| `reference_id` | BIGINT | ID tham chiếu (VD: ID của `payment_transactions`, `courses.id`, `contests.id`) |
| `note` | TEXT | Ghi chú (VD: "Thưởng top 1 contest") |

---

## 3. Chi tiết 4 Luồng Nghiệp Vụ (Workflows)

### Luồng 3.1: Nạp tiền vào hệ thống (Deposit) - Tích hợp PayOS/VietQR
*Luồng này liên quan đến TIỀN THẬT, giao tiếp với ngân hàng thực tế thông qua PayOS.*

1. **Khởi tạo (Client):** User nhập số tiền muốn nạp (VD: nạp 500.000 VND lấy 500 Xu).
2. **Tạo lệnh (Server):** Backend tạo record trong `payment_transactions` (Type: `DEPOSIT`, Status: `PENDING`), sinh ra mã giao dịch duy nhất ở trường `transaction_code` (VD: `CODE_123`).
3. **Hiển thị QR (Server -> Client):** Backend gọi API PayOS sinh QR code nhúng sẵn số tiền và mã thanh toán `CODE_123`. User dùng app ngân hàng quét và thanh toán.
4. **Nhận Webhook (Bank -> Server):** Ngân hàng nhận tiền -> PayOS bắn Webhook về Backend.
5. **Xác thực & Cộng tiền ảo (Server):**
    * Xác thực chữ ký số HMAC Signature từ Webhook để chống giả mạo.
    * Check Idempotency: Kiểm tra `payment_transactions` theo mã giao dịch, phải đang ở trạng thái `PENDING`.
    * Đổi trạng thái `payment_transactions` -> `SUCCESS`.
    * Tạo một record ở `wallet_transactions` (Tiền ảo) tương ứng (Type: `DEPOSIT`, Status: `SUCCESS`, amount: 500, `reference_id` trỏ vào ID của `payment_transactions`).
    * Tăng `balance` trong `wallets`.

### Luồng 3.2: Mua Khóa Học (Course Purchase)
*Luồng này xử lý bằng TIỀN ẢO nội bộ 100%, không gọi ra ngoài internet.*

1. **Yêu cầu:** User bấm mua khóa học giá 500 Xu.
2. **Khóa ví (Pessimistic Lock):** Backend chạy lệnh `SELECT * FROM wallets WHERE user_id = ? FOR UPDATE;` để ngăn chặn User mở 2 tab mua 2 khóa học cùng lúc.
3. **Kiểm tra số dư:** Check `balance >= 500`. Nếu không đủ, throw Exception (Báo nạp thêm Xu).
4. **Trừ tiền & Lưu lịch sử:** 
    * Trừ tiền: `UPDATE wallets SET balance = balance - 500`.
    * Tạo record `wallet_transactions` (Type: `PURCHASE`, Status: `SUCCESS`, amount: -500, `reference_id`: `course_id`).
5. **Cấp quyền:** Tạo record trong bảng `enrollments`, lưu `wallet_transaction_id` để track lại giao dịch mua này.
6. **Commit Transaction:** Hoàn tất lưu DB và nhả Lock.

### Luồng 3.3: Thưởng / Hoàn tiền Xu (System Reward & Refund)
*Hệ thống đóng vai trò "Ngân hàng Trung ương", Admin không cần ví riêng.*

1. **Kích hoạt:** Admin bấm nút hoàn tiền cho User, hoặc Hệ thống tự động phát thưởng Xu sau khi Contest kết thúc.
2. **Khóa ví:** Khóa ví của User nhận tiền (`FOR UPDATE`).
3. **Cộng tiền trực tiếp:** Tăng `balance` cho User.
4. **Ghi dấu vết (Audit Trail):** BẮT BUỘC tạo record `wallet_transactions` (Type: `REWARD` hoặc `REFUND`, Status: `SUCCESS`, amount > 0) với `note` giải thích lý do.

### Luồng 3.4: Rút Tiền (Withdrawal / Payout)
*Rút Xu từ hệ thống quy đổi ra VND, phân tách giữa Môi trường thực tế (Bán tự động) và Môi trường Test/Dev (Giả lập tự động).*

1. **Yêu cầu Rút:** User nhập số lượng Xu muốn rút (VD: Rút 1000 Xu) và cung cấp STK Ngân hàng.
2. **Khóa và Trừ tiền ảo ngay lập tức:** Backend dùng Lock, trừ thẳng số Xu trong ví User (`UPDATE wallets SET balance = balance - 1000`).
3. **Ghi nhận giao dịch:**
    * Tạo `wallet_transactions` (Type: `WITHDRAW`, Status: `PENDING`, amount: -1000 Xu).
    * Tạo `payment_transactions` tương ứng (Type: `WITHDRAW`, Status: `PENDING`, amount: 1.000.000 VND).

**Cách xử lý tiếp theo tùy thuộc môi trường:**
* **Môi trường Production (Thực tế - Khuyên dùng cho Startup):**
    * Gửi notification cho Admin.
    * Admin kiểm tra và tự mở app ngân hàng chuyển tiền thật (VND) cho User.
    * Admin lên trang quản trị Web bấm "Duyệt lệnh rút".
    * Backend chuyển status của `payment_transactions` và `wallet_transactions` thành `SUCCESS`. (Nếu từ chối, chuyển thành `FAILED` và cộng lại Xu vào Ví).
* **Môi trường Dev / Test Đồ án (Giả lập bằng Code):**
    * Sử dụng kiến trúc Dependency Injection, tiêm một `MockPayoutService`.
    * Chạy luồng bất đồng bộ `@Async`. Service giả vờ `Thread.sleep(3000)` để mô phỏng độ trễ của ngân hàng.
    * Sau 3 giây, tự động chuyển status 2 giao dịch thành `SUCCESS` và bắn WebSocket báo về Frontend.

---

## 4. Các Vấn Đề Kỹ Thuật Trọng Tâm Đã Giải Quyết (Technical Highlights)

* **Data Consistency:** Áp dụng `@Transactional` nghiêm ngặt trên mọi luồng để đảm bảo tính chất ACID (Ví dụ: Không có chuyện tiền bị trừ mà khóa học không được cấp).
* **Race Condition / Concurrency Control:** Sử dụng DB-level Locking (`SELECT ... FOR UPDATE`) để ngăn chặn triệt để thảm họa Double-spending (tiêu tiền 2 lần trong cùng một tích tắc mili-giây).
* **Security & Anti-Fraud:** Phân quyền cứng luồng gọi API nạp/rút. Xác thực Webhook bằng mã băm HMAC SHA256. Bảng Ví luôn thiết lập constraint `CHECK (balance >= 0)` ở tầng Database làm chốt chặn cuối cùng.
* **Separation of Concerns (SoC) & Mocking:** Luồng Rút tiền được thiết kế ẩn sau một Interface, cho phép dễ dàng chuyển đổi giữa việc xử lý thủ công (Manual), gọi API Ngân hàng thật (Firm Banking), hoặc Giả lập (Mock Async) mà không phải đập đi viết lại Logic lõi.