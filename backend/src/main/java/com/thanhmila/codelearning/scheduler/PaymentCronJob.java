package com.thanhmila.codelearning.scheduler;

import com.fasterxml.jackson.databind.JsonNode;
import com.thanhmila.codelearning.configuration.ProjectProperties;
import com.thanhmila.codelearning.entity.enums.TransactionStatus;
import com.thanhmila.codelearning.entity.payment.PaymentTransactionEntity;
import com.thanhmila.codelearning.repository.payment.PaymentTransactionRepository;
import com.thanhmila.codelearning.service.payment.PaymentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;

import java.math.BigDecimal;
import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class PaymentCronJob {

    private final PaymentTransactionRepository paymentTransactionRepository;
    private final ProjectProperties.Payos payosProps;
    private final PaymentService paymentService;

    @Scheduled(fixedDelay = 300000) 
    public void scanPendingTransactions() {
        log.info("CronJob: Đang quét các đơn hàng PENDING...");
        
        List<PaymentTransactionEntity> pendingTransactions = paymentTransactionRepository.findByStatus(TransactionStatus.PENDING);

        if (pendingTransactions.isEmpty()) {
            return;
        }

        WebClient webClient = WebClient.builder()
                .baseUrl("https://api-merchant.payos.vn/v2/payment-requests")
                .defaultHeader("x-client-id", payosProps.getClientId())
                .defaultHeader("x-api-key", payosProps.getApiKey())
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .build();

        for (PaymentTransactionEntity tx : pendingTransactions) {
            try {
                JsonNode responseNode = webClient.get()
                        .uri("/" + tx.getTransactionCode())
                        .retrieve()
                        .bodyToMono(JsonNode.class)
                        .block();

                if (responseNode != null && "00".equals(responseNode.path("code").asText())) {
                    JsonNode data = responseNode.path("data");
                    String payosStatus = data.path("status").asText();

                    if ("PAID".equals(payosStatus) || "SUCCESS".equals(payosStatus)) {
                        log.warn("CronJob phát hiện giao dịch PAID từ PayOS (lỡ Webhook): {}", tx.getTransactionCode());
                        BigDecimal actualAmount = new BigDecimal(data.path("amount").asText());
                        paymentService.processSuccessfulPaymentFallback(tx.getTransactionCode(), actualAmount);
                        
                    } else if ("CANCELLED".equals(payosStatus) || "EXPIRED".equals(payosStatus)) {
                        log.info("CronJob phát hiện giao dịch đã hết hạn/bị hủy: {}", tx.getTransactionCode());
                        tx.setStatus(TransactionStatus.CANCELLED);
                        paymentTransactionRepository.save(tx);
                    } else if ("PENDING".equals(payosStatus)) {
                        if (tx.getCreatedAt() != null && tx.getCreatedAt().isBefore(java.time.OffsetDateTime.now().minusMinutes(30))) {
                            log.info("CronJob ép hủy giao dịch cũ bị treo PENDING quá 30 phút: {}", tx.getTransactionCode());
                            tx.setStatus(TransactionStatus.CANCELLED);
                            paymentTransactionRepository.save(tx);
                        }
                    }
                }
            } catch (Exception e) {
                log.error("Lỗi khi đồng bộ giao dịch {} với PayOS: {}", tx.getTransactionCode(), e.getMessage());
                if (tx.getCreatedAt() != null && tx.getCreatedAt().isBefore(java.time.OffsetDateTime.now().minusMinutes(30))) {
                    log.info("CronJob ép hủy giao dịch cũ (do PayOS báo lỗi/không tìm thấy): {}", tx.getTransactionCode());
                    tx.setStatus(TransactionStatus.CANCELLED);
                    paymentTransactionRepository.save(tx);
                }
            }
        }
    }
}
