package com.thanhmila.codelearning.service.email.impl;

import com.thanhmila.codelearning.dto.email.SendGridEmailRequest;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("SendGridApiServiceImpl Unit Tests")
class SendGridApiServiceImplTest {

    @Mock
    private WebClient webClient;

    @InjectMocks
    private SendGridApiServiceImpl sendGridApiService;

    @SuppressWarnings("rawtypes")
    private WebClient.RequestBodyUriSpec requestBodyUriSpec;
    private WebClient.RequestBodySpec requestBodySpec;
    @SuppressWarnings("rawtypes")
    private WebClient.RequestHeadersUriSpec requestHeadersUriSpec;
    @SuppressWarnings("rawtypes")
    private WebClient.RequestHeadersSpec requestHeadersSpec;
    private WebClient.ResponseSpec responseSpec;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(sendGridApiService, "apiKey", "test-api-key");
        requestBodyUriSpec = mock(WebClient.RequestBodyUriSpec.class);
        requestBodySpec = mock(WebClient.RequestBodySpec.class);
        requestHeadersUriSpec = mock(WebClient.RequestHeadersUriSpec.class);
        requestHeadersSpec = mock(WebClient.RequestHeadersSpec.class);
        responseSpec = mock(WebClient.ResponseSpec.class);
    }

    @Test
    @DisplayName("sendEmailBulk: Gửi email hàng loạt thành công")
    @SuppressWarnings("unchecked")
    void sendEmailBulk_Success() {
        SendGridEmailRequest request = new SendGridEmailRequest();

        when(webClient.post()).thenReturn(requestBodyUriSpec);
        when(requestBodyUriSpec.uri("https://api.sendgrid.com/v3/mail/send")).thenReturn(requestBodySpec);
        when(requestBodySpec.header("Authorization", "Bearer test-api-key")).thenReturn(requestBodySpec);
        when(requestBodySpec.bodyValue(request)).thenReturn(requestHeadersSpec);
        when(requestHeadersSpec.retrieve()).thenReturn(responseSpec);
        when(responseSpec.onStatus(any(), any())).thenReturn(responseSpec);
        when(responseSpec.bodyToMono(Void.class)).thenReturn(Mono.empty());

        sendGridApiService.sendEmailBulk(request);
    }

    @Test
    @DisplayName("getTemplates: Lấy danh sách dynamic templates từ SendGrid")
    @SuppressWarnings("unchecked")
    void getTemplates_Success() {
        Map<String, Object> mockTemplates = Map.of("templates", List.of(Map.of("id", "d-123", "name", "Welcome")));

        when(webClient.get()).thenReturn(requestHeadersUriSpec);
        when(requestHeadersUriSpec.uri("https://api.sendgrid.com/v3/templates?generations=dynamic")).thenReturn(requestHeadersSpec);
        when(requestHeadersSpec.header("Authorization", "Bearer test-api-key")).thenReturn(requestHeadersSpec);
        when(requestHeadersSpec.retrieve()).thenReturn(responseSpec);
        when(responseSpec.bodyToMono(Object.class)).thenReturn(Mono.just(mockTemplates));

        Object result = sendGridApiService.getTemplates();

        assertThat(result).isNotNull();
        assertThat(result).isEqualTo(mockTemplates);
    }
}
