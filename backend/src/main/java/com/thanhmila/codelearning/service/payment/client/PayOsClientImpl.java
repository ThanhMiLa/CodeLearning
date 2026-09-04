package com.thanhmila.codelearning.service.payment.client;

import com.thanhmila.codelearning.configuration.ProjectProperties;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClientRequestException;
import org.springframework.web.reactive.function.client.WebClientResponseException;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Component
public class PayOsClientImpl implements PayOsClient {

    private final WebClient payosWebClient;
    private final ProjectProperties.Payos payosProps;

    public PayOsClientImpl(@Qualifier("payosWebClient") WebClient payosWebClient,
                           ProjectProperties.Payos payosProps) {
        this.payosWebClient = payosWebClient;
        this.payosProps = payosProps;
    }

    @Override
    public PayOsCreatePaymentResponse createPaymentLink(PayOsCreatePaymentRequest request) {
        try {
            Map<String, Object> body = new HashMap<>();
            body.put("orderCode", request.getOrderCode());
            body.put("amount", request.getAmount());
            body.put("description", request.getDescription());
            body.put("returnUrl", payosProps.getReturnUrl());
            body.put("cancelUrl", payosProps.getCancelUrl());
            if (request.getExpiredAt() != null) {
                body.put("expiredAt", request.getExpiredAt());
            }

            String signData = "amount=" + request.getAmount() +
                    "&cancelUrl=" + payosProps.getCancelUrl() +
                    "&description=" + request.getDescription() +
                    "&orderCode=" + request.getOrderCode() +
                    "&returnUrl=" + payosProps.getReturnUrl();

            String signature = generateHmacSHA256(signData, payosProps.getChecksumKey());
            body.put("signature", signature);

            PayOsApiResponse<PayOsCreatePaymentResponse> response = payosWebClient.post()
                    .uri(uriBuilder -> uriBuilder.path("/v2/payment-requests").build())
                    .contentType(MediaType.APPLICATION_JSON)
                    .bodyValue(body)
                    .retrieve()
                    .bodyToMono(new ParameterizedTypeReference<PayOsApiResponse<PayOsCreatePaymentResponse>>() {})
                    .block();

            return extractDataOrThrow(response);

        } catch (WebClientResponseException e) {
            log.error("PayOS HTTP Error while creating payment link: status={}, body={}", e.getStatusCode(), e.getResponseBodyAsString());
            throw mapWebClientResponseException(e);
        } catch (WebClientRequestException e) {
            log.error("PayOS Network Error while creating payment link: {}", e.getMessage());
            throw new PayOsException(PayOsErrorType.TRANSIENT, "NETWORK_ERROR", e.getMessage(), e);
        } catch (org.springframework.core.codec.CodecException e) {
            log.error("PayOS JSON decoding error while creating payment link: {}", e.getMessage());
            throw new PayOsException(PayOsErrorType.INVALID_RESPONSE, "INVALID_JSON", e.getMessage(), e);
        } catch (PayOsException e) {
            throw e;
        } catch (Exception e) {
            log.error("Unexpected error calling PayOS createPaymentLink: {}", e.getMessage());
            throw new PayOsException(PayOsErrorType.TRANSIENT, "UNKNOWN", e.getMessage(), e);
        }
    }

    @Override
    public PayOsPaymentInfo getPaymentInformation(String transactionCode) {
        try {
            PayOsApiResponse<PayOsPaymentInfo> response = payosWebClient.get()
                    .uri(uriBuilder -> uriBuilder.path("/v2/payment-requests/{id}").build(transactionCode))
                    .retrieve()
                    .bodyToMono(new ParameterizedTypeReference<PayOsApiResponse<PayOsPaymentInfo>>() {})
                    .block();

            return extractDataOrThrow(response);

        } catch (WebClientResponseException e) {
            log.error("PayOS HTTP Error while fetching payment info for {}: status={}", transactionCode, e.getStatusCode());
            throw mapWebClientResponseException(e);
        } catch (WebClientRequestException e) {
            log.error("PayOS Network Error while fetching payment info for {}: {}", transactionCode, e.getMessage());
            throw new PayOsException(PayOsErrorType.TRANSIENT, "NETWORK_ERROR", e.getMessage(), e);
        } catch (org.springframework.core.codec.CodecException e) {
            log.error("PayOS JSON decoding error while fetching payment info for {}: {}", transactionCode, e.getMessage());
            throw new PayOsException(PayOsErrorType.INVALID_RESPONSE, "INVALID_JSON", e.getMessage(), e);
        } catch (PayOsException e) {
            throw e;
        } catch (Exception e) {
            log.error("Unexpected error calling PayOS getPaymentInformation for {}: {}", transactionCode, e.getMessage());
            throw new PayOsException(PayOsErrorType.TRANSIENT, "UNKNOWN", e.getMessage(), e);
        }
    }

    @Override
    public PayOsPaymentInfo cancelPaymentLink(String transactionCode, String cancellationReason) {
        try {
            Map<String, String> body = new HashMap<>();
            if (cancellationReason != null) {
                body.put("cancellationReason", cancellationReason);
            }

            PayOsApiResponse<PayOsPaymentInfo> response = payosWebClient.post()
                    .uri(uriBuilder -> uriBuilder.path("/v2/payment-requests/{id}/cancel").build(transactionCode))
                    .contentType(MediaType.APPLICATION_JSON)
                    .bodyValue(body)
                    .retrieve()
                    .bodyToMono(new ParameterizedTypeReference<PayOsApiResponse<PayOsPaymentInfo>>() {})
                    .block();

            return extractDataOrThrow(response);

        } catch (WebClientResponseException e) {
            log.error("PayOS HTTP Error while cancelling payment link for {}: status={}", transactionCode, e.getStatusCode());
            throw mapWebClientResponseException(e);
        } catch (WebClientRequestException e) {
            log.error("PayOS Network Error while cancelling payment link for {}: {}", transactionCode, e.getMessage());
            throw new PayOsException(PayOsErrorType.TRANSIENT, "NETWORK_ERROR", e.getMessage(), e);
        } catch (org.springframework.core.codec.CodecException e) {
            log.error("PayOS JSON decoding error while cancelling payment link for {}: {}", transactionCode, e.getMessage());
            throw new PayOsException(PayOsErrorType.INVALID_RESPONSE, "INVALID_JSON", e.getMessage(), e);
        } catch (PayOsException e) {
            throw e;
        } catch (Exception e) {
            log.error("Unexpected error calling PayOS cancelPaymentLink for {}: {}", transactionCode, e.getMessage());
            throw new PayOsException(PayOsErrorType.TRANSIENT, "UNKNOWN", e.getMessage(), e);
        }
    }

    private <T> T extractDataOrThrow(PayOsApiResponse<T> response) {
        if (response == null) {
            throw new PayOsException(PayOsErrorType.INVALID_RESPONSE, "PayOS response is null");
        }

        String code = response.getCode();
        if (!"00".equals(code)) {
            String desc = response.getDesc() != null ? response.getDesc() : "Unknown error";
            if ("20".equals(code) || "404".equals(code) || desc.toLowerCase().contains("not found")) {
                throw new PayOsException(PayOsErrorType.NOT_FOUND, code, desc);
            }
            throw new PayOsException(PayOsErrorType.BUSINESS, code, desc);
        }

        if (response.getData() == null) {
            throw new PayOsException(PayOsErrorType.INVALID_RESPONSE, code, "PayOS response data is null");
        }

        return response.getData();
    }

    private PayOsException mapWebClientResponseException(WebClientResponseException e) {
        int status = e.getStatusCode().value();
        if (status == 404) {
            return new PayOsException(PayOsErrorType.NOT_FOUND, "404", e.getMessage(), e);
        } else if (status == 401 || status == 403) {
            return new PayOsException(PayOsErrorType.AUTHENTICATION, String.valueOf(status), e.getMessage(), e);
        } else if (status == 429) {
            return new PayOsException(PayOsErrorType.RATE_LIMITED, "429", e.getMessage(), e);
        } else if (e.getStatusCode().is5xxServerError()) {
            return new PayOsException(PayOsErrorType.TRANSIENT, String.valueOf(status), e.getMessage(), e);
        }
        return new PayOsException(PayOsErrorType.BUSINESS, String.valueOf(status), e.getMessage(), e);
    }

    public String generateHmacSHA256(String data, String key) {
        try {
            Mac sha256HMAC = Mac.getInstance("HmacSHA256");
            SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
            sha256HMAC.init(secretKey);
            byte[] hash = sha256HMAC.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new PayOsException(PayOsErrorType.BUSINESS, "HMAC_ERROR", "Error calculating HMAC SHA256", e);
        }
    }
}
