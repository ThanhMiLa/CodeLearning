package com.thanhmila.codelearning.controller.payment;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.thanhmila.codelearning.dto.request.PaymentDepositRequest;
import com.thanhmila.codelearning.dto.response.PaymentDepositResponse;
import com.thanhmila.codelearning.security.UserRateLimitInterceptor;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import com.thanhmila.codelearning.service.payment.PaymentService;
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
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(PaymentController.class)
@AutoConfigureMockMvc(addFilters = false)
@ActiveProfiles("test")
@Import(PaymentControllerTest.TestConfig.class)
@DisplayName("PaymentController WebMvc Slice Tests")
class PaymentControllerTest {

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
    private PaymentService paymentService;

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
                new JwtAuthenticationToken(jwt, List.of(new SimpleGrantedAuthority("USER")), username)
        );
    }

    @Test
    @DisplayName("POST /payment/deposit: Tạo link nạp tiền thành công trả về HTTP 200")
    void createDeposit_Success_ReturnsHttp200() throws Exception {
        authenticate("user1", 10L);

        PaymentDepositRequest request = PaymentDepositRequest.builder()
                .amount(new BigDecimal("100000"))
                .build();

        PaymentDepositResponse response = PaymentDepositResponse.builder()
                .checkoutUrl("https://pay.payos.vn/web/test")
                .transactionCode("TX123456")
                .build();

        when(paymentService.createDepositPayment(eq(10L), any(PaymentDepositRequest.class))).thenReturn(response);

        mockMvc.perform(post("/payment/deposit")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.checkoutUrl").value("https://pay.payos.vn/web/test"))
                .andExpect(jsonPath("$.result.transactionCode").value("TX123456"));
    }

    @Test
    @DisplayName("POST /payment/webhook: Sai secret trả về HTTP 401 Unauthorized")
    void handleWebhook_InvalidSecret_ReturnsHttp401() throws Exception {
        ObjectNode payload = objectMapper.createObjectNode();

        mockMvc.perform(post("/payment/webhook")
                        .param("secret", "invalid-secret")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(payload.toString()))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.message").value("Invalid webhook secret"));
    }

    @Test
    @DisplayName("POST /payment/webhook: Secret hợp lệ xử lý thành công trả về HTTP 200")
    void handleWebhook_ValidSecret_ReturnsHttp200() throws Exception {
        ObjectNode payload = objectMapper.createObjectNode();

        mockMvc.perform(post("/payment/webhook")
                        .param("secret", "test_secret_12345")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(payload.toString()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("PayOS webhook processed successfully"));

        verify(paymentService).handlePayOSWebhook(any(ObjectNode.class));
    }

    @Test
    @DisplayName("POST /payment/webhook: Service ném ngoại lệ vẫn trả về HTTP 200 cho PayOS")
    void handleWebhook_ServiceThrowsException_StillReturnsHttp200() throws Exception {
        ObjectNode payload = objectMapper.createObjectNode();
        doThrow(new RuntimeException("Simulated service error")).when(paymentService).handlePayOSWebhook(any());

        mockMvc.perform(post("/payment/webhook")
                        .param("secret", "test_secret_12345")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(payload.toString()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("PayOS webhook processed successfully"));
    }
}
