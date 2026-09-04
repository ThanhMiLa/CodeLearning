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
import static org.mockito.ArgumentMatchers.any;
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
    @DisplayName("doFilterInternal: IP còn token khả dụng -> Cho phép request đi tiếp qua FilterChain")
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
    @DisplayName("doFilterInternal: IP hết token -> Trả về HTTP 429 và chặn không cho request đi tiếp")
    void doFilterInternal_Blocked_ReturnsHttp429() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setRemoteAddr("192.168.1.200");
        MockHttpServletResponse response = new MockHttpServletResponse();

        when(rateLimitService.tryConsumeIp("192.168.1.200")).thenReturn(false);

        ipRateLimitFilter.doFilterInternal(request, response, filterChain);

        verify(filterChain, never()).doFilter(any(), any());
        assertThat(response.getStatus()).isEqualTo(429);
        assertThat(response.getContentAsString()).contains("\"code\":1007");
        assertThat(response.getContentAsString()).contains("maximum number of requests allowed");
    }

    @Test
    @DisplayName("doFilterInternal: Có header X-Forwarded-For hợp lệ -> Trích xuất IP đầu tiên trong danh sách")
    void doFilterInternal_WithXForwardedFor_ExtractsFirstIp() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setRemoteAddr("10.0.0.1");
        request.addHeader("X-Forwarded-For", "203.0.113.195, 10.0.0.1");
        MockHttpServletResponse response = new MockHttpServletResponse();

        when(rateLimitService.tryConsumeIp("203.0.113.195")).thenReturn(true);

        ipRateLimitFilter.doFilterInternal(request, response, filterChain);

        verify(rateLimitService).tryConsumeIp("203.0.113.195");
        verify(filterChain).doFilter(request, response);
    }
}
