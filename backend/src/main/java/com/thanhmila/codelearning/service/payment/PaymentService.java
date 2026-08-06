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

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.reactive.function.client.WebClient;

import vn.payos.PayOS;
import vn.payos.type.Webhook;
import vn.payos.type.WebhookData;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PaymentService {

    PayOS payOS;
    ProjectProperties.Payos payosProps;
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

        // 4. Create link with PayOS SDK
        try {
            long expiredAt = (System.currentTimeMillis() / 1000) + (15 * 60); // 15 phút từ bây giờ

            // Manual call to bypass SDK ObjectMapper bug with new fields (expiredAt)
            Map<String, Object> body = new HashMap<>();
            body.put("orderCode", orderCode);
            body.put("amount", request.getAmount().intValue());
            body.put("description", "Thanh toan nap Xu");
            body.put("returnUrl", payosProps.getReturnUrl());
            body.put("cancelUrl", payosProps.getCancelUrl());
            body.put("expiredAt", expiredAt);
            
            // Create signature (PayOS v2 có thể KHÔNG nhận expiredAt vào signature đối với SDK version cũ)
            String signData = "amount=" + body.get("amount") +
                              "&cancelUrl=" + body.get("cancelUrl") +
                              "&description=" + body.get("description") +
                              "&orderCode=" + body.get("orderCode") +
                              "&returnUrl=" + body.get("returnUrl");
            String signature = generateHmacSHA256(signData, payosProps.getChecksumKey());
            body.put("signature", signature);

            // Create WebClient
            WebClient webClient = WebClient.builder()
                    .baseUrl("https://api-merchant.payos.vn/v2/payment-requests")
                    .defaultHeader("x-client-id", payosProps.getClientId())
                    .defaultHeader("x-api-key", payosProps.getApiKey())
                    .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                    .build();

            // Execute POST request synchronously
            JsonNode responseNode = webClient.post()
                    .bodyValue(body)
                    .retrieve()
                    .bodyToMono(JsonNode.class)
                    .block(); // Block since the outer method is synchronous

            if (responseNode == null) {
                log.error("PayOS response is null");
                throw new AppException(ErrorCode.UNCATEGORIZED_EXCEPTION);
            }

            String code = responseNode.has("code") ? responseNode.get("code").asText() : "";
            if (!"00".equals(code)) {
                String desc = responseNode.has("desc") ? responseNode.get("desc").asText() : "Unknown error";
                log.error("PayOS API error: code={}, description={}", code, desc);
                throw new RuntimeException("PayOS error " + code + ": " + desc);
            }

            JsonNode dataNode = responseNode.get("data");
            if (dataNode == null || dataNode.isNull() || !dataNode.has("checkoutUrl")) {
                log.error("PayOS response data or checkoutUrl is missing. Response: {}", responseNode);
                throw new AppException(ErrorCode.UNCATEGORIZED_EXCEPTION);
            }
            
            String checkoutUrl = dataNode.get("checkoutUrl").asText();

            return PaymentDepositResponse.builder()
                    .checkoutUrl(checkoutUrl)
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

    private String generateHmacSHA256(String data, String key) {
        try {
            javax.crypto.Mac sha256_HMAC = javax.crypto.Mac.getInstance("HmacSHA256");
            javax.crypto.spec.SecretKeySpec secret_key = new javax.crypto.spec.SecretKeySpec(key.getBytes(java.nio.charset.StandardCharsets.UTF_8), "HmacSHA256");
            sha256_HMAC.init(secret_key);
            byte[] hash = sha256_HMAC.doFinal(data.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException("Failed to calculate hmac-sha256", e);
        }
    }
}
