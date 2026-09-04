package com.thanhmila.codelearning.controller.user;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.dto.request.ChangePasswordRequest;
import com.thanhmila.codelearning.dto.response.CourseProgressResponse;
import com.thanhmila.codelearning.dto.response.UserBalanceResponse;
import com.thanhmila.codelearning.dto.response.UserResponse;
import com.thanhmila.codelearning.security.UserRateLimitInterceptor;
import com.thanhmila.codelearning.service.auth.AuthenticationService;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import com.thanhmila.codelearning.service.user.ProgressService;
import com.thanhmila.codelearning.service.user.UserService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.security.web.method.annotation.AuthenticationPrincipalArgumentResolver;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.math.BigDecimal;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(UserController.class)
@AutoConfigureMockMvc(addFilters = false)
@ActiveProfiles("test")
@Import(UserControllerTest.TestConfig.class)
@DisplayName("UserController WebMvc Slice Tests")
class UserControllerTest {

    @TestConfiguration
    static class TestConfig implements WebMvcConfigurer {
        @Override
        public void addArgumentResolvers(List<HandlerMethodArgumentResolver> resolvers) {
            resolvers.add(new AuthenticationPrincipalArgumentResolver());
        }
    }

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockitoBean
    private UserService userService;

    @MockitoBean
    private AuthenticationService authenticationService;

    @MockitoBean
    private ProgressService progressService;

    @MockitoBean
    private RateLimitService rateLimitService;

    @MockitoBean
    private UserRateLimitInterceptor userRateLimitInterceptor;

    @BeforeEach
    void setUp() throws Exception {
        when(userRateLimitInterceptor.preHandle(any(), any(), any())).thenReturn(true);
    }

    @AfterEach
    void tearDown() {
        SecurityContextHolder.clearContext();
    }

    private void authenticate(String username, Long userId) {
        Jwt jwt = Jwt.withTokenValue("mock-jwt-token")
                .header("alg", "none")
                .subject(username)
                .claim("userId", userId)
                .build();
        SecurityContextHolder.getContext().setAuthentication(
                new JwtAuthenticationToken(jwt, List.of(new SimpleGrantedAuthority("USER_VIEW")), username)
        );
    }

    @Test
    @DisplayName("GET /users/me: Lấy thông tin user hiện tại thành công trả về HTTP 200")
    void getMyInfo_Success_ReturnsHttp200() throws Exception {
        authenticate("john_doe", 1L);

        UserResponse userResponse = UserResponse.builder()
                .id(1L)
                .username("john_doe")
                .email("john@example.com")
                .displayName("John Doe")
                .build();

        when(userService.getMyInfo("john_doe")).thenReturn(userResponse);

        mockMvc.perform(get("/users/me"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.username").value("john_doe"));
    }

    @Test
    @DisplayName("GET /users/me/balance: Lấy số dư ví thành công trả về HTTP 200")
    void getMyBalance_Success_ReturnsHttp200() throws Exception {
        authenticate("john_doe", 1L);

        UserBalanceResponse balanceResponse = UserBalanceResponse.builder()
                .balance(new BigDecimal("500000"))
                .build();

        when(userService.getBalance("john_doe")).thenReturn(balanceResponse);

        mockMvc.perform(get("/users/me/balance"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.balance").value(500000));
    }

    @Test
    @DisplayName("PUT /users/me/password: Đổi mật khẩu thành công xóa cookie và trả về HTTP 200")
    void changePassword_Success_ReturnsHttp200AndClearsCookies() throws Exception {
        authenticate("john_doe", 1L);

        ChangePasswordRequest request = ChangePasswordRequest.builder()
                .oldPassword("OldPass@123")
                .newPassword("NewPass@123")
                .confirmNewPassword("NewPass@123")
                .build();

        mockMvc.perform(put("/users/me/password")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(header().exists("Set-Cookie"))
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Password changed successfully. Please login again."));

        verify(userService).changePassword(eq("john_doe"), any(ChangePasswordRequest.class));
    }

    @Test
    @DisplayName("PATCH /users/me: Cập nhật thông tin cá nhân thành công trả về HTTP 200")
    void updateProfile_Success_ReturnsHttp200() throws Exception {
        authenticate("john_doe", 1L);

        UserResponse userResponse = UserResponse.builder()
                .id(1L)
                .username("john_doe")
                .displayName("Updated Name")
                .build();

        when(userService.updateProfile(eq("john_doe"), any())).thenReturn(userResponse);

        mockMvc.perform(multipart("/users/me")
                        .with(request -> {
                            request.setMethod("PATCH");
                            return request;
                        })
                        .param("displayName", "Updated Name"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.displayName").value("Updated Name"));
    }

    @Test
    @DisplayName("GET /users/me/progress/courses: Lấy tiến độ học tập thành công trả về HTTP 200")
    void getCourseProgress_Success_ReturnsHttp200() throws Exception {
        authenticate("john_doe", 1L);

        CourseProgressResponse progress = CourseProgressResponse.builder()
                .courseId(10L)
                .title("Java Core")
                .totalLessons(20)
                .completedLessons(10)
                .completionPercentage(50)
                .build();

        when(progressService.getCourseProgress(1L)).thenReturn(List.of(progress));

        mockMvc.perform(get("/users/me/progress/courses"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result[0].completionPercentage").value(50));
    }
}
