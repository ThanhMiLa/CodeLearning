# 📋 KẾ HOẠCH KIỂM THỬ: CONTROLLER AUTH & USER MANAGEMENT (WEB MVC SLICE TESTS)
Dự án: **CodeLearning Platform Backend**  
Phân hệ: **Tầng Web API - Authentication, User & Admin User**  
Vị trí tài liệu: `backend/docs/plan_test/08_PLAN_CONTROLLER_AUTH_AND_USER_MODULE.md`  
Độ bao phủ mục tiêu: **Line Coverage $\ge 90\%$, Branch Coverage $\ge 85\%$**

---

## 1. Danh sách các Controller trong phạm vi kiểm thử

| Controller | Tuyến đường (Route) | Trọng tâm kiểm thử |
| :--- | :--- | :--- |
| **`AuthenticationController`** | `/auth/**` | POST `/login`, `/google`, `/register`, `/logout`, `/refresh`; Validate Request DTO, Gắn Cookie `Set-Cookie` (HttpOnly, SameSite, MaxAge), Xóa Cookie khi logout, Parse `@CookieValue`. |
| **`UserController`** | `/users/**` | GET `/me`, GET `/me/balance`, PATCH `/me` (Multipart/form-data), PUT `/me/password` (đổi mật khẩu + hủy cookie), GET `/me/progress/courses`, Phân quyền `@PreAuthorize` (`USER_VIEW`, `USER_UPDATE`, `LEARNING_PROGRESS_VIEW_OWN`). |
| **`AdminUserController`** | `/admin/users/**` | GET `/` (phân trang, lọc keyword, sort asc/desc), GET `/online` (danh sách user trực tuyến), GET `/email-targets` (lọc mục tiêu email theo role/keyword), Quyền `USER_ADMIN_VIEW`. |

---

## 2. Phân tích chi tiết Dòng lệnh & Rẽ nhánh (Line & Branch Coverage Analysis)

### 2.1. `AuthenticationController.java`
* **Phương thức `login` (`POST /auth/login`):**
  * Nhánh 1: Request hợp lệ -> Gọi `authenticationService.login()`, add 2 cookie (`access_token`, `refresh_token`), clear token trong body, trả về HTTP 200 kèm `ApiResponse(code=1000)`.
  * Nhánh 2: Service ném `AppException(INVALID_USERNAME_OR_PASSWORD)` -> Bắt qua `GlobalExceptionHandler`, trả về HTTP 401 hoặc 400.
* **Phương thức `googleLogin` (`POST /auth/google`):**
  * Nhánh 1: Body thiếu `idToken` (vi phạm `@Valid`) -> Bắt validation, trả về HTTP 400.
  * Nhánh 2: Body hợp lệ -> Gọi `authenticationService.googleLogin()`, add cookies, trả về HTTP 200.
* **Phương thức `register` (`POST /auth/register`):**
  * Nhánh 1: Dữ liệu không hợp lệ (username rỗng, email sai định dạng, password ngắn) -> Trả về HTTP 400.
  * Nhánh 2: Đăng ký thành công -> Gắn cookie xác thực, trả về HTTP 200.
* **Phương thức `logout` (`POST /auth/logout`):**
  * Nhánh 1: Có cookie `access_token` và `refresh_token` gửi lên -> Gọi logout, set cookie maxAge = 0 (`clearAuthCookies`), trả về HTTP 200.
  * Nhánh 2: Không truyền cookie (`required = false`) -> Vẫn thực thi êm đẹp, xóa cookie, trả về HTTP 200.
* **Phương thức `refresh` (`POST /auth/refresh`):**
  * Nhánh 1: Không có cookie `refresh_token` -> `refreshToken` là null, ném ngoại lệ hoặc trả về lỗi unauthenticated.
  * Nhánh 2: Token hợp lệ -> Gọi `authenticationService.refresh()`, cập nhật cookie mới, trả về HTTP 200.

### 2.2. `UserController.java`
* **Phương thức `getMyInfo` (`GET /users/me`):**
  * Nhánh 1: Token hợp lệ có quyền `USER_VIEW` -> Lấy username từ `jwt.getSubject()`, trả về profile user HTTP 200.
  * Nhánh 2: Không có quyền -> HTTP 403 Forbidden.
* **Phương thức `getMyBalance` (`GET /users/me/balance`):**
  * Trả về số dư ví và trạng thái ví của user đăng nhập.
* **Phương thức `updateProfile` (`PATCH /users/me`):**
  * Nhận `multipart/form-data` kèm `@ModelAttribute @Valid UpdateProfileRequest` (displayName, avatar MultipartFile).
* **Phương thức `changePassword` (`PUT /users/me/password`):**
  * Đổi mật khẩu thành công -> Gọi `authenticationService.logout`, clear cookies trên response, trả về HTTP 200.
* **Phương thức `getCourseProgress` (`GET /users/me/progress/courses`):**
  * Trích xuất claim `userId` từ JWT -> Gọi `progressService.getCourseProgress(userId)`, trả về danh sách tiến độ.

### 2.3. `AdminUserController.java`
* **Phương thức `getUsers` (`GET /admin/users`):**
  * Nhánh 1: `sortDir="asc"` -> `Sort.by(sortBy).ascending()`.
  * Nhánh 2: `sortDir="desc"` -> `Sort.by(sortBy).descending()`.
  * Kiểm tra phân trang mặc định `page=0, size=20`.
* **Phương thức `getOnlineUsers` (`GET /admin/users/online`):**
  * Trả về danh sách user online từ Redis qua service.
* **Phương thức `getEmailTargets` (`GET /admin/users/email-targets`):**
  * Lọc theo `keyword` và `role`.

---

## 3. Ma trận Kịch bản Kiểm thử (Test Cases Matrix)

| Test ID | Controller / Endpoint | Điều kiện đầu vào (Given) | Hành vi kỳ vọng (Then) |
| :--- | :--- | :--- | :--- |
| **AUTH_CTRL_01** | `POST /auth/login` | Request username/password đúng | HTTP 200, header `Set-Cookie` chứa token, body token bị ẩn |
| **AUTH_CTRL_02** | `POST /auth/login` | Service ném `AppException(INVALID_USERNAME_OR_PASSWORD)` | HTTP 400/401, error code tương ứng |
| **AUTH_CTRL_03** | `POST /auth/register` | Dữ liệu hợp lệ | HTTP 200, header `Set-Cookie` hiện diện |
| **AUTH_CTRL_04** | `POST /auth/register` | Username để trống (`@NotBlank` vi phạm) | HTTP 400 Bad Request |
| **AUTH_CTRL_05** | `POST /auth/logout` | Gửi kèm cookie | HTTP 200, `Set-Cookie` có `Max-Age=0` |
| **AUTH_CTRL_06** | `POST /auth/refresh` | Gửi kèm cookie `refresh_token` hợp lệ | HTTP 200, cập nhật cookie mới |
| **USER_CTRL_01** | `GET /users/me` | JWT có `USER_VIEW` authority | HTTP 200, trả về thông tin user |
| **USER_CTRL_02** | `GET /users/me/balance` | JWT có `USER_VIEW` authority | HTTP 200, trả về số dư ví |
| **USER_CTRL_03** | `PUT /users/me/password` | Đổi mật khẩu hợp lệ | HTTP 200, xóa cookie xác thực |
| **USER_CTRL_04** | `GET /users/me/progress/courses` | JWT có claim `userId=1` | HTTP 200, danh sách tiến độ |
| **ADMIN_U_01** | `GET /admin/users` | Param `sortDir=asc` | Sort ascending, HTTP 200 |
| **ADMIN_U_02** | `GET /admin/users` | Param `sortDir=desc` | Sort descending, HTTP 200 |
| **ADMIN_U_03** | `GET /admin/users/online` | Pageable chuẩn | HTTP 200, trả về PageResponse |
| **ADMIN_U_04** | `GET /admin/users/email-targets` | Param keyword & role | HTTP 200, trả về danh sách email targets |

---

## 4. Test Blueprint Mẫu: `AuthenticationControllerTest.java`

```java
package com.thanhmila.codelearning.controller.auth;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.dto.request.AuthenticationRequest;
import com.thanhmila.codelearning.dto.response.AuthenticationResponse;
import com.thanhmila.codelearning.service.auth.AuthenticationService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(AuthenticationController.class)
@AutoConfigureMockMvc(addFilters = false)
@DisplayName("AuthenticationController WebMvc Slice Tests")
class AuthenticationControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockitoBean
    private AuthenticationService authenticationService;

    @Test
    @DisplayName("POST /auth/login: Thành công gắn HttpOnly Cookie và trả về HTTP 200")
    void login_Success_ReturnsHttp200AndCookies() throws Exception {
        AuthenticationRequest request = AuthenticationRequest.builder()
                .username("testuser")
                .password("Password@123")
                .build();

        AuthenticationResponse response = AuthenticationResponse.builder()
                .accessToken("mock-access-token")
                .refreshToken("mock-refresh-token")
                .authenticated(true)
                .build();

        when(authenticationService.login(any(AuthenticationRequest.class))).thenReturn(response);

        mockMvc.perform(post("/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(header().exists("Set-Cookie"))
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.status").value(200));
    }
}
```
