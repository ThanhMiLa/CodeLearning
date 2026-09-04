package com.thanhmila.codelearning.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Spy;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;

import java.time.Instant;
import java.util.List;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("UserRateLimitInterceptor Unit Tests")
class UserRateLimitInterceptorTest {

    @Mock
    private RateLimitService rateLimitService;

    @Spy
    private ObjectMapper objectMapper = new ObjectMapper();

    @InjectMocks
    private UserRateLimitInterceptor interceptor;

    @AfterEach
    void tearDown() {
        SecurityContextHolder.clearContext();
    }

    @Test
    @DisplayName("preHandle: Authentication null -> Cho phép request đi tiếp")
    void preHandle_NullAuthentication_ReturnsTrue() throws Exception {
        SecurityContextHolder.clearContext();
        MockHttpServletRequest request = new MockHttpServletRequest();
        MockHttpServletResponse response = new MockHttpServletResponse();

        boolean allowed = interceptor.preHandle(request, response, new Object());

        assertThat(allowed).isTrue();
        verifyNoInteractions(rateLimitService);
    }

    @Test
    @DisplayName("preHandle: Anonymous user -> Cho phép request đi tiếp")
    void preHandle_AnonymousUser_ReturnsTrue() throws Exception {
        AnonymousAuthenticationToken auth = new AnonymousAuthenticationToken(
                "key", "anonymousUser", List.of(new SimpleGrantedAuthority("ROLE_ANONYMOUS")));
        SecurityContextHolder.getContext().setAuthentication(auth);

        MockHttpServletRequest request = new MockHttpServletRequest();
        MockHttpServletResponse response = new MockHttpServletResponse();

        boolean allowed = interceptor.preHandle(request, response, new Object());

        assertThat(allowed).isTrue();
        verifyNoInteractions(rateLimitService);
    }

    @Test
    @DisplayName("preHandle: User đã xác thực và còn token -> Trả về true")
    void preHandle_AuthenticatedUser_Allowed_ReturnsTrue() throws Exception {
        Jwt jwt = new Jwt("mock-token", Instant.now(), Instant.now().plusSeconds(3600),
                Map.of("alg", "HS512"), Map.of("userId", 42L));
        JwtAuthenticationToken auth = new JwtAuthenticationToken(jwt, List.of(new SimpleGrantedAuthority("ROLE_USER")));
        SecurityContextHolder.getContext().setAuthentication(auth);

        MockHttpServletRequest request = new MockHttpServletRequest();
        MockHttpServletResponse response = new MockHttpServletResponse();

        when(rateLimitService.tryConsumeUser("42")).thenReturn(true);

        boolean allowed = interceptor.preHandle(request, response, new Object());

        assertThat(allowed).isTrue();
        verify(rateLimitService).tryConsumeUser("42");
    }

    @Test
    @DisplayName("preHandle: User đã xác thực nhưng vượt quá giới hạn -> Trả về false và HTTP 429")
    void preHandle_AuthenticatedUser_RateLimited_ReturnsFalse() throws Exception {
        Jwt jwt = new Jwt("mock-token", Instant.now(), Instant.now().plusSeconds(3600),
                Map.of("alg", "HS512"), Map.of("userId", 99L));
        JwtAuthenticationToken auth = new JwtAuthenticationToken(jwt, List.of(new SimpleGrantedAuthority("ROLE_USER")));
        SecurityContextHolder.getContext().setAuthentication(auth);

        MockHttpServletRequest request = new MockHttpServletRequest();
        MockHttpServletResponse response = new MockHttpServletResponse();

        when(rateLimitService.tryConsumeUser("99")).thenReturn(false);

        boolean allowed = interceptor.preHandle(request, response, new Object());

        assertThat(allowed).isFalse();
        assertThat(response.getStatus()).isEqualTo(429);
        assertThat(response.getContentAsString()).contains("\"code\":1007");
    }
}
