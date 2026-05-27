# THIẾT KẾ HỆ THỐNG GIỎ HÀNG (SHOPPING CART) VÀ MUA HÀNG (CHECKOUT)

Tài liệu này mô tả chi tiết thiết kế hệ thống Giỏ hàng (Shopping Cart) ở Backend phục vụ cho luồng mua nhiều khóa học cùng lúc (tương tự như Udemy), kết hợp với API thanh toán hiện tại của hệ thống.

---

## 1. Khái niệm & Phân biệt (Cart Items vs Order Items)

Để xây dựng một luồng thanh toán chuyên nghiệp, hệ thống phân tách rõ ràng hai khái niệm: **Giỏ hàng tạm thời (Cart)** và **Đơn hàng vĩnh viễn (Order)**.

| Đặc điểm | `cart_items` (Giỏ hàng tạm thời) | `order_items` (Chi tiết đơn hàng) |
| :--- | :--- | :--- |
| **Trạng thái** | Tạm thời (Transient). | Vĩnh viễn (Permanent - Lịch sử). |
| **Mục đích** | Lưu trữ danh sách khóa học người dùng đang cân nhắc mua. | Lưu trữ hóa đơn pháp lý để tính doanh thu và lưu lịch sử học tập. |
| **Giá sản phẩm** | Cập nhật theo thời giá thực tế của khóa học tại thời điểm xem. | Cố định tại mức giá người dùng thực trả tại thời điểm giao dịch. |
| **Vòng đời** | Bị xóa sạch ngay khi thanh toán thành công hoặc khi user tự xóa. | Không bao giờ bị xóa để phục vụ công tác đối soát kế toán. |

---

## 2. Thiết kế Cơ sở dữ liệu (Database Schema)

Để hỗ trợ giỏ hàng lưu trữ ở phía Backend, hệ thống bổ sung thêm 2 bảng:

### Bảng `carts` (Giỏ hàng của User)
Bảng này quản lý giỏ hàng của từng cá nhân. Mỗi User có tối đa 1 giỏ hàng active.

| Cột | Kiểu dữ liệu | Ràng buộc / Ý nghĩa |
| :--- | :--- | :--- |
| `id` | SERIAL / BIGINT | Primary Key |
| `user_id` | BIGINT | Foreign Key -> `users(id)`, **UNIQUE** |
| `created_at` | TIMESTAMP WITH TIME ZONE | Thời gian tạo giỏ hàng |
| `updated_at` | TIMESTAMP WITH TIME ZONE | Thời gian cập nhật giỏ hàng |

### Bảng `cart_items` (Danh sách khóa học trong giỏ)
Bảng này lưu danh sách các khóa học được chọn. Vì là sản phẩm số nên **không cần** trường số lượng (`quantity`).

| Cột | Kiểu dữ liệu | Ràng buộc / Ý nghĩa |
| :--- | :--- | :--- |
| `id` | SERIAL / BIGINT | Primary Key |
| `cart_id` | BIGINT | Foreign Key -> `carts(id)` (ON DELETE CASCADE) |
| `course_id` | BIGINT | Foreign Key -> `courses(id)` (ON DELETE CASCADE) |
| `created_at` | TIMESTAMP WITH TIME ZONE | Thời điểm bỏ vào giỏ hàng |

> [!IMPORTANT]
> **Ràng buộc duy nhất (Unique Constraint):** Bắt buộc phải thiết lập Unique Key cho bộ đôi `(cart_id, course_id)` để ngăn chặn tình trạng một khóa học bị thêm trùng lặp nhiều lần vào một giỏ hàng.

---

## 3. Luồng đi của dữ liệu (Data Flow)

Hệ thống hoạt động theo mô hình: **Giỏ hàng lưu DB bất đồng bộ -> Thanh toán trực tiếp bằng danh sách ID -> Dọn dẹp giỏ hàng**.

```text
[User]                 [Frontend]               [Backend]             [Database]
  |                         |                       |                      |
  |-- 1. Add to Cart ------>|                       |                      |
  |   (Click Button)        |-- 2. POST /cart/items |                      |
  |                         |   (courseId) -------->|                      |
  |                         |                       |-- 3. Check & Save ->|
  |                         |                       |<-- 4. DB OK ---------|
  |                         |<-- 5. HTTP 200 OK ----|                      |
  |                         |                       |                      |
  |-- 6. Open Cart Page --->|                       |                      |
  |                         |-- 7. GET /cart ------>|                      |
  |                         |                       |-- 8. Fetch Items --->|
  |                         |                       |<-- 9. DB Items ------|
  |                         |<-- 10. CartResponse --|                      |
  |                         |                       |                      |
  |-- 11. Click Checkout -->|                       |                      |
  |                         |-- 12. POST /orders/checkout                  |
  |                         |    (courseIds) ------>|                      |
  |                         |                       |-- 13. Process Payment|
  |                         |                       |       & Enrollments  |
  |                         |                       |-- 14. Delete Items ->|
  |                         |                       |<-- 15. DB OK --------|
  |                         |<-- 16. Checkout OK ---|                      |
  |<- 17. Success Msg ------|                       |                      |
```

### Chi tiết các API cần xây dựng:

#### 1. Lấy thông tin giỏ hàng (`GET /cart`)
* **Hành động**: Tìm giỏ hàng ứng với `userId`. Nếu chưa có, tự động tạo mới một `CartEntity` trống và lưu vào DB.
* **Response**: Trả về `CartResponse` bao gồm danh sách các khóa học hiện tại trong giỏ (ID, tiêu đề, giá tiền, ảnh đại diện) và tổng tiền dự kiến.

#### 2. Thêm khóa học vào giỏ (`POST /cart/items`)
* **Request Body**: `{"courseId": 123}`
* **Logic kiểm tra**:
  1. Kiểm tra khóa học có tồn tại và đang ở trạng thái `ACTIVE` không.
  2. Kiểm tra xem người dùng đã mua/sở hữu khóa học này chưa (truy vấn bảng `Enrollment` với trạng thái `ACTIVE` hoặc `COMPLETED`). Nếu đã sở hữu, từ chối thêm.
  3. Kiểm tra xem khóa học đã nằm trong giỏ hàng chưa (để tránh lỗi ghi trùng lặp dữ liệu).
* **Hành động**: Lưu một bản ghi mới vào bảng `cart_items`.

#### 3. Xóa khóa học khỏi giỏ (`DELETE /cart/items/{courseId}`)
* **Hành động**: Xóa bản ghi trong `cart_items` có `course_id` tương ứng thuộc sở hữu giỏ hàng của user hiện tại.

#### 4. Thanh toán & Dọn dẹp giỏ (`POST /orders/checkout`)
* **Request Body**: `{"courseIds": [123, 456]}` (API hiện có trong `OrderService`)
* **Nâng cấp thêm**:
  * Khi quá trình trừ tiền ví (`Wallet`) và tạo các `Enrollment` thành công, Backend thực hiện thêm một lệnh xóa các `courseIds` này khỏi bảng `cart_items` của User.
  * Việc này đảm bảo giỏ hàng tự động được dọn dẹp sạch sẽ ở mức database ngay khi thanh toán thành công mà không phụ thuộc vào việc Frontend gửi thêm request xóa giỏ hàng.
