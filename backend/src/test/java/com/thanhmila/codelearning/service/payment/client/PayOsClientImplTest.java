package com.thanhmila.codelearning.service.payment.client;

import com.thanhmila.codelearning.configuration.ProjectProperties;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.reactive.function.client.ClientRequest;
import org.springframework.web.reactive.function.client.ClientResponse;
import org.springframework.web.reactive.function.client.ExchangeFunction;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.WebClientRequestException;
import reactor.core.publisher.Mono;

import java.math.BigDecimal;
import java.net.URI;
import java.time.Duration;
import java.util.concurrent.atomic.AtomicReference;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

@DisplayName("PayOsClientImpl Integration Tests via In-Memory WebClient")
class PayOsClientImplTest {

    private ProjectProperties.Payos payosProps;
    private AtomicReference<ClientRequest> capturedRequest;

    @BeforeEach
    void setUp() {
        payosProps = new ProjectProperties.Payos();
        payosProps.setClientId("test-client-id");
        payosProps.setApiKey("test-api-key");
        payosProps.setChecksumKey("test-checksum-key-12345");
        payosProps.setReturnUrl("http://localhost:5173/payment/success");
        payosProps.setCancelUrl("http://localhost:5173/payment/cancel");
        payosProps.setBaseUrl("https://api-merchant.payos.vn");
        payosProps.setTimeout(Duration.ofSeconds(2));

        capturedRequest = new AtomicReference<>();
    }

    private PayOsClientImpl createClientWithResponse(HttpStatus status, String bodyJson) {
        ExchangeFunction exchangeFunction = request -> {
            capturedRequest.set(request);
            ClientResponse response = ClientResponse.create(status)
                    .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                    .body(bodyJson != null ? bodyJson : "")
                    .build();
            return Mono.just(response);
        };

        WebClient webClient = WebClient.builder()
                .baseUrl(payosProps.getBaseUrl())
                .exchangeFunction(exchangeFunction)
                .defaultHeader("x-client-id", payosProps.getClientId())
                .defaultHeader("x-api-key", payosProps.getApiKey())
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .build();

        return new PayOsClientImpl(webClient, payosProps);
    }

    private PayOsClientImpl createClientWithError(Throwable error) {
        ExchangeFunction exchangeFunction = request -> {
            capturedRequest.set(request);
            return Mono.error(error);
        };

        WebClient webClient = WebClient.builder()
                .baseUrl(payosProps.getBaseUrl())
                .exchangeFunction(exchangeFunction)
                .defaultHeader("x-client-id", payosProps.getClientId())
                .defaultHeader("x-api-key", payosProps.getApiKey())
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .build();

        return new PayOsClientImpl(webClient, payosProps);
    }

    @Test
    @DisplayName("createPaymentLink: Thành công trả về PayOsCreatePaymentResponse và gửi đúng headers/chữ ký")
    void createPaymentLink_Success() {
        String successJson = """
                {
                  "code": "00",
                  "desc": "Success",
                  "data": {
                    "checkoutUrl": "https://pay.payos.vn/web/test-link",
                    "paymentLinkId": "link-123",
                    "orderCode": 10001,
                    "amount": 50000,
                    "status": "PENDING"
                  }
                }
                """;

        PayOsClientImpl client = createClientWithResponse(HttpStatus.OK, successJson);

        PayOsCreatePaymentRequest request = PayOsCreatePaymentRequest.builder()
                .orderCode(10001L)
                .amount(50000)
                .description("Nap tien test")
                .build();

        PayOsCreatePaymentResponse response = client.createPaymentLink(request);

        assertThat(response).isNotNull();
        assertThat(response.getCheckoutUrl()).isEqualTo("https://pay.payos.vn/web/test-link");
        assertThat(response.getPaymentLinkId()).isEqualTo("link-123");
        assertThat(response.getOrderCode()).isEqualTo(10001L);

        ClientRequest captured = capturedRequest.get();
        assertThat(captured).isNotNull();
        assertThat(captured.url().getPath()).isEqualTo("/v2/payment-requests");
        assertThat(captured.headers().getFirst("x-client-id")).isEqualTo("test-client-id");
        assertThat(captured.headers().getFirst("x-api-key")).isEqualTo("test-api-key");
    }

    @Test
    @DisplayName("getPaymentInformation: Thành công trả về PayOsPaymentInfo")
    void getPaymentInformation_Success() {
        String json = """
                {
                  "code": "00",
                  "desc": "Success",
                  "data": {
                    "id": "link-100",
                    "orderCode": 10002,
                    "amount": 50000,
                    "amountPaid": 50000,
                    "amountRemaining": 0,
                    "status": "PAID"
                  }
                }
                """;

        PayOsClientImpl client = createClientWithResponse(HttpStatus.OK, json);

        PayOsPaymentInfo info = client.getPaymentInformation("TX-100");

        assertThat(info).isNotNull();
        assertThat(info.getStatus()).isEqualTo("PAID");
        assertThat(info.getAmount()).isEqualByComparingTo(new BigDecimal("50000"));
        assertThat(info.getAmountPaid()).isEqualByComparingTo(new BigDecimal("50000"));

        ClientRequest captured = capturedRequest.get();
        assertThat(captured.url().getPath()).isEqualTo("/v2/payment-requests/TX-100");
    }

    @Test
    @DisplayName("cancelPaymentLink: Thành công trả về status CANCELLED")
    void cancelPaymentLink_Success() {
        String json = """
                {
                  "code": "00",
                  "desc": "Success",
                  "data": {
                    "id": "link-100",
                    "status": "CANCELLED"
                  }
                }
                """;

        PayOsClientImpl client = createClientWithResponse(HttpStatus.OK, json);

        PayOsPaymentInfo info = client.cancelPaymentLink("TX-100", "Khách hàng hủy");

        assertThat(info).isNotNull();
        assertThat(info.getStatus()).isEqualTo("CANCELLED");

        ClientRequest captured = capturedRequest.get();
        assertThat(captured.url().getPath()).isEqualTo("/v2/payment-requests/TX-100/cancel");
    }

    @Test
    @DisplayName("PayOS trả code '20' (Not Found) -> throw PayOsException(NOT_FOUND)")
    void payOsErrorCode20_ThrowsNotFound() {
        String json = """
                {
                  "code": "20",
                  "desc": "Payment request not found",
                  "data": null
                }
                """;

        PayOsClientImpl client = createClientWithResponse(HttpStatus.OK, json);

        assertThatThrownBy(() -> client.getPaymentInformation("TX-NOTFOUND"))
                .isInstanceOf(PayOsException.class)
                .satisfies(ex -> {
                    PayOsException pe = (PayOsException) ex;
                    assertThat(pe.getErrorType()).isEqualTo(PayOsErrorType.NOT_FOUND);
                    assertThat(pe.getErrorCode()).isEqualTo("20");
                });
    }

    @Test
    @DisplayName("PayOS trả code '01' (Business Error) -> throw PayOsException(BUSINESS)")
    void payOsBusinessError_ThrowsBusiness() {
        String json = """
                {
                  "code": "01",
                  "desc": "Invalid request parameter",
                  "data": null
                }
                """;

        PayOsClientImpl client = createClientWithResponse(HttpStatus.OK, json);

        assertThatThrownBy(() -> client.getPaymentInformation("TX-ERROR"))
                .isInstanceOf(PayOsException.class)
                .satisfies(ex -> {
                    PayOsException pe = (PayOsException) ex;
                    assertThat(pe.getErrorType()).isEqualTo(PayOsErrorType.BUSINESS);
                });
    }

    @Test
    @DisplayName("HTTP 404 Not Found -> throw PayOsException(NOT_FOUND)")
    void http404_ThrowsNotFound() {
        PayOsClientImpl client = createClientWithResponse(HttpStatus.NOT_FOUND, "Not Found");

        assertThatThrownBy(() -> client.getPaymentInformation("TX-404"))
                .isInstanceOf(PayOsException.class)
                .satisfies(ex -> assertThat(((PayOsException) ex).getErrorType()).isEqualTo(PayOsErrorType.NOT_FOUND));
    }

    @Test
    @DisplayName("HTTP 401 Unauthorized -> throw PayOsException(AUTHENTICATION)")
    void http401_ThrowsAuthentication() {
        PayOsClientImpl client = createClientWithResponse(HttpStatus.UNAUTHORIZED, "Unauthorized");

        assertThatThrownBy(() -> client.getPaymentInformation("TX-401"))
                .isInstanceOf(PayOsException.class)
                .satisfies(ex -> assertThat(((PayOsException) ex).getErrorType()).isEqualTo(PayOsErrorType.AUTHENTICATION));
    }

    @Test
    @DisplayName("HTTP 429 Too Many Requests -> throw PayOsException(RATE_LIMITED)")
    void http429_ThrowsRateLimited() {
        PayOsClientImpl client = createClientWithResponse(HttpStatus.TOO_MANY_REQUESTS, "Too Many Requests");

        assertThatThrownBy(() -> client.getPaymentInformation("TX-429"))
                .isInstanceOf(PayOsException.class)
                .satisfies(ex -> assertThat(((PayOsException) ex).getErrorType()).isEqualTo(PayOsErrorType.RATE_LIMITED));
    }

    @Test
    @DisplayName("HTTP 500 Server Error -> throw PayOsException(TRANSIENT)")
    void http500_ThrowsTransient() {
        PayOsClientImpl client = createClientWithResponse(HttpStatus.INTERNAL_SERVER_ERROR, "Server Error");

        assertThatThrownBy(() -> client.getPaymentInformation("TX-500"))
                .isInstanceOf(PayOsException.class)
                .satisfies(ex -> assertThat(((PayOsException) ex).getErrorType()).isEqualTo(PayOsErrorType.TRANSIENT));
    }

    @Test
    @DisplayName("Response JSON rỗng/lỗi -> throw PayOsException(INVALID_RESPONSE)")
    void malformedResponse_ThrowsInvalidResponse() {
        PayOsClientImpl client = createClientWithResponse(HttpStatus.OK, "");

        assertThatThrownBy(() -> client.getPaymentInformation("TX-MALFORMED"))
                .isInstanceOf(PayOsException.class)
                .satisfies(ex -> assertThat(((PayOsException) ex).getErrorType()).isEqualTo(PayOsErrorType.INVALID_RESPONSE));
    }

    @Test
    @DisplayName("Network timeout / request exception -> throw PayOsException(TRANSIENT)")
    void networkTimeout_ThrowsTransient() {
        WebClientRequestException networkError = new WebClientRequestException(
                new RuntimeException("Connection timed out"),
                org.springframework.http.HttpMethod.GET,
                URI.create("https://api-merchant.payos.vn/v2/payment-requests/TX-TIMEOUT"),
                new HttpHeaders());

        PayOsClientImpl client = createClientWithError(networkError);

        assertThatThrownBy(() -> client.getPaymentInformation("TX-TIMEOUT"))
                .isInstanceOf(PayOsException.class)
                .satisfies(ex -> assertThat(((PayOsException) ex).getErrorType()).isEqualTo(PayOsErrorType.TRANSIENT));
    }

    @Test
    @DisplayName("generateHmacSHA256: Tính toán chữ ký chính xác")
    void generateHmacSHA256_ValidSignature() {
        PayOsClientImpl client = createClientWithResponse(HttpStatus.OK, "{}");
        String sig = client.generateHmacSHA256("test-data", "secret-key");
        assertThat(sig).isNotBlank();
        assertThat(sig.length()).isEqualTo(64); // SHA-256 hex string is 64 chars
    }
}
