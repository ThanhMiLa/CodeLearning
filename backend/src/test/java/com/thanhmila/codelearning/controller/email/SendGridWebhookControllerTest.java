package com.thanhmila.codelearning.controller.email;

import com.thanhmila.codelearning.security.UserRateLimitInterceptor;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import com.thanhmila.codelearning.service.email.SendGridWebhookService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(SendGridWebhookController.class)
@AutoConfigureMockMvc(addFilters = false)
@ActiveProfiles("test")
@DisplayName("SendGridWebhookController WebMvc Tests")
class SendGridWebhookControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private SendGridWebhookService webhookService;

    @MockitoBean
    private UserRateLimitInterceptor userRateLimitInterceptor;

    @MockitoBean
    private RateLimitService rateLimitService;

    @BeforeEach
    void setUp() throws Exception {
        when(userRateLimitInterceptor.preHandle(any(), any(), any())).thenReturn(true);
    }

    @Test
    @DisplayName("POST /api/webhooks/sendgrid: Thiếu chữ ký trả về 401 Unauthorized")
    void handleWebhook_MissingSignature_Returns401() throws Exception {
        mockMvc.perform(post("/api/webhooks/sendgrid")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("[]"))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.status").value(401))
                .andExpect(jsonPath("$.code").value(1001));

        verify(webhookService, never()).processWebhookEvents(any());
    }

    @Test
    @DisplayName("POST /api/webhooks/sendgrid: Chữ ký hợp lệ, xử lý sự kiện thành công trả về 200 OK")
    void handleWebhook_ValidSignature_Returns200() throws Exception {
        String payload = "[{\"email\":\"user@example.com\",\"event\":\"delivered\",\"timestamp\":1700000000}]";

        mockMvc.perform(post("/api/webhooks/sendgrid")
                        .header("X-Twilio-Email-Event-Webhook-Signature", "sig123")
                        .header("X-Twilio-Email-Event-Webhook-Timestamp", "ts123")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(payload))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value(200))
                .andExpect(jsonPath("$.code").value(1000));

        verify(webhookService).processWebhookEvents(anyList());
    }

    @Test
    @DisplayName("POST /api/webhooks/sendgrid: JSON payload lỗi vẫn trả về 200 OK để SendGrid không retry")
    void handleWebhook_MalformedJson_StillReturns200() throws Exception {
        mockMvc.perform(post("/api/webhooks/sendgrid")
                        .header("X-Twilio-Email-Event-Webhook-Signature", "sig123")
                        .header("X-Twilio-Email-Event-Webhook-Timestamp", "ts123")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{malformed-json"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value(200));

        verify(webhookService, never()).processWebhookEvents(any());
    }
}
