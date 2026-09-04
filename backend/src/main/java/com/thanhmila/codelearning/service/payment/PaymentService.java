package com.thanhmila.codelearning.service.payment;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.thanhmila.codelearning.configuration.ProjectProperties;
import com.thanhmila.codelearning.dto.request.PaymentDepositRequest;
import com.thanhmila.codelearning.dto.response.PaymentDepositResponse;
import com.thanhmila.codelearning.entity.enums.PaymentTransactionType;
import com.thanhmila.codelearning.entity.enums.TransactionStatus;
import com.thanhmila.codelearning.entity.enums.WalletTransactionType;
import com.thanhmila.codelearning.entity.payment.PaymentTransactionEntity;
import com.thanhmila.codelearning.entity.payment.WalletEntity;
import com.thanhmila.codelearning.entity.payment.WalletTransactionEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.payment.PaymentTransactionRepository;
import com.thanhmila.codelearning.repository.payment.WalletRepository;
import com.thanhmila.codelearning.repository.payment.WalletTransactionRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import com.thanhmila.codelearning.service.payment.client.PayOsClient;
import com.thanhmila.codelearning.service.payment.client.PayOsCreatePaymentRequest;
import com.thanhmila.codelearning.service.payment.client.PayOsCreatePaymentResponse;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import vn.payos.PayOS;
import vn.payos.type.Webhook;
import vn.payos.type.WebhookData;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PaymentService {

    PayOS payOS;
    PayOsClient payOsClient;
    WalletRepository walletRepository;
    PaymentTransactionRepository paymentTransactionRepository;
    WalletTransactionRepository walletTransactionRepository;
    UserRepository userRepository;

    @Transactional
    public PaymentDepositResponse createDepositPayment(Long userId, PaymentDepositRequest request) {

        // 0. Fetch user
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        user.validateStatus();

        // 1. Get Wallet
        WalletEntity wallet = walletRepository.findByUserId(userId)
                .orElseThrow(() -> new AppException(ErrorCode.RESOURCE_NOT_FOUND));

        // 2. Generate a unique transaction code (using current time ms for simplicity, PayOS requires integer orderCode)
        long orderCode = System.currentTimeMillis();
        String transactionCode = String.valueOf(orderCode);

        // 3. Save pending transaction
        PaymentTransactionEntity transaction = PaymentTransactionEntity.builder()
                .wallet(wallet)
                .transactionCode(transactionCode)
                .amount(request.getAmount())
                .type(PaymentTransactionType.DEPOSIT)
                .status(TransactionStatus.PENDING)
                .note("Nạp xu vào ví")
                .build();
        paymentTransactionRepository.save(transaction);

        // 4. Create link with PayOS Client
        // Technical Debt Note: External network call is executed within @Transactional boundary
        try {
            long expiredAt = (System.currentTimeMillis() / 1000) + (15 * 60); // 15 phút từ bây giờ

            PayOsCreatePaymentRequest payOsRequest = PayOsCreatePaymentRequest.builder()
                    .orderCode(orderCode)
                    .amount(request.getAmount().intValue())
                    .description("Thanh toan nap Xu")
                    .expiredAt(expiredAt)
                    .build();

            PayOsCreatePaymentResponse payOsResponse = payOsClient.createPaymentLink(payOsRequest);

            if (payOsResponse == null || payOsResponse.getCheckoutUrl() == null) {
                log.error("PayOS response or checkoutUrl is missing");
                throw new AppException(ErrorCode.UNCATEGORIZED_EXCEPTION);
            }

            return PaymentDepositResponse.builder()
                    .checkoutUrl(payOsResponse.getCheckoutUrl())
                    .transactionCode(transactionCode)
                    .build();

        } catch (Exception e) {
            log.error("PayOS Error: ", e);
            throw new AppException(ErrorCode.UNCATEGORIZED_EXCEPTION);
        }
    }

    @Transactional
    public void handlePayOSWebhook(ObjectNode payload) {
        try {
            // 1. Parse string to Webhook type
            ObjectMapper objectMapper = new ObjectMapper();
            Webhook webhookBody = objectMapper.treeToValue(payload, Webhook.class);
            
            // 2. Verify signature (Throws exception if invalid)
            WebhookData data = payOS.verifyPaymentWebhookData(webhookBody);

            if (!"00".equals(data.getCode())) {
                log.info("Webhook received but not a success code: {}", data.getCode());
                return;
            }

            // 3. Process the successful payment
            String transactionCode = String.valueOf(data.getOrderCode());
            PaymentTransactionEntity paymentTx = paymentTransactionRepository.findByTransactionCode(transactionCode)
                    .orElseThrow(() -> {
                        log.warn("Webhook received for unknown transaction: {}", transactionCode);
                        return new AppException(ErrorCode.RESOURCE_NOT_FOUND);
                    });

            // Idempotency check: if not PENDING, we already processed it
            if (paymentTx.getStatus() == TransactionStatus.SUCCESS || paymentTx.getStatus() == TransactionStatus.LATE_SUCCESS) {
                log.info("Transaction {} already processed. Status: {}", transactionCode, paymentTx.getStatus());
                return;
            }

            // 4. Lock Wallet and Process
            WalletEntity wallet = walletRepository.findByUserIdWithLock(paymentTx.getWallet().getUser().getId())
                    .orElseThrow(() -> new AppException(ErrorCode.RESOURCE_NOT_FOUND));

            TransactionStatus newStatus = TransactionStatus.SUCCESS;
            if (paymentTx.getStatus() == TransactionStatus.CANCELLED || paymentTx.getStatus() == TransactionStatus.FAILED) {
                newStatus = TransactionStatus.LATE_SUCCESS;
                log.warn("LATE PAYMENT DETECTED: Nhận được tiền cho đơn hàng đã Hủy: {}", transactionCode);
            }

            BigDecimal actualAmount = new BigDecimal(data.getAmount());

            // Update Payment Transaction
            paymentTx.setStatus(newStatus);
            paymentTx.setAmount(actualAmount);
            paymentTransactionRepository.save(paymentTx);

            // Create Wallet Ledger Transaction
            WalletTransactionEntity walletTx = WalletTransactionEntity.builder()
                    .wallet(wallet)
                    .amount(actualAmount)
                    .type(WalletTransactionType.DEPOSIT)
                    .status(TransactionStatus.SUCCESS)
                    .referenceId(paymentTx.getId())
                    .note("Nạp tiền thật qua PayOS (Late Payment = " + (newStatus == TransactionStatus.LATE_SUCCESS) + ")")
                    .build();
            walletTransactionRepository.save(walletTx);

            // Add balance
            wallet.setBalance(wallet.getBalance().add(actualAmount));
            walletRepository.save(wallet);

            log.info("Successfully processed deposit for transaction: {}", transactionCode);

        } catch (Exception e) {
            log.error("Error processing PayOS Webhook", e);
            throw new AppException(ErrorCode.UNCATEGORIZED_EXCEPTION);
        }
    }

    @Transactional
    public void processSuccessfulPaymentFallback(String transactionCode, BigDecimal actualAmount) {
        PaymentTransactionEntity paymentTx = paymentTransactionRepository.findByTransactionCode(transactionCode)
                .orElseThrow(() -> new AppException(ErrorCode.RESOURCE_NOT_FOUND));

        if (paymentTx.getStatus() == TransactionStatus.SUCCESS || paymentTx.getStatus() == TransactionStatus.LATE_SUCCESS) {
            return;
        }

        WalletEntity wallet = walletRepository.findByUserIdWithLock(paymentTx.getWallet().getUser().getId())
                .orElseThrow(() -> new AppException(ErrorCode.RESOURCE_NOT_FOUND));

        TransactionStatus newStatus = TransactionStatus.SUCCESS;
        if (paymentTx.getStatus() == TransactionStatus.CANCELLED || paymentTx.getStatus() == TransactionStatus.FAILED) {
            newStatus = TransactionStatus.LATE_SUCCESS;
            log.warn("LATE PAYMENT DETECTED (CronJob Fallback): Nhận được tiền cho đơn hàng đã Hủy: {}", transactionCode);
        }

        paymentTx.setStatus(newStatus);
        paymentTx.setAmount(actualAmount);
        paymentTransactionRepository.save(paymentTx);

        WalletTransactionEntity walletTx = WalletTransactionEntity.builder()
                .wallet(wallet)
                .amount(actualAmount)
                .type(WalletTransactionType.DEPOSIT)
                .status(TransactionStatus.SUCCESS)
                .referenceId(paymentTx.getId())
                .note("Nạp tiền thật qua PayOS (Phục hồi từ CronJob - Late: " + (newStatus == TransactionStatus.LATE_SUCCESS) + ")")
                .build();
        walletTransactionRepository.save(walletTx);

        wallet.setBalance(wallet.getBalance().add(actualAmount));
        walletRepository.save(wallet);

        log.info("Successfully processed deposit from CronJob Fallback for transaction: {}", transactionCode);
    }
}
