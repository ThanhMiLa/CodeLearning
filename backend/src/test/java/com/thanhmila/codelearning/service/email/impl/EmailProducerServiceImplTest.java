package com.thanhmila.codelearning.service.email.impl;

import com.thanhmila.codelearning.configuration.RabbitMQConfig;
import com.thanhmila.codelearning.dto.email.BulkEmailMessage;
import com.thanhmila.codelearning.dto.request.EmailCampaignRequest;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.amqp.rabbit.core.RabbitTemplate;

import java.util.ArrayList;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("EmailProducerServiceImpl Unit Tests")
class EmailProducerServiceImplTest {

    @Mock
    private RabbitTemplate rabbitTemplate;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private EmailProducerServiceImpl emailProducerService;

    @Test
    @DisplayName("processAndSendCampaign: Target ALL chia đúng các batch 500 emails vào RabbitMQ")
    void processAndSendCampaign_TargetAll_SplitsBatchesProperly() {
        List<UserEntity> users = new ArrayList<>();
        for (int i = 1; i <= 1050; i++) {
            users.add(UserEntity.builder()
                    .id((long) i)
                    .email("user" + i + "@example.com")
                    .displayName("User " + i)
                    .isEmailValid(true)
                    .build());
        }

        when(userRepository.findByIsEmailValidTrue()).thenReturn(users);

        EmailCampaignRequest request = new EmailCampaignRequest();
        request.setTargetType("ALL");
        request.setTemplateId("d-template-123");

        emailProducerService.processAndSendCampaign(request);

        // 1050 users / 500 batch size = 3 batches (500, 500, 50)
        verify(rabbitTemplate, times(3)).convertAndSend(
                eq(RabbitMQConfig.EMAIL_EXCHANGE),
                eq(RabbitMQConfig.ROUTING_KEY_BULK_EMAIL),
                any(BulkEmailMessage.class)
        );
    }

    @Test
    @DisplayName("processAndSendCampaign: Target SPECIFIC với userIds null không gửi message")
    void processAndSendCampaign_TargetSpecific_NullUserIds_DoesNothing() {
        EmailCampaignRequest request = new EmailCampaignRequest();
        request.setTargetType("SPECIFIC");
        request.setUserIds(null);

        emailProducerService.processAndSendCampaign(request);

        verifyNoInteractions(userRepository);
        verifyNoInteractions(rabbitTemplate);
    }

    @Test
    @DisplayName("processAndSendCampaign: Target SPECIFIC với ID không hợp lệ không crash")
    void processAndSendCampaign_TargetSpecific_InvalidIds_HandlesGracefully() {
        EmailCampaignRequest request = new EmailCampaignRequest();
        request.setTargetType("SPECIFIC");
        request.setUserIds(List.of("abc", "xyz"));

        emailProducerService.processAndSendCampaign(request);

        verifyNoInteractions(userRepository);
        verifyNoInteractions(rabbitTemplate);
    }

    @Test
    @DisplayName("processAndSendCampaign: Target SPECIFIC với ID hợp lệ gửi message thành công")
    void processAndSendCampaign_TargetSpecific_ValidIds_SendsMessage() {
        UserEntity user = UserEntity.builder()
                .id(1L)
                .username("john_doe")
                .email("john@example.com")
                .isEmailValid(true)
                .build();

        when(userRepository.findAllById(List.of(1L))).thenReturn(List.of(user));

        EmailCampaignRequest request = new EmailCampaignRequest();
        request.setTargetType("SPECIFIC");
        request.setUserIds(List.of("1"));
        request.setTemplateId("d-template-xyz");

        emailProducerService.processAndSendCampaign(request);

        verify(rabbitTemplate, times(1)).convertAndSend(
                eq(RabbitMQConfig.EMAIL_EXCHANGE),
                eq(RabbitMQConfig.ROUTING_KEY_BULK_EMAIL),
                any(BulkEmailMessage.class)
        );
    }

    @Test
    @DisplayName("processAndSendCampaign: Target type không xác định không làm gì")
    void processAndSendCampaign_UnknownTargetType_DoesNothing() {
        EmailCampaignRequest request = new EmailCampaignRequest();
        request.setTargetType("UNKNOWN_TYPE");

        emailProducerService.processAndSendCampaign(request);

        verifyNoInteractions(userRepository);
        verifyNoInteractions(rabbitTemplate);
    }
}
