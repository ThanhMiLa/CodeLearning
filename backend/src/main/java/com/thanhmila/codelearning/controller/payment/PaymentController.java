package com.thanhmila.codelearning.controller.payment;

import com.fasterxml.jackson.databind.node.ObjectNode;
import com.thanhmila.codelearning.dto.request.PaymentDepositRequest;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.PaymentDepositResponse;
import com.thanhmila.codelearning.service.payment.PaymentService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.web.bind.annotation.*;

import lombok.experimental.NonFinal;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;

import java.time.Instant;

@Slf4j
@RestController
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PaymentController {

    PaymentService paymentService;

    @NonFinal
    @Value("${app.webhook-secret}")
    String webhookSecret;

    @PostMapping("/payment/deposit")
    public ResponseEntity<ApiResponse<PaymentDepositResponse>> createDeposit(
            @AuthenticationPrincipal Jwt jwt,
            @Valid @RequestBody PaymentDepositRequest request) {
        
        Long userId = jwt.getClaim("userId");
        PaymentDepositResponse response = paymentService.createDepositPayment(userId, request);

        return ResponseEntity.ok(ApiResponse.<PaymentDepositResponse>builder()
                .status(200)
                .code(1000)
                .message("Payment link created successfully")
                .result(response)
                .timestamp(Instant.now().toString())
                .build());
    }

    @PostMapping("/payment/webhook")
    public ResponseEntity<ApiResponse<Void>> handleWebhook(
            @RequestParam(value = "secret", required = false) String secret,
            @RequestBody ObjectNode payload) {
        log.info("Received PayOS Webhook");

        if (secret == null || !secret.equals(webhookSecret)) {
            log.warn("🚨 CẢNH BÁO BẢO MẬT: Webhook PayOS không có Secret hợp lệ!");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ApiResponse.<Void>builder()
                    .status(401)
                    .code(1000)
                    .message("Invalid webhook secret")
                    .result(null)
                    .timestamp(Instant.now().toString())
                    .build());
        }

        try {
            paymentService.handlePayOSWebhook(payload);
        } catch (Exception e) {
            log.error("PayOS Webhook Processing Error (Continuing to return 200 OK to PayOS): ", e);
        }
        
        // Return 200 OK to PayOS even if something failed inside, or PayOS will keep retrying
        return ResponseEntity.ok(ApiResponse.<Void>builder()
                .status(200)
                .code(1000)
                .message("PayOS webhook processed successfully")
                .result(null)
                .timestamp(Instant.now().toString())
                .build());
    }
}
