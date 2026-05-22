package com.thanhmila.codelearning.service.payment;

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
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.payment.PaymentTransactionRepository;
import com.thanhmila.codelearning.repository.payment.WalletRepository;
import com.thanhmila.codelearning.repository.payment.WalletTransactionRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.payos.PayOS;
import vn.payos.type.CheckoutResponseData;
import vn.payos.type.PaymentData;
import vn.payos.type.Webhook;
import vn.payos.type.WebhookData;

import java.math.BigDecimal;
import java.util.Date;

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

    @Transactional
    public PaymentDepositResponse createDepositPayment(Long userId, PaymentDepositRequest request) {
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
            // Manual call to bypass SDK ObjectMapper bug with new fields (expiredAt)
            java.util.Map<String, Object> body = new java.util.HashMap<>();
            body.put("orderCode", orderCode);
            body.put("amount", request.getAmount().intValue());
            body.put("description", "Thanh toan nap Xu");
            body.put("returnUrl", payosProps.getReturnUrl());
            body.put("cancelUrl", payosProps.getCancelUrl());
            
            // Create signature
            String signData = "amount=" + body.get("amount") +
                              "&cancelUrl=" + body.get("cancelUrl") +
                              "&description=" + body.get("description") +
                              "&orderCode=" + body.get("orderCode") +
                              "&returnUrl=" + body.get("returnUrl");
            String signature = generateHmacSHA256(signData, payosProps.getChecksumKey());
            body.put("signature", signature);

            // Create WebClient
            org.springframework.web.reactive.function.client.WebClient webClient = org.springframework.web.reactive.function.client.WebClient.builder()
                    .baseUrl("https://api-merchant.payos.vn/v2/payment-requests")
                    .defaultHeader("x-client-id", payosProps.getClientId())
                    .defaultHeader("x-api-key", payosProps.getApiKey())
                    .defaultHeader(org.springframework.http.HttpHeaders.CONTENT_TYPE, org.springframework.http.MediaType.APPLICATION_JSON_VALUE)
                    .build();

            // Execute POST request synchronously
            com.fasterxml.jackson.databind.JsonNode responseNode = webClient.post()
                    .bodyValue(body)
                    .retrieve()
                    .bodyToMono(com.fasterxml.jackson.databind.JsonNode.class)
                    .block(); // Block since the outer method is synchronous

            if (responseNode == null || !responseNode.has("data")) {
                throw new AppException(ErrorCode.UNCATEGORIZED_EXCEPTION);
            }
            
            String checkoutUrl = responseNode.get("data").get("checkoutUrl").asText();

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
            if (paymentTx.getStatus() != TransactionStatus.PENDING) {
                log.info("Transaction {} already processed. Status: {}", transactionCode, paymentTx.getStatus());
                return;
            }

            // 4. Lock Wallet and Process
            WalletEntity wallet = walletRepository.findByUserIdWithLock(paymentTx.getWallet().getUser().getId())
                    .orElseThrow(() -> new AppException(ErrorCode.RESOURCE_NOT_FOUND));

            // Update Payment Transaction
            paymentTx.setStatus(TransactionStatus.SUCCESS);
            paymentTransactionRepository.save(paymentTx);

            // Create Wallet Ledger Transaction
            WalletTransactionEntity walletTx = WalletTransactionEntity.builder()
                    .wallet(wallet)
                    .amount(paymentTx.getAmount())
                    .type(WalletTransactionType.DEPOSIT)
                    .status(TransactionStatus.SUCCESS)
                    .referenceId(paymentTx.getId())
                    .note("Nạp tiền thật qua PayOS")
                    .build();
            walletTransactionRepository.save(walletTx);

            // Add balance
            wallet.setBalance(wallet.getBalance().add(paymentTx.getAmount()));
            walletRepository.save(wallet);

            log.info("Successfully processed deposit for transaction: {}", transactionCode);

        } catch (Exception e) {
            log.error("Error processing PayOS Webhook", e);
            throw new AppException(ErrorCode.UNCATEGORIZED_EXCEPTION);
        }
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
