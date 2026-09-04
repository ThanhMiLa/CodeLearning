# 📋 KẾ HOẠCH KIỂM THỬ: CONTROLLER PAYMENT, ORDER & CART MODULE (WEB MVC SLICE TESTS)
Dự án: **CodeLearning Platform Backend**  
Phân hệ: **Tầng Web API - Thanh toán PayOS, Đơn hàng, Giỏ hàng & Admin Giao dịch**  
Vị trí tài liệu: `backend/docs/plan_test/10_PLAN_CONTROLLER_PAYMENT_AND_WALLET_MODULE.md`  
Độ bao phủ mục tiêu: **Line Coverage $\ge 90\%$, Branch Coverage $\ge 85\%$**

---

## 1. Danh sách các Controller trong phạm vi kiểm thử

| Controller | Tuyến đường (Route) | Trọng tâm kiểm thử |
| :--- | :--- | :--- |
| **`PaymentController`** | `/payment/**` | POST `/deposit`: Tạo link thanh toán nạp tiền ví; POST `/webhook`: Nhận webhook PayOS, kiểm tra Secret query param, bắt lỗi try-catch luôn phản hồi HTTP 200 cho PayOS. |
| **`OrderController`** | `/orders/**` | POST `/checkout`: Thanh toán mua khóa học từ số dư ví, validate danh sách courseIds. |
| **`CartController`** | `/carts/**` | GET `/`: Lấy giỏ hàng; POST `/items`: Thêm khóa học; DELETE `/items/{courseId}`: Xóa 1 khóa học; DELETE `/items`: Làm trống giỏ hàng. |
| **`AdminPaymentController`** | `/admin/payment-transactions/**` | GET `/`: Phân trang, lọc theo keyword, status, type; Sort asc/desc; Quyền `PAYMENT_ADMIN_VIEW`. |

---

## 2. Phân tích chi tiết Dòng lệnh & Rẽ nhánh (Line & Branch Coverage Analysis)

### 2.1. `PaymentController.java`
* **Phương thức `createDeposit` (`POST /payment/deposit`):**
  * Lấy `userId = jwt.getClaim("userId")`.
  * Validate request DTO: `amount` tối thiểu (ví dụ 10,000 VND).
  * Trả về HTTP 200 kèm `checkoutUrl` và `transactionCode`.
* **Phương thức `handleWebhook` (`POST /payment/webhook`):**
  * **Nhánh 1 (Branch 1.1 - Lỗi bảo mật):** `secret == null || !secret.equals(webhookSecret)`.
    * *Hành vi:* Trả về HTTP 401 Unauthorized kèm thông báo `"Invalid webhook secret"`.
  * **Nhánh 2 (Branch 1.2 - Xử lý thành công):** Secret hợp lệ.
    * *Hành vi:* Gọi `paymentService.handlePayOSWebhook(payload)`, trả về HTTP 200 OK.
  * **Nhánh 3 (Branch 1.3 - Exception Fallback):** `paymentService.handlePayOSWebhook` ném Exception bất kỳ.
    * *Hành vi:* Bắt ngoại lệ, log error, nhưng VẪN TRẢ VỀ HTTP 200 OK để PayOS không retry dồn dập.

### 2.2. `OrderController.java`
* **Phương thức `checkout` (`POST /orders/checkout`):**
  * Validate request `@Valid OrderCheckoutRequest` (`courseIds` không được rỗng).
  * Lấy `userId` từ JWT.
  * Trả về HTTP 200 kèm `OrderCheckoutResponse` (orderId, tổng tiền trừ, danh sách khóa học).

### 2.3. `CartController.java`
* **Lấy giỏ hàng (`GET /carts`):**
  * Lấy `userId` từ JWT, gọi `cartService.getOrCreateCart(userId)`.
* **Thêm vào giỏ hàng (`POST /carts/items`):**
  * Validate `CartItemRequest` (`courseId` bắt buộc).
* **Xóa khỏi giỏ hàng (`DELETE /carts/items/{courseId}`):**
  * Xóa mục và trả về giỏ hàng cập nhật.
* **Xóa sạch giỏ hàng (`DELETE /carts/items`):**
  * Làm rỗng toàn bộ giỏ hàng của user.

### 2.4. `AdminPaymentController.java`
* **Tra cứu giao dịch (`GET /admin/payment-transactions`):**
  * Kiểm tra quyền `PAYMENT_ADMIN_VIEW`.
  * Rẽ nhánh sort: `sortDir="asc"` vs `sortDir="desc"`.
  * Kiểm tra lọc các enum `TransactionStatus` và `PaymentTransactionType`.

---

## 3. Ma trận Kịch bản Kiểm thử (Test Cases Matrix)

| Test ID | Controller / Endpoint | Điều kiện đầu vào (Given) | Hành vi kỳ vọng (Then) |
| :--- | :--- | :--- | :--- |
| **PAY_CTRL_01** | `POST /payment/deposit` | Request nạp 50,000 VND | HTTP 200, trả về link PayOS |
| **PAY_CTRL_02** | `POST /payment/deposit` | Amount < 10,000 VND (vi phạm `@Min`) | HTTP 400 Bad Request |
| **PAY_CTRL_03** | `POST /payment/webhook` | Secret null hoặc sai | HTTP 401 Unauthorized |
| **PAY_CTRL_04** | `POST /payment/webhook` | Secret đúng, webhook data hợp lệ | HTTP 200 OK |
| **PAY_CTRL_05** | `POST /payment/webhook` | Service ném RuntimeException | Vẫn trả về HTTP 200 OK cho PayOS |
| **ORD_CTRL_01** | `POST /orders/checkout` | Danh sách courseIds hợp lệ | HTTP 200, OrderCheckoutResponse |
| **ORD_CTRL_02** | `POST /orders/checkout` | courseIds rỗng (`@NotEmpty` vi phạm) | HTTP 400 Bad Request |
| **CART_CTRL_01**| `GET /carts` | User đã đăng nhập | HTTP 200, trả về CartResponse |
| **CART_CTRL_02**| `POST /carts/items` | Thêm courseId = 5 | HTTP 200, giỏ hàng có 1 item |
| **CART_CTRL_03**| `DELETE /carts/items/5` | Xóa courseId = 5 | HTTP 200, giỏ hàng cập nhật |
| **CART_CTRL_04**| `DELETE /carts/items` | Làm rỗng giỏ hàng | HTTP 200, clear thành công |
| **ADM_PAY_01** | `GET /admin/payment-transactions` | Quyền PAYMENT_ADMIN_VIEW | HTTP 200, PageResponse |

---

## 4. Test Blueprint Mẫu: `PaymentControllerTest.java`

```java
package com.thanhmila.codelearning.controller.payment;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.thanhmila.codelearning.service.payment.PaymentService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.verify;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(PaymentController.class)
@AutoConfigureMockMvc(addFilters = false)
@DisplayName("PaymentController WebMvc Slice Tests")
class PaymentControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockitoBean
    private PaymentService paymentService;

    @Autowired
    private PaymentController paymentController;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(paymentController, "webhookSecret", "secure-secret-123");
    }

    @Test
    @DisplayName("POST /payment/webhook: Sai secret trả về HTTP 401 Unauthorized")
    void handleWebhook_InvalidSecret_ReturnsHttp401() throws Exception {
        ObjectNode payload = objectMapper.createObjectNode();

        mockMvc.perform(post("/payment/webhook")
                        .param("secret", "wrong-secret")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(payload.toString()))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.message").value("Invalid webhook secret"));
    }

    @Test
    @DisplayName("POST /payment/webhook: Đúng secret và service thành công trả về HTTP 200")
    void handleWebhook_ValidSecret_ReturnsHttp200() throws Exception {
        ObjectNode payload = objectMapper.createObjectNode();

        mockMvc.perform(post("/payment/webhook")
                        .param("secret", "secure-secret-123")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(payload.toString()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("PayOS webhook processed successfully"));

        verify(paymentService).handlePayOSWebhook(any(ObjectNode.class));
    }

    @Test
    @DisplayName("POST /payment/webhook: Service ném Exception vẫn trả về HTTP 200 cho PayOS")
    void handleWebhook_ServiceThrowsException_StillReturnsHttp200() throws Exception {
        ObjectNode payload = objectMapper.createObjectNode();
        doThrow(new RuntimeException("DB Connection failed")).when(paymentService).handlePayOSWebhook(any());

        mockMvc.perform(post("/payment/webhook")
                        .param("secret", "secure-secret-123")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(payload.toString()))
                .andExpect(status().isOk());
    }
}
```
