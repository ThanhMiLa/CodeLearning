package com.thanhmila.codelearning.service.email.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.dto.email.BulkEmailMessage;
import com.thanhmila.codelearning.dto.email.SendGridEmailRequest;
import com.thanhmila.codelearning.entity.email.FailedEmailQueueEntity;
import com.thanhmila.codelearning.repository.email.FailedEmailQueueRepository;
import com.thanhmila.codelearning.service.email.SendGridApiService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.util.ReflectionTestUtils;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("EmailConsumerServiceImpl Unit Tests")
class EmailConsumerServiceImplTest {

    @Mock
    private SendGridApiService sendGridApiService;

    @Mock
    private FailedEmailQueueRepository failedEmailQueueRepository;

    @Mock
    private ObjectMapper objectMapper;

    @InjectMocks
    private EmailConsumerServiceImpl emailConsumerService;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(emailConsumerService, "fromEmail", "noreply@codelearning.com");
        ReflectionTestUtils.setField(emailConsumerService, "fromName", "CodeLearning Platform");
    }

    @Test
    @DisplayName("consumeBulkEmail: Gửi email thành công qua SendGrid")
    void consumeBulkEmail_Success_CallsSendGrid() {
        BulkEmailMessage.UserEmailInfo user = new BulkEmailMessage.UserEmailInfo("student@example.com", "Student One");
        BulkEmailMessage message = BulkEmailMessage.builder()
                .batchId("BATCH-12345")
                .templateId("d-template-1")
                .users(List.of(user))
                .build();

        emailConsumerService.consumeBulkEmail(message);

        ArgumentCaptor<SendGridEmailRequest> captor = ArgumentCaptor.forClass(SendGridEmailRequest.class);
        verify(sendGridApiService).sendEmailBulk(captor.capture());

        SendGridEmailRequest sentRequest = captor.getValue();
        assertThat(sentRequest.getTemplate_id()).isEqualTo("d-template-1");
        assertThat(sentRequest.getFrom().getEmail()).isEqualTo("noreply@codelearning.com");
        assertThat(sentRequest.getPersonalizations()).hasSize(1);
        verifyNoInteractions(failedEmailQueueRepository);
    }

    @Test
    @DisplayName("consumeBulkEmail: Lỗi khi gọi SendGrid lưu vào bảng DLQ với status PENDING_RETRY")
    void consumeBulkEmail_SendGridFails_PushesToDlq() throws Exception {
        BulkEmailMessage.UserEmailInfo user = new BulkEmailMessage.UserEmailInfo("student@example.com", "Student One");
        BulkEmailMessage message = BulkEmailMessage.builder()
                .batchId("BATCH-FAILED")
                .templateId("d-template-1")
                .users(List.of(user))
                .build();

        doThrow(new RuntimeException("SendGrid API Rate Limit")).when(sendGridApiService).sendEmailBulk(any());
        when(objectMapper.writeValueAsString(message)).thenReturn("{\"batchId\":\"BATCH-FAILED\"}");

        emailConsumerService.consumeBulkEmail(message);

        ArgumentCaptor<FailedEmailQueueEntity> captor = ArgumentCaptor.forClass(FailedEmailQueueEntity.class);
        verify(failedEmailQueueRepository).save(captor.capture());

        FailedEmailQueueEntity savedEntity = captor.getValue();
        assertThat(savedEntity.getBatchId()).isEqualTo("BATCH-FAILED");
        assertThat(savedEntity.getStatus()).isEqualTo("PENDING_RETRY");
        assertThat(savedEntity.getErrorReason()).contains("SendGrid API Rate Limit");
    }

    @Test
    @DisplayName("consumeBulkEmail: Lỗi parse JSON khi lưu DLQ không làm crash ứng dụng")
    void consumeBulkEmail_JsonParsingFails_HandlesGracefully() throws Exception {
        BulkEmailMessage message = BulkEmailMessage.builder()
                .batchId("BATCH-JSON-FAIL")
                .templateId("d-template-1")
                .users(List.of())
                .build();

        doThrow(new RuntimeException("Network timeout")).when(sendGridApiService).sendEmailBulk(any());
        when(objectMapper.writeValueAsString(any())).thenThrow(new JsonProcessingException("Cannot serialize") {});

        emailConsumerService.consumeBulkEmail(message);

        verify(failedEmailQueueRepository, never()).save(any());
    }
}
