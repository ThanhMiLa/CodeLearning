# 📋 KẾ HOẠCH KIỂM THỬ: AUTHENTICATION & USER MANAGEMENT MODULE
Dự án: **CodeLearning Platform**  
Module: **Auth, User, Admin User & Rate Limiting**  
Vị trí tài liệu: `backend/docs/plan_test/01_PLAN_AUTH_AND_USER_MODULE.md`  
Độ bao phủ mục tiêu: **Line Coverage $\ge 95\%$, Branch Coverage $\ge 90\%$**

---

## 1. Danh sách các Class trong phạm vi kiểm thử

| Thành phần | Đường dẫn file | Vai trò chính |
| :--- | :--- | :--- |
| **Service** | `service/auth/AuthenticationService.java` | Đăng ký, đăng nhập JWT, refresh token (RTR), logout, Google OAuth2, xác thực token |
| **Service** | `service/user/UserService.java` | Lấy profile, cập nhật thông tin + upload avatar Cloudinary, đổi mật khẩu, lấy số dư ví |
| **Service** | `service/admin/impl/AdminUserServiceImpl.java` | Tìm kiếm người dùng, thống kê user đang online qua Redis, lọc email gửi thông báo |
| **Service** | `service/auth/RateLimitService.java` | Bucket4j token bucket rate limiting theo IP/User |
| **Controller** | `controller/auth/AuthenticationController.java` | Endpoint xác thực, gắn/xóa HttpOnly cookies |
| **Controller** | `controller/user/UserController.java` | Endpoint người dùng cá nhân |
| **Controller** | `controller/admin/AdminUserController.java` | Endpoint quản trị tài khoản người dùng |

---

## 2. Phân tích chi tiết Dòng lệnh & Rẽ nhánh (Line & Branch Coverage Analysis)

### 2.1. `AuthenticationService.java`

#### Phương thức 1: `login(AuthenticationRequest request)`
* **Nhánh 1 (Branch 1.1):** `userRepository.findByUsernameWithWallet(username)` trả về `Optional.empty()`.
  * *Hành vi:* Ném `AppException(ErrorCode.INVALID_USERNAME_OR_PASSWORD)`.
* **Nhánh 2 (Branch 1.2):** `passwordEncoder.matches(rawPassword, hash)` trả về `false`.
  * *Hành vi:* Ném `AppException(ErrorCode.INVALID_USERNAME_OR_PASSWORD)`.
* **Nhánh 3 (Branch 1.3):** `userEntity.getStatus() == UserStatus.LOCKED`.
  * *Hành vi:* Ném `AppException(ErrorCode.ACCOUNT_LOCKED)`.
* **Nhánh 4 (Branch 1.4):** `userEntity.getStatus() == UserStatus.DISABLED`.
  * *Hành vi:* Ném `AppException(ErrorCode.ACCOUNT_DISABLED)`.
* **Nhánh 5 (Branch 1.5 - Happy Path):** Trạng thái `ACTIVE`, mật khẩu khớp.
  * *Hành vi:* Sinh `accessToken`, sinh `refreshToken`, trả về `AuthenticationResponse` đủ thông tin (roles, permissions, wallet balance nếu có).

#### Phương thức 2: `register(RegisterRequest registerRequest)`
* **Nhánh 1 (Branch 2.1):** `userRepository.existsByUsername(username)` trả về `true`.
  * *Hành vi:* Ném `AppException(ErrorCode.USERNAME_ALREADY_EXISTS)`.
* **Nhánh 2 (Branch 2.2):** `!Objects.equals(password, confirmPassword)`.
  * *Hành vi:* Ném `AppException(ErrorCode.PASSWORD_NOT_MATCH)`.
* **Nhánh 3 (Branch 2.3):** `userRepository.existsByEmail(email)` trả về `true`.
  * *Hành vi:* Ném `AppException(ErrorCode.EMAIL_ALREADY_EXISTS)`.
* **Nhánh 4 (Branch 2.4 - Happy Path):** Dữ liệu hợp lệ.
  * *Hành vi:* Mã hóa mật khẩu, gán role mặc định `"USER"`, lưu user, phát sự kiện `UserRegisteredEvent`, tự động gọi `login()` và trả về token.

#### Phương thức 3: `googleLogin(GoogleLoginRequest request)`
* **Nhánh 1 (Branch 3.1):** Google ID Token giải mã trả về `null`.
  * *Hành vi:* Ném `AppException(ErrorCode.UNAUTHENTICATED)`.
* **Nhánh 2 (Branch 3.2):** Tài khoản OAuth đã tồn tại trong `UserOauthAccountRepository`.
  * *Hành vi:* Lấy user liên kết từ OAuth Account, kiểm tra trạng thái và cấp token.
* **Nhánh 3 (Branch 3.3):** Tài khoản OAuth chưa có, nhưng Email Google đã tồn tại trong bảng `users`.
  * *Hành vi:* Liên kết user hiện tại với bản ghi OAuth mới, cấp token.
* **Nhánh 4 (Branch 3.4):** Cả OAuth lẫn Email đều chưa từng tồn tại.
  * *Hành vi:* Tạo mới `UserEntity` (username tiền tố `google_`), phát sự kiện `UserRegisteredEvent`, tạo `UserOauthAccountEntity`, cấp token.
* **Nhánh 5 (Branch 3.5):** Google Verifier ném Exception (mạng, token giả).
  * *Hành vi:* Bắt ngoại lệ, log lỗi và ném `AppException(ErrorCode.UNAUTHENTICATED)`.

#### Phương thức 4: `refreshToken(String refreshToken)`
* **Nhánh 1 (Branch 4.1):** `refreshToken` null hoặc rỗng.
  * *Hành vi:* Ném `AppException(ErrorCode.INVALID_TOKEN)`.
* **Nhánh 2 (Branch 4.2):** Token hết hạn hoặc sai chữ ký (bị `verifyToken` chặn).
  * *Hành vi:* Ném `AppException(ErrorCode.EXPIRED_TOKEN)` hoặc `UNAUTHENTICATED`.
* **Nhánh 3 (Branch 4.3):** Token đã bị thu hồi trước đó (`invalidatedTokenRepository.existsById(jti) == true`).
  * *Hành vi:* Ném `AppException(ErrorCode.INVALID_TOKEN)`.
* **Nhánh 4 (Branch 4.4):** Claim `scope` không phải `"REFRESH"` (ví dụ truyền nhầm access token).
  * *Hành vi:* Ném `AppException(ErrorCode.INVALID_TOKEN)`.
* **Nhánh 5 (Branch 4.5 - Happy Path - Refresh Token Rotation):**
  * *Hành vi:* Lưu JTI của refresh token cũ vào `invalidated_tokens`, sinh cặp Access Token & Refresh Token mới, trả về response.

#### Phương thức 5: `logout(LogoutRequest request)`
* **Nhánh 1 (Branch 5.1):** Token hợp lệ -> Lưu JTI và ExpirationTime vào `invalidatedTokenRepository`.
* **Nhánh 2 (Branch 5.2):** Token không thể parse / lỗi -> Bắt ParseException, log cảnh báo.

---

### 2.2. `UserService.java`

#### Phương thức 1: `getMyInfo(String username)`
* **Nhánh 1:** Không tìm thấy user -> `USER_NOT_FOUND`.
* **Nhánh 2:** User bị locked/disabled -> Exception qua `validateStatus()`.
* **Nhánh 3 (Happy):** Trả về `UserResponse`.

#### Phương thức 2: `updateProfile(String username, UpdateProfileRequest request)`
* **Nhánh 1:** User không tồn tại -> `USER_NOT_FOUND`.
* **Nhánh 2:** `request.getDisplayName() == null` -> giữ nguyên displayName cũ; khác null -> cập nhật mới.
* **Nhánh 3:** `request.getPhoneNumber() == null` -> giữ nguyên số cũ; khác null -> cập nhật mới.
* **Nhánh 4:** `request.getAvatarFile() != null && !isEmpty()`:
  * Nhánh 4a: User đã có `avatarPublicId` trước đó -> Gọi `cloudinaryService.deleteFile()`.
  * Nhánh 4b: User chưa có `avatarPublicId` -> Không gọi deleteFile.
  * Nhánh 4c: Upload Cloudinary thành công -> Cập nhật `avatarUrl` và `avatarPublicId`.
  * Nhánh 4d: Cloudinary ném `IOException` -> Ném `AppException(ErrorCode.CLOUDINARY_UPLOAD_FAILED)`.
* **Nhánh 5:** `avatarFile == null` -> Bỏ qua logic ảnh, chỉ lưu thông tin chữ.

#### Phương thức 3: `changePassword(String username, ChangePasswordRequest request)`
* **Nhánh 1:** User không tồn tại -> `USER_NOT_FOUND`.
* **Nhánh 2:** Mật khẩu cũ không khớp hash -> `OLD_PASSWORD_NOT_MATCH`.
* **Nhánh 3:** Mật khẩu mới và xác nhận mật khẩu không giống nhau -> `PASSWORD_NOT_MATCH`.
* **Nhánh 4:** Mật khẩu mới trùng với mật khẩu cũ (`matches == true`) -> `NEW_PASSWORD_SAME_AS_OLD_PASSWORD`.
* **Nhánh 5 (Happy):** Mã hóa mật khẩu mới, cập nhật `updatedAt`, lưu vào DB.

#### Phương thức 4: `getBalance(String username)`
* **Nhánh 1:** User không tồn tại -> `USER_NOT_FOUND`.
* **Nhánh 2:** `userEntity.getWallet() == null` -> Trả về `BigDecimal.ZERO`.
* **Nhánh 3:** `userEntity.getWallet() != null` -> Trả về số dư hiện tại của ví.

---

### 2.3. `AdminUserServiceImpl.java`

* **`getUsersForAdmin`:**
  * Nhánh 1: `keyword != null && !keyword.trim().isEmpty()` -> Gọi `userRepository.searchForAdmin()`.
  * Nhánh 2: `keyword == null` hoặc rỗng -> Gọi `userRepository.findAllForAdmin()`.
* **`getOnlineUsers`:**
  * Nhánh 1: Redis trả về tập key rỗng / null -> Trả về `Page.empty()`.
  * Nhánh 2: Danh sách ID parse được rỗng (do lỗi NumberFormatException) -> Trả về `Page.empty()`.
  * Nhánh 3: Danh sách ID hợp lệ -> Gọi `userRepository.findOnlineUsersForAdmin()` và map sang DTO.
* **`getEmailTargets`:**
  * Nhánh 1: `u.getDisplayName() != null` -> lấy displayName; null -> lấy username.
  * Nhánh 2: `u.getRoles()` có role -> lấy tên role đầu tiên; rỗng -> gán mặc định `"USER"`.

---

## 3. Ma trận Kịch bản Kiểm thử (Test Cases Matrix)

| Test ID | Method | Điều kiện đầu vào (Given) | Hành vi kỳ vọng (Then) |
| :--- | :--- | :--- | :--- |
| **AUTH_01** | `login` | Username không có trong DB | Throws `AppException(INVALID_USERNAME_OR_PASSWORD)` |
| **AUTH_02** | `login` | Password sai | Throws `AppException(INVALID_USERNAME_OR_PASSWORD)` |
| **AUTH_03** | `login` | User status = `LOCKED` | Throws `AppException(ACCOUNT_LOCKED)` |
| **AUTH_04** | `login` | User status = `DISABLED` | Throws `AppException(ACCOUNT_DISABLED)` |
| **AUTH_05** | `login` | Hợp lệ (Status ACTIVE, pass đúng) | Trả về AccessToken, RefreshToken, User DTO |
| **AUTH_06** | `register` | Username đã tồn tại | Throws `AppException(USERNAME_ALREADY_EXISTS)` |
| **AUTH_07** | `register` | Password != ConfirmPassword | Throws `AppException(PASSWORD_NOT_MATCH)` |
| **AUTH_08** | `register` | Email đã tồn tại | Throws `AppException(EMAIL_ALREADY_EXISTS)` |
| **AUTH_09** | `register` | Hợp lệ | Save user, publish `UserRegisteredEvent`, login thành công |
| **AUTH_10** | `refreshToken` | Token null hoặc rỗng | Throws `AppException(INVALID_TOKEN)` |
| **AUTH_11** | `refreshToken` | Token nằm trong blacklist `invalidated_tokens` | Throws `AppException(INVALID_TOKEN)` |
| **AUTH_12** | `refreshToken` | Token là ACCESS token (sai scope) | Throws `AppException(INVALID_TOKEN)` |
| **AUTH_13** | `refreshToken` | Refresh token hợp lệ | Blacklist token cũ, trả về cặp token mới |
| **USER_01** | `changePassword` | Old password không khớp DB | Throws `AppException(OLD_PASSWORD_NOT_MATCH)` |
| **USER_02** | `changePassword` | New pass != Confirm new pass | Throws `AppException(PASSWORD_NOT_MATCH)` |
| **USER_03** | `changePassword` | New pass trùng Old pass | Throws `AppException(NEW_PASSWORD_SAME_AS_OLD_PASSWORD)` |
| **USER_04** | `changePassword` | Hợp lệ | Password mới được hash bằng BCrypt và lưu DB |
| **USER_05** | `updateProfile` | Upload avatar có file, Cloudinary ném IOException | Throws `AppException(CLOUDINARY_UPLOAD_FAILED)` |
| **USER_06** | `updateProfile` | User có avatar cũ -> Xóa ảnh cũ trước khi lưu ảnh mới | `verify(cloudinaryService).deleteFile(oldId)` được gọi |

---

## 4. Test Blueprint Mẫu: `AuthenticationServiceTest.java`

```java
package com.thanhmila.codelearning.service.auth;

import com.thanhmila.codelearning.dto.request.AuthenticationRequest;
import com.thanhmila.codelearning.dto.request.RegisterRequest;
import com.thanhmila.codelearning.dto.response.AuthenticationResponse;
import com.thanhmila.codelearning.entity.auth.RoleEntity;
import com.thanhmila.codelearning.entity.enums.UserStatus;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.event.UserRegisteredEvent;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.UserMapper;
import com.thanhmila.codelearning.repository.auth.InvalidatedTokenRepository;
import com.thanhmila.codelearning.repository.auth.RoleRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.util.ReflectionTestUtils;

import java.util.Optional;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("AuthenticationService Unit Tests")
class AuthenticationServiceTest {

    @Mock UserRepository userRepository;
    @Mock PasswordEncoder passwordEncoder;
    @Mock RoleRepository roleRepository;
    @Mock InvalidatedTokenRepository invalidatedTokenRepository;
    @Mock ApplicationEventPublisher applicationEventPublisher;
    @Mock UserMapper userMapper;

    @InjectMocks AuthenticationService authService;

    private final String SECRET = "12345678901234567890123456789012"; // 32 chars

    @BeforeEach
    void init() {
        ReflectionTestUtils.setField(authService, "SIGNER_KEY", SECRET);
        ReflectionTestUtils.setField(authService, "VALID_DURATION", 3600L);
        ReflectionTestUtils.setField(authService, "REFRESHABLE_DURATION", 86400L);
    }

    @Nested
    @DisplayName("Login Method Tests")
    class LoginTests {

        @Test
        @DisplayName("Throw INVALID_USERNAME_OR_PASSWORD when user not found")
        void shouldThrow_WhenUserNotFound() {
            when(userRepository.findByUsernameWithWallet("unknown")).thenReturn(Optional.empty());

            assertThatThrownBy(() -> authService.login(new AuthenticationRequest("unknown", "pass")))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.INVALID_USERNAME_OR_PASSWORD);
        }

        @Test
        @DisplayName("Throw INVALID_USERNAME_OR_PASSWORD when password mismatch")
        void shouldThrow_WhenPasswordWrong() {
            UserEntity user = UserEntity.builder().username("test").passwordHash("hashed").status(UserStatus.ACTIVE).build();
            when(userRepository.findByUsernameWithWallet("test")).thenReturn(Optional.of(user));
            when(passwordEncoder.matches("wrongpass", "hashed")).thenReturn(false);

            assertThatThrownBy(() -> authService.login(new AuthenticationRequest("test", "wrongpass")))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.INVALID_USERNAME_OR_PASSWORD);
        }

        @Test
        @DisplayName("Throw ACCOUNT_LOCKED when user status is LOCKED")
        void shouldThrow_WhenUserLocked() {
            UserEntity user = UserEntity.builder().username("test").passwordHash("hashed").status(UserStatus.LOCKED).build();
            when(userRepository.findByUsernameWithWallet("test")).thenReturn(Optional.of(user));
            when(passwordEncoder.matches("pass", "hashed")).thenReturn(true);

            assertThatThrownBy(() -> authService.login(new AuthenticationRequest("test", "pass")))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.ACCOUNT_LOCKED);
        }

        @Test
        @DisplayName("Success Login with valid credentials")
        void shouldReturnAuthResponse_WhenValidCredentials() {
            RoleEntity role = RoleEntity.builder().name("USER").build();
            UserEntity user = UserEntity.builder()
                    .id(1L)
                    .username("test")
                    .passwordHash("hashed")
                    .status(UserStatus.ACTIVE)
                    .roles(Set.of(role))
                    .build();

            when(userRepository.findByUsernameWithWallet("test")).thenReturn(Optional.of(user));
            when(passwordEncoder.matches("pass", "hashed")).thenReturn(true);

            AuthenticationResponse response = authService.login(new AuthenticationRequest("test", "pass"));

            assertThat(response).isNotNull();
            assertThat(response.getToken()).isNotBlank();
            assertThat(response.getRefreshToken()).isNotBlank();
            assertThat(response.isAuthenticated()).isTrue();
        }
    }

    @Nested
    @DisplayName("Register Method Tests")
    class RegisterTests {

        @Test
        @DisplayName("Throw USERNAME_ALREADY_EXISTS when username taken")
        void shouldThrow_WhenUsernameExists() {
            RegisterRequest req = RegisterRequest.builder().username("existing").build();
            when(userRepository.existsByUsername("existing")).thenReturn(true);

            assertThatThrownBy(() -> authService.register(req))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.USERNAME_ALREADY_EXISTS);
        }

        @Test
        @DisplayName("Throw PASSWORD_NOT_MATCH when confirm password differs")
        void shouldThrow_WhenConfirmPasswordMismatch() {
            RegisterRequest req = RegisterRequest.builder().username("newuser").password("p1").confirmPassword("p2").build();
            when(userRepository.existsByUsername("newuser")).thenReturn(false);

            assertThatThrownBy(() -> authService.register(req))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.PASSWORD_NOT_MATCH);
        }
    }
}
```

---

## 5. Kế hoạch Kiểm thử Tầng Controller (`@WebMvcTest`)

### `AuthenticationControllerTest.java`
1. **Mock Security:** Sử dụng `@AutoConfigureMockMvc(addFilters = false)` hoặc `@WithMockUser`.
2. **Kiểm thử HttpOnly Cookie:**
   * Gửi request `/auth/token` -> verify header `Set-Cookie` chứa `access_token` và `refresh_token` với cờ `HttpOnly`, `SameSite=Lax`.
   * Gửi request `/auth/logout` -> verify header `Set-Cookie` có `Max-Age=0` để trình duyệt xoá cookie.
3. **Kiểm thử DTO Validation:**
   * Gửi request `/auth/register` với password 2 ký tự -> Mong đợi HTTP 400 và `PASSWORD_INVALID`.
