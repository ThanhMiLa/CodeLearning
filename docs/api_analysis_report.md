# BÁO CÁO PHÂN TÍCH & ĐÁNH GIÁ API HỆ THỐNG - CODELEARNING PLATFORM

Tài liệu này đối chiếu chi tiết tài liệu [api_documentation.md](file:///Users/ngocthanh/Documents/Project/codelearning-platform/docs/api_documentation.md) với toàn bộ mã nguồn Java Spring Boot của backend tại thư mục [src/main/java](file:///Users/ngocthanh/Documents/Project/codelearning-platform/src/main/java). Mục tiêu là phát hiện các điểm sai lệch cấu trúc dữ liệu, các chức năng bị bỏ sót hoặc chưa tối ưu để đảm bảo **AI Agent** xây dựng giao diện (Frontend) chính xác 100% mà không bị lỗi tương thích.

---

## I. TỔNG QUAN SỰ TƯƠNG THÍCH
Nhìn chung, hệ thống Backend đã xây dựng đầy đủ **55 endpoints** trải rộng trên **12 modules** đúng như mô tả trong tài liệu. Các ánh xạ HTTP Method, URL path parameters, query parameters, và các cơ chế xác thực cookie JWT cơ bản đều trùng khớp.

Tuy nhiên, có một số **sai lệch dữ liệu nghiêm trọng** trong response body và các **chức năng chạy ngầm (WebSockets)** bị bỏ sót trong tài liệu có thể gây lỗi Crash hoặc khiến AI Agent không làm được tính năng tương tác thời gian thực.

---

## II. CÁC SAI LỆCH CẤU TRÚC NGHIÊM TRỌNG (DATA MISMATCH)

### 1. Phản hồi Đăng nhập / Đăng ký (`/auth/login` & `/auth/register`)
*   **Mô tả trong tài liệu (Endpoint 1 & 2):**
    Server trả về đối tượng `result` chứa token dạng ẩn và một object `user` lồng nhau:
    ```json
    "result": {
      "accessToken": null,
      "refreshToken": null,
      "user": {
        "id": 1,
        "displayName": "Thanh Mi La",
        "username": "thanh123",
        "phoneNumber": "0987654321",
        "email": "thanh@example.com"
      }
    }
    ```
*   **Mã nguồn thực tế ([AuthenticationResponse.java](file:///Users/ngocthanh/Documents/Project/codelearning-platform/src/main/java/com/thanhmila/codelearning/dto/response/AuthenticationResponse.java)):**
    Dữ liệu phản hồi thực tế là cấu trúc **phẳng (Flat)**, không hề có object `user` lồng bên trong. Đồng thời có thêm trường ví tiền `balance` nhưng lại **thiếu** trường `username`:
    ```java
    public class AuthenticationResponse {
        String accessToken; // Sẽ được set null ở controller sau khi lưu cookie
        String refreshToken; // Sẽ được set null ở controller sau khi lưu cookie
        Long id;
        String displayName;
        String email;
        String phoneNumber;
        BigDecimal balance; // Trả về số dư ví (trong tài liệu không ghi)
    }
    ```
*   **Hệ quả:** Nếu AI Agent viết code Frontend truy cập `response.result.user.displayName`, ứng dụng sẽ crash lập tức vì `user` bị `undefined`.

---

### 2. Cấu trúc Phân trang (`PageResponse<T>`)
*   **Mô tả trong tài liệu (Mục II.2):**
    ```typescript
    export interface PageResponse<T> {
      currentPage: number;
      totalPages: number;
      pageSize: number;
      totalElements: number;
      data: T[];
    }
    ```
*   **Mã nguồn thực tế ([PageResponse.java](file:///Users/ngocthanh/Documents/Project/codelearning-platform/src/main/java/com/thanhmila/codelearning/dto/response/PageResponse.java)):**
    Tên các trường dữ liệu thực tế khác biệt hoàn toàn:
    ```java
    public class PageResponse<T> {
        int page;                 // Khác "currentPage"
        int size;                 // Khác "pageSize"
        long numberOfElements;
        long totalElements;
        int totalPages;
        boolean first;
        boolean last;
        List<T> content;          // Khác "data"
    }
    ```
*   **Hệ quả:** Frontend hiển thị danh sách khóa học hoặc bài tập sẽ không render được vì mảng dữ liệu nằm ở trường `content` chứ không phải `data`, và bộ phân trang sẽ bị lỗi thông số page.

---

### 3. Phân trang Bình luận Bài học không đồng bộ
*   **Mô tả trong tài liệu (Endpoint 19 & 20):**
    Trả về cấu trúc `PageResponse<LessonCommentResponse>`.
*   **Mã nguồn thực tế ([LessonController.java](file:///Users/ngocthanh/Documents/Project/codelearning-platform/src/main/java/com/thanhmila/codelearning/controller/course/LessonController.java)):**
    Các API `/lessons/{lessonId}/comments` và `/lessons/{lessonId}/comments/{commentId}/replies` thực tế trả về kiểu `Page<LessonCommentResponse>` của Spring Data trực tiếp thay vì bọc qua `PageResponse<T>`.
*   **Hệ quả:** Khi serialized sang JSON, đối tượng `Page` của Spring có cấu trúc rất cồng kềnh chứa các object con như `pageable`, `sort`, và trường số trang hiện tại nằm ở `number` (không phải `page` hay `currentPage`). Điều này gây bất đồng bộ về cấu trúc phân trang trên toàn hệ thống.

---

### 4. Mã phản hồi nội bộ trong `ContestController`
*   **Mô tả trong tài liệu (Mục II.2):**
    Response wrapper luôn có trường `code` nội bộ (thành công là `1000`).
*   **Mã nguồn thực tế ([ContestController.java](file:///Users/ngocthanh/Documents/Project/codelearning-platform/src/main/java/com/thanhmila/codelearning/controller/contest/ContestController.java)):**
    Trong toàn bộ các API thuộc `ContestController.java`, hàm khởi tạo `ApiResponse` lại thiết lập `.code(200)` cho trường hợp thành công thay vì `.code(1000)`.
*   **Hệ quả:** Nếu Frontend dùng Axios/Fetch Interceptor để bắt mã `code !== 1000` làm điều kiện báo lỗi hệ thống, toàn bộ các chức năng liên quan đến Kỳ thi (Contest) sẽ bị chặn và báo lỗi ảo.

---

## III. CÁC TÍNH NĂNG CHẠY NGẦM BÌ BỎ SÓT TRONG TÀI LIỆU

### 1. Hệ thống kết nối thời gian thực WebSockets (STOMP)
Backend đã cấu hình đầy đủ giao thức WebSocket STOMP qua endpoint `/ws` (có hỗ trợ SockJS fallback) tại lớp [WebSocketConfig.java](file:///Users/ngocthanh/Documents/Project/codelearning-platform/src/main/java/com/thanhmila/codelearning/configuration/WebSocketConfig.java). Đây là cơ chế cốt lõi để cập nhật giao diện, nhưng **không hề được nhắc đến trong tài liệu API**.

Các kênh đăng ký (Subscription Topics) thực tế bao gồm:
*   `/topic/submissions/{userId}`: Server chủ động bắn kết quả chấm từng Testcase của người dùng (gửi Model `OjWebSocketMessage`).
*   `/topic/submissions/admin`: Nhận live-feed tất cả bài nộp của hệ thống (dành cho Admin giám sát).
*   `/topic/testcase-generation/{problemId}`: Báo cáo tiến độ tạo bộ testcase tự động (gửi Model `OjTestcaseGenWsMessage`).
*   `/topic/contests/{contestId}/leaderboard`: Bắn tín hiệu event `LEADERBOARD_INITIALIZED` hoặc `LEADERBOARD_UPDATED` để Frontend biết và gọi lại API GET cập nhật Bảng xếp hạng.

> [!TIP]
> Bạn có thể tham khảo trực tiếp cách hoạt động và code kết nối mẫu tại các file HTML demo đi kèm trong source code:
> - Giám sát chấm bài OJ: [test-ws.html](file:///Users/ngocthanh/Documents/Project/codelearning-platform/src/main/resources/static/test-ws.html)
> - Giám sát tạo testcase: [test-ws-gen.html](file:///Users/ngocthanh/Documents/Project/codelearning-platform/src/main/resources/static/test-ws-gen.html)
> - Live Leaderboard kỳ thi: [leaderboard.html](file:///Users/ngocthanh/Documents/Project/codelearning-platform/src/main/resources/static/leaderboard.html)

---

### 2. Các Model TypeScript chưa được định nghĩa trong Mục II
Tài liệu thiếu các interface TypeScript sau, khiến AI Agent phải tự đoán cấu trúc:
1.  `AuthenticationResponse` (Cấu trúc phẳng trả về sau login).
2.  `CourseProgressResponse` (Trả về ở API `/users/me/progress/courses`).
3.  `OjWebSocketMessage` và `OjTestcaseGenWsMessage` (Thông điệp nhận qua WebSocket).

---

### 3. Kịch bản chuyển hướng thanh toán PayOS
Tại Endpoint 54 (`POST /payment/deposit`), tài liệu ghi nhận trả về `checkoutUrl`. Tuy nhiên, cơ chế kết thúc thanh toán không được làm rõ.
*   **Thực tế cấu hình ([application-dev.yaml](file:///Users/ngocthanh/Documents/Project/codelearning-platform/src/main/resources/application-dev.yaml)):**
    Backend cấu hình chuyển hướng PayOS sau khi hoàn tất/hủy về URL tĩnh:
    - Thành công: `http://localhost:8080/codelearning/payment/success.html`
    - Hủy bỏ: `http://localhost:8080/codelearning/payment/cancel.html`
*   **Lưu ý cho Frontend:** Đây là các trang HTML tĩnh do Backend phục vụ. Nếu muốn ứng dụng Frontend (React/Vite chạy ở port 3000/5173) tự xử lý giao diện Success/Cancel đẹp mắt thì các URL cấu hình trên PayOS cần phải được đổi hướng về Frontend thay vì trỏ về Backend.

---

## IV. PHÁT HIỆN LỖI/HẠN CHẾ TRONG CODE BACKEND (BACKEND BUGS)

Dưới đây là một số vấn đề trong mã nguồn Java của bạn, mặc dù bạn yêu cầu không sửa code, nhưng bạn nên nắm thông tin để sửa sau:

### 1. Trùng mã lỗi nội bộ (Duplicate Error Codes)
Trong enum [ErrorCode.java](file:///Users/ngocthanh/Documents/Project/codelearning-platform/src/main/java/com/thanhmila/codelearning/exception/ErrorCode.java), bạn đang định nghĩa trùng giá trị mã lỗi:
*   `PAGE_INVALID` dùng mã **2020** trùng với `INVALID_TOKEN` (**2020**).
*   `PAGE_SIZE_INVALID` dùng mã **2021** trùng với `EXPIRED_TOKEN` (**2021**).
*   **Hệ quả:** Khi Token bị hết hạn, server trả về mã lỗi 2021. Nếu client kiểm tra mã 2021 để tự động gọi API `/auth/refresh` thì sẽ bị nhầm lẫn nếu tham số phân trang page size bị lỗi (cũng trả về 2021).

### 2. Định dạng phản hồi Webhook không thực sự là HTTP 204
Tại API webhook nhận kết quả Judge0 (`PUT /online-judge/submissions`):
*   Tài liệu ghi: `Response (204 No Content)`.
*   Code Java: `return ResponseEntity.ok(ApiResponse.<Void>builder().status(204)...build());`
*   **Thực tế:** Hàm `ResponseEntity.ok()` sẽ trả về mã HTTP Status thực tế là **200 OK** kèm theo response body là JSON (trong đó trường JSON `.status` bằng 204). Đây không phải là một phản hồi HTTP 204 chuẩn (HTTP 204 bắt buộc không được có body).

### 3. Lỗi báo tin nhắn validation trong `RegisterRequest`
Trong [RegisterRequest.java](file:///Users/ngocthanh/Documents/Project/codelearning-platform/src/main/java/com/thanhmila/codelearning/dto/request/RegisterRequest.java):
*   Trường `displayName` chú thích lỗi `@NotBlank(message = "USERNAME_INVALID")`.
*   Đúng ra phải là `"DISPLAY_NAME_INVALID"` (hoặc tương tự) để tránh báo lỗi nhầm trường cho học viên khi đăng ký.

### 4. Thiếu API truy xuất lịch sử/chi tiết nộp bài (Submission History)
Hệ thống lưu trữ các lượt nộp bài OJ của học viên vào database (`submissionEntity`), nhưng hiện tại **không có API** nào để học viên lấy danh sách lịch sử nộp bài cũ của mình hoặc xem lại chi tiết code/kết quả testcase của một lượt nộp cũ (ví dụ: `GET /online-judge/submissions` hoặc `GET /online-judge/submissions/{id}`).
Học viên chỉ có thể xem code gần nhất qua trường `latestSourceCode` ở chi tiết đề bài.

---

## V. ĐỀ XUẤT HƯỚNG DẪN DÀNH CHO AI AGENT LÀM FRONTEND

Khi bạn đưa dự án này cho AI Agent làm giao diện, hãy đính kèm các hướng dẫn sau để nó tự động xử lý các điểm lệch pha của Backend:

1.  **Xác định Authentication Response:** Định nghĩa kiểu `AuthenticationResponse` ở dạng phẳng (flat), trực tiếp lấy `id`, `displayName`, `email`, `phoneNumber`, `balance` từ gốc của `result` thay vì đi qua trường `user`.
2.  **Định nghĩa PageResponse:** Cấu hình AI Agent map mảng dữ liệu phân trang từ trường `content` (thay vì `data`) và sử dụng các thuộc tính `page`, `size` của phản hồi JSON.
3.  **Xử lý riêng phân trang Bình luận:** Nhận biết các endpoint lấy bình luận bài học sẽ trả về cấu trúc `PageImpl` mặc định của Spring, cần map dữ liệu từ `result.content` và trang hiện tại từ `result.number`.
4.  **Interceptor hỗ trợ mã code 200 và 1000:** Cấu hình kiểm tra phản hồi thành công chấp nhận cả `code === 1000` hoặc `code === 200`.
5.  **Kết nối STOMP Live Feed:** Sử dụng thư viện `sockjs-client` và `stompjs` để kết nối vào `/ws` để nhận live-verdict khi làm bài tập OJ và tự động reload bảng xếp hạng khi nhận tín hiệu từ cuộc thi.
