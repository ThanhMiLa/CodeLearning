package com.thanhmila.codelearning.service.email.impl;

import com.thanhmila.codelearning.configuration.RabbitMQConfig;
import com.thanhmila.codelearning.dto.email.BulkEmailMessage;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.repository.user.UserRepository;
import com.thanhmila.codelearning.service.email.EmailProducerService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class EmailProducerServiceImpl implements EmailProducerService {
    RabbitTemplate rabbitTemplate;
    UserRepository userRepository;
    
    @Override
    public void processAndSendBulkEmail(String templateId) {
        List<UserEntity> validUsers = userRepository.findByIsEmailValidTrue();
        
        List<BulkEmailMessage.UserEmailInfo> userInfos = validUsers.stream()
                .map(u -> new BulkEmailMessage.UserEmailInfo(u.getEmail(), u.getDisplayName() != null ? u.getDisplayName() : u.getUsername()))
                .collect(Collectors.toList());

        // SendGrid limit is 1000 emails/request. Cut 500 emails per batch for safety.
        int batchSize = 500; 
        
        for (int i = 0; i < userInfos.size(); i += batchSize) {
            List<BulkEmailMessage.UserEmailInfo> batch = userInfos.subList(i, Math.min(i + batchSize, userInfos.size()));
            
            BulkEmailMessage message = BulkEmailMessage.builder()
                    .batchId("BATCH-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase())
                    .templateId(templateId)
                    .users(batch)
                    .build();

            rabbitTemplate.convertAndSend(
                RabbitMQConfig.EMAIL_EXCHANGE, 
                RabbitMQConfig.ROUTING_KEY_BULK_EMAIL, 
                message
            );
        }
    }
}
