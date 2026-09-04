package com.thanhmila.codelearning.service.email.impl;

import com.thanhmila.codelearning.dto.email.SendGridWebhookEvent;
import com.thanhmila.codelearning.entity.email.EmailDeliveryLogEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.repository.email.EmailDeliveryLogRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("SendGridWebhookServiceImpl Unit Tests")
class SendGridWebhookServiceImplTest {

    @Mock
    private EmailDeliveryLogRepository logRepository;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private SendGridWebhookServiceImpl sendGridWebhookService;

    @Test
    @DisplayName("processWebhookEvents: Given delivered event, saves log and leaves user untouched")
    void processWebhookEvents_DeliveredEvent_SavesLogOnly() {
        SendGridWebhookEvent event = SendGridWebhookEvent.builder()
                .email("student@example.com")
                .event("delivered")
                .sg_event_id("sg-123")
                .sg_message_id("msg-456")
                .timestamp(1700000000L)
                .build();

        sendGridWebhookService.processWebhookEvents(List.of(event));

        verify(logRepository, times(1)).save(any(EmailDeliveryLogEntity.class));
        verify(userRepository, never()).findByEmail(anyString());
        verify(userRepository, never()).save(any(UserEntity.class));
    }

    @Test
    @DisplayName("processWebhookEvents: Given bounce event and user found, invalidates user email")
    void processWebhookEvents_BounceEvent_UserFound_InvalidatesEmail() {
        SendGridWebhookEvent event = SendGridWebhookEvent.builder()
                .email("bounced@example.com")
                .event("bounce")
                .reason("550 Mailbox not found")
                .sg_event_id("sg-789")
                .sg_message_id("msg-012")
                .timestamp(1700000000L)
                .build();

        UserEntity user = UserEntity.builder()
                .id(1L)
                .email("bounced@example.com")
                .isEmailValid(true)
                .build();

        when(userRepository.findByEmail("bounced@example.com")).thenReturn(Optional.of(user));

        sendGridWebhookService.processWebhookEvents(List.of(event));

        verify(logRepository, times(1)).save(any(EmailDeliveryLogEntity.class));

        ArgumentCaptor<UserEntity> userCaptor = ArgumentCaptor.forClass(UserEntity.class);
        verify(userRepository).save(userCaptor.capture());
        assertThat(userCaptor.getValue().getIsEmailValid()).isFalse();
    }

    @Test
    @DisplayName("processWebhookEvents: Given spamreport event but user not found, saves log without error")
    void processWebhookEvents_SpamReportEvent_UserNotFound_SavesLogOnly() {
        SendGridWebhookEvent event = SendGridWebhookEvent.builder()
                .email("unknown@example.com")
                .event("spamreport")
                .build();

        when(userRepository.findByEmail("unknown@example.com")).thenReturn(Optional.empty());

        sendGridWebhookService.processWebhookEvents(List.of(event));

        verify(logRepository, times(1)).save(any(EmailDeliveryLogEntity.class));
        verify(userRepository, never()).save(any(UserEntity.class));
    }
}
