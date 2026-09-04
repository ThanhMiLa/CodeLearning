# 📋 KẾ HOẠCH KIỂM THỬ: SECURITY FILTERS, INTERCEPTORS & WEBSOCKET AUTH
Dự án: **CodeLearning Platform Backend**  
Phân hệ: **Tầng An ninh Mạng - IP Rate Limiting, User Throttling, JWT EntryPoints & WebSocket STOMP Auth**  
Vị trí tài liệu: `backend/docs/plan_test/14_PLAN_SECURITY_FILTERS_INTERCEPTORS_AND_WEBSOCKET.md`  
Độ bao phủ mục tiêu: **Line Coverage $\ge 95\%$, Branch Coverage $\ge 90\%$**

---

## 1. Danh sách các Class trong phạm vi kiểm thử

| Thành phần | Đường dẫn file | Vai trò chính |
| :--- | :--- | :--- |
| **Filter** | `security/IpRateLimitFilter.java` | Trích xuất IP (hỗ trợ `X-Forwarded-For`), kiểm tra Bucket4j; nếu vượt ngưỡng 100 req/phút -> Trả về HTTP 429 JSON `TOO_MANY_REQUESTS`. |
| **Interceptor** | `security/UserRateLimitInterceptor.java` | Kiểm tra giới hạn 10 req/giây đối với mỗi User đăng nhập. |
| **Security Handler** | `security/JwtAuthenticationEntryPoint.java` | Bắt lỗi HTTP 401 Unauthorized khi token không hợp lệ, trả về định dạng `ApiResponse(code=1001)`. |
| **Security Handler** | `security/JwtAccessDeniedHandler.java` | Bắt lỗi HTTP 403 Forbidden khi thiếu quyền (Access Denied), trả về `ApiResponse(code=1003)`. |
| **WebSocket** | `configuration/WebSocketAuthInterceptor.java` | Chặn kết nối STOMP `CONNECT`, trích xuất Bearer token từ header, xác thực chữ ký Nimbus HS512, gán `UsernamePasswordAuthenticationToken` vào context STOMP. |
| **Controller** | `controller/error/CustomErrorController.java` | Xử lý các đường dẫn lỗi mặc định của Spring Boot container. |

---

## 2. Phân tích chi tiết Dòng lệnh & Rẽ nhánh (Line & Branch Coverage Analysis)

### 2.1. `IpRateLimitFilter.java`
* **Trích xuất IP (`extractClientIp`):**
  * Nhánh 1: Header `X-Forwarded-For` là null hoặc rỗng -> Lấy trực tiếp `request.getRemoteAddr()`.
  * Nhánh 2: `X-Forwarded-For` có nhiều proxy IP (ví dụ `"203.0.113.195, 70.41.3.18, 150.172.238.178"`) -> Tách chuỗi và lấy IP đầu tiên (`trim()`).
* **Kiểm tra Token Bucket (`rateLimitService.tryConsumeIp(ip)`):**
  * Nhánh 1: Còn token (`true`) -> Cho qua filter chain (`filterChain.doFilter(request, response)`).
  * Nhánh 2: Hết token (`false` - Bị rate limit) -> Set status HTTP 429, header JSON UTF-8, ghi JSON `ApiResponse` và `return` sớm (chặn request đi tiếp).

### 2.2. `JwtAuthenticationEntryPoint.java` & `JwtAccessDeniedHandler.java`
* Kiểm tra việc ghi mã lỗi chuẩn HTTP 401/403, set Content-Type `application/json`, buffer flush đúng cấu trúc `ApiResponse`.

### 2.3. `WebSocketAuthInterceptor.java`
* **Phương thức: `preSend(Message<?> message, MessageChannel channel)`**
  * **Nhánh 1:** Lệnh STOMP không phải `CONNECT` (ví dụ `SEND`, `SUBSCRIBE`) -> Cho qua, không kiểm tra header xác thực kết nối.
  * **Nhánh 2:** Lệnh STOMP là `CONNECT` nhưng thiếu header `"Authorization"` hoặc không bắt đầu bằng `"Bearer "` -> Bỏ qua, không gán User authentication.
  * **Nhánh 3:** Có Bearer token nhưng token không hợp lệ (sai signature, hết hạn, parse lỗi) -> Bắt Exception, log lỗi, không crash message.
  * **Nhánh 4 (Happy Path):** Bearer token hợp lệ, giải mã claim `userId` -> Tạo `UsernamePasswordAuthenticationToken(userId)` và gọi `accessor.setUser(authentication)`.

---

## 3. Ma trận Kịch bản Kiểm thử (Test Cases Matrix)

| Test ID | Class / Method | Điều kiện đầu vào (Given) | Hành vi kỳ vọng (Then) |
| :--- | :--- | :--- | :--- |
| **IP_FLT_01** | `IpRateLimitFilter` | Request bình thường còn hạn mức | Gọi `filterChain.doFilter` |
| **IP_FLT_02** | `IpRateLimitFilter` | Vượt quá hạn mức (`tryConsumeIp = false`) | HTTP 429, Body chứa `TOO_MANY_REQUESTS`, không gọi `filterChain` |
| **IP_FLT_03** | `IpRateLimitFilter` | Request có `X-Forwarded-For: 1.2.3.4, 5.6.7.8` | Trích xuất đúng IP `1.2.3.4` |
| **AUTH_EP_01**| `JwtAuthenticationEntryPoint`| Ném `AuthenticationException` | HTTP 401, JSON chứa code 1001 |
| **ACC_DH_01** | `JwtAccessDeniedHandler` | Ném `AccessDeniedException` | HTTP 403, JSON chứa code 1003 |
| **WS_INT_01** | `WebSocketAuthInterceptor` | Lệnh `CONNECT`, Bearer token hợp lệ có claim `userId=99` | Gán Principal `userId="99"` vào StompHeaderAccessor |
| **WS_INT_02** | `WebSocketAuthInterceptor` | Lệnh `CONNECT`, Token giả mạo | Không gán Principal |
| **WS_INT_03** | `WebSocketAuthInterceptor` | Lệnh `SUBSCRIBE` | Trả về message nguyên bản |

---

## 4. Test Blueprint Mẫu: `IpRateLimitFilterTest.java`

```java
package com.thanhmila.codelearning.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import jakarta.servlet.FilterChain;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Spy;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("IpRateLimitFilter Unit Tests")
class IpRateLimitFilterTest {

    @Mock
    private RateLimitService rateLimitService;

    @Spy
    private ObjectMapper objectMapper = new ObjectMapper();

    @Mock
    private FilterChain filterChain;

    @InjectMocks
    private IpRateLimitFilter ipRateLimitFilter;

    @Test
    @DisplayName("doFilterInternal: IP còn token khả dụng -> Cho phép đi tiếp")
    void doFilterInternal_Allowed_CallsChain() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setRemoteAddr("192.168.1.100");
        MockHttpServletResponse response = new MockHttpServletResponse();

        when(rateLimitService.tryConsumeIp("192.168.1.100")).thenReturn(true);

        ipRateLimitFilter.doFilterInternal(request, response, filterChain);

        verify(filterChain).doFilter(request, response);
        assertThat(response.getStatus()).isEqualTo(200);
    }

    @Test
    @DisplayName("doFilterInternal: IP hết token -> Trả về HTTP 429 và chặn request")
    void doFilterInternal_Blocked_ReturnsHttp429() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setRemoteAddr("192.168.1.200");
        MockHttpServletResponse response = new MockHttpServletResponse();

        when(rateLimitService.tryConsumeIp("192.168.1.200")).thenReturn(false);

        ipRateLimitFilter.doFilterInternal(request, response, filterChain);

        verify(filterChain, never()).doFilter(any(), any());
        assertThat(response.getStatus()).isEqualTo(429);
        assertThat(response.getContentAsString()).contains("TOO_MANY_REQUESTS");
    }
}
```
