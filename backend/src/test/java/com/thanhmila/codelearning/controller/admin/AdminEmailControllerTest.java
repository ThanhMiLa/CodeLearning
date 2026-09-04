package com.thanhmila.codelearning.controller.admin;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.dto.request.EmailCampaignRequest;
import com.thanhmila.codelearning.security.UserRateLimitInterceptor;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import com.thanhmila.codelearning.service.email.EmailProducerService;
import com.thanhmila.codelearning.service.email.SendGridApiService;
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

import java.util.List;
import java.util.Map;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(AdminEmailController.class)
@AutoConfigureMockMvc(addFilters = false)
@ActiveProfiles("test")
@DisplayName("AdminEmailController WebMvc Tests")
class AdminEmailControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockitoBean
    private EmailProducerService emailProducerService;

    @MockitoBean
    private SendGridApiService sendGridApiService;

    @MockitoBean
    private UserRateLimitInterceptor userRateLimitInterceptor;

    @MockitoBean
    private RateLimitService rateLimitService;

    @BeforeEach
    void setUp() throws Exception {
        when(userRateLimitInterceptor.preHandle(any(), any(), any())).thenReturn(true);
    }

    @Test
    @DisplayName("GET /admin/emails/templates: Trả về danh sách templates từ SendGrid")
    void getSendGridTemplates_Returns200() throws Exception {
        when(sendGridApiService.getTemplates()).thenReturn(Map.of("templates", List.of()));

        mockMvc.perform(get("/admin/emails/templates"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Get SendGrid templates successfully"));
    }

    @Test
    @DisplayName("POST /admin/emails/send: Đẩy campaign hợp lệ vào queue thành công")
    void sendEmailCampaign_ValidRequest_Returns200() throws Exception {
        EmailCampaignRequest request = EmailCampaignRequest.builder()
                .templateId("d-template-123")
                .targetType("ALL")
                .build();

        mockMvc.perform(post("/admin/emails/send")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Push email campaign request successfully"));

        verify(emailProducerService).processAndSendCampaign(any(EmailCampaignRequest.class));
    }

    @Test
    @DisplayName("POST /admin/emails/send: Request không hợp lệ trả về 400 Bad Request")
    void sendEmailCampaign_InvalidRequest_Returns400() throws Exception {
        EmailCampaignRequest request = new EmailCampaignRequest(); // thiếu templateId và targetType

        mockMvc.perform(post("/admin/emails/send")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isBadRequest());
    }
}
