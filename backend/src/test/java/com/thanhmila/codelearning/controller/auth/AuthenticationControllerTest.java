package com.thanhmila.codelearning.controller.auth;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.dto.request.AuthenticationRequest;
import com.thanhmila.codelearning.dto.request.GoogleLoginRequest;
import com.thanhmila.codelearning.dto.request.RegisterRequest;
import com.thanhmila.codelearning.dto.response.AuthenticationResponse;
import com.thanhmila.codelearning.service.auth.AuthenticationService;
import jakarta.servlet.http.Cookie;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Set;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(AuthenticationController.class)
@AutoConfigureMockMvc(addFilters = false)
@ActiveProfiles("test")
@DisplayName("AuthenticationController WebMvc Slice Tests")
class AuthenticationControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockitoBean
    private AuthenticationService authenticationService;

    @MockitoBean
    private com.thanhmila.codelearning.service.auth.RateLimitService rateLimitService;

    @MockitoBean
    private com.thanhmila.codelearning.security.UserRateLimitInterceptor userRateLimitInterceptor;

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
                .id(1L)
                .displayName("Test User")
                .roles(Set.of("USER"))
                .build();

        when(authenticationService.login(any(AuthenticationRequest.class))).thenReturn(response);

        mockMvc.perform(post("/auth/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(header().exists("Set-Cookie"))
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.status").value(200))
                .andExpect(jsonPath("$.message").value("Login successfully"));
    }

    @Test
    @DisplayName("POST /auth/google: Đăng nhập Google thành công trả về HTTP 200")
    void googleLogin_Success_ReturnsHttp200() throws Exception {
        GoogleLoginRequest request = GoogleLoginRequest.builder()
                .token("mock-google-id-token")
                .build();

        AuthenticationResponse response = AuthenticationResponse.builder()
                .accessToken("mock-access-token")
                .refreshToken("mock-refresh-token")
                .id(1L)
                .displayName("Google User")
                .roles(Set.of("USER"))
                .build();

        when(authenticationService.googleLogin(any(GoogleLoginRequest.class))).thenReturn(response);

        mockMvc.perform(post("/auth/google")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(header().exists("Set-Cookie"))
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.status").value(200));
    }

    @Test
    @DisplayName("POST /auth/register: Đăng ký thành công trả về HTTP 200")
    void register_Success_ReturnsHttp200() throws Exception {
        RegisterRequest request = RegisterRequest.builder()
                .displayName("New User")
                .username("newuser")
                .email("newuser@example.com")
                .password("Password@123")
                .confirmPassword("Password@123")
                .build();

        AuthenticationResponse response = AuthenticationResponse.builder()
                .accessToken("mock-access-token")
                .refreshToken("mock-refresh-token")
                .id(2L)
                .displayName("New User")
                .roles(Set.of("USER"))
                .build();

        when(authenticationService.register(any(RegisterRequest.class))).thenReturn(response);

        mockMvc.perform(post("/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(header().exists("Set-Cookie"))
                .andExpect(jsonPath("$.code").value(1000));
    }

    @Test
    @DisplayName("POST /auth/register: Dữ liệu không hợp lệ trả về HTTP 400 Bad Request")
    void register_InvalidData_ReturnsHttp400() throws Exception {
        RegisterRequest invalidRequest = RegisterRequest.builder()
                .displayName("")
                .username("usr") // < 4 chars
                .email("invalid-email")
                .password("123")
                .confirmPassword("123")
                .build();

        mockMvc.perform(post("/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(invalidRequest)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.status").value(400));
    }

    @Test
    @DisplayName("POST /auth/logout: Đăng xuất thành công trả về HTTP 200 và xóa Cookie")
    void logout_Success_ReturnsHttp200AndClearsCookies() throws Exception {
        mockMvc.perform(post("/auth/logout")
                        .cookie(new Cookie("access_token", "sample-access"))
                        .cookie(new Cookie("refresh_token", "sample-refresh")))
                .andExpect(status().isOk())
                .andExpect(header().exists("Set-Cookie"))
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Logout successfully"));

        verify(authenticationService).logout("sample-access", "sample-refresh");
    }

    @Test
    @DisplayName("POST /auth/refresh: Làm mới token thành công trả về HTTP 200")
    void refresh_Success_ReturnsHttp200() throws Exception {
        AuthenticationResponse response = AuthenticationResponse.builder()
                .accessToken("new-access-token")
                .refreshToken("new-refresh-token")
                .id(1L)
                .build();

        when(authenticationService.refresh("sample-refresh")).thenReturn(response);

        mockMvc.perform(post("/auth/refresh")
                        .cookie(new Cookie("refresh_token", "sample-refresh")))
                .andExpect(status().isOk())
                .andExpect(header().exists("Set-Cookie"))
                .andExpect(jsonPath("$.code").value(1000));
    }
}
