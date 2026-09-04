package com.thanhmila.codelearning.scheduler;

import com.thanhmila.codelearning.entity.enums.TransactionStatus;
import com.thanhmila.codelearning.entity.payment.PaymentTransactionEntity;
import com.thanhmila.codelearning.repository.payment.PaymentTransactionRepository;
import com.thanhmila.codelearning.service.payment.PaymentService;
import com.thanhmila.codelearning.service.payment.client.PayOsClient;
import com.thanhmila.codelearning.service.payment.client.PayOsErrorType;
import com.thanhmila.codelearning.service.payment.client.PayOsException;
import com.thanhmila.codelearning.service.payment.client.PayOsPaymentInfo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.time.Clock;
import java.time.OffsetDateTime;
import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class PaymentCronJob {

    private final PaymentTransactionRepository paymentTransactionRepository;
    private final PaymentService paymentService;
    private final PayOsClient payOsClient;
    private final Clock clock;

    @Scheduled(fixedDelay = 300000)
    public void scanPendingTransactions() {
        log.info("CronJob: Đang quét các đơn hàng PENDING...");

        List<PaymentTransactionEntity> pendingTransactions = paymentTransactionRepository.findByStatus(TransactionStatus.PENDING);

        if (pendingTransactions.isEmpty()) {
            return;
        }

        OffsetDateTime now = OffsetDateTime.now(clock);

        for (PaymentTransactionEntity tx : pendingTransactions) {
            try {
                PayOsPaymentInfo paymentInfo = payOsClient.getPaymentInformation(tx.getTransactionCode());
                String payosStatus = paymentInfo != null ? paymentInfo.getStatus() : null;

                if ("PAID".equals(payosStatus) || "SUCCESS".equals(payosStatus)) {
                    BigDecimal paidAmount = paymentInfo.getAmountPaid() != null ? paymentInfo.getAmountPaid() : paymentInfo.getAmount();

                    if (paidAmount == null || paidAmount.compareTo(BigDecimal.ZERO) <= 0
                            || (tx.getAmount() != null && paidAmount.compareTo(tx.getAmount()) != 0)) {
                        log.error("CẢNH BÁO BẢO MẬT: Giao dịch {} PAID nhưng amountPaid ({}) không khớp tx.amount ({}). Bỏ qua không cộng ví!",
                                tx.getTransactionCode(), paidAmount, tx.getAmount());
                    } else {
                        log.warn("CronJob phát hiện giao dịch PAID từ PayOS (lỡ Webhook): {}", tx.getTransactionCode());
                        paymentService.processSuccessfulPaymentFallback(tx.getTransactionCode(), paidAmount);
                    }

                } else if ("CANCELLED".equals(payosStatus) || "EXPIRED".equals(payosStatus)) {
                    log.info("CronJob phát hiện giao dịch đã hết hạn/bị hủy: {}", tx.getTransactionCode());
                    tx.setStatus(TransactionStatus.CANCELLED);
                    paymentTransactionRepository.save(tx);

                } else if ("PENDING".equals(payosStatus) || "PROCESSING".equals(payosStatus)) {
                    if (tx.getCreatedAt() != null && tx.getCreatedAt().isBefore(now.minusMinutes(30))) {
                        log.info("CronJob hủy giao dịch cũ bị treo quá 30 phút: {}", tx.getTransactionCode());
                        try {
                            payOsClient.cancelPaymentLink(tx.getTransactionCode(), "Giao dịch quá 30 phút không hoàn tất");
                        } catch (Exception cancelEx) {
                            log.warn("Không thể gọi cancel PayOS cho {}: {}", tx.getTransactionCode(), cancelEx.getMessage());
                        }
                        tx.setStatus(TransactionStatus.CANCELLED);
                        paymentTransactionRepository.save(tx);
                    }
                }
            } catch (PayOsException e) {
                if (e.getErrorType() == PayOsErrorType.NOT_FOUND) {
                    if (tx.getCreatedAt() != null && tx.getCreatedAt().isBefore(now.minusMinutes(30))) {
                        log.info("CronJob ép hủy giao dịch cũ (do PayOS báo lỗi/không tìm thấy): {}", tx.getTransactionCode());
                        tx.setStatus(TransactionStatus.CANCELLED);
                        paymentTransactionRepository.save(tx);
                    }
                } else if (e.getErrorType() == PayOsErrorType.TRANSIENT || e.getErrorType() == PayOsErrorType.RATE_LIMITED) {
                    log.warn("Lỗi kết nối mạng tạm thời ({}) khi đồng bộ giao dịch {} với PayOS, giữ PENDING để retry vòng sau: {}",
                            e.getErrorType(), tx.getTransactionCode(), e.getMessage());
                } else {
                    log.error("Lỗi PayOS ({}) khi đồng bộ giao dịch {}: {}", e.getErrorType(), tx.getTransactionCode(), e.getMessage());
                }
            } catch (Exception e) {
                log.error("Lỗi không xác định khi đồng bộ giao dịch {}: {}", tx.getTransactionCode(), e.getMessage());
            }
        }
    }
}
