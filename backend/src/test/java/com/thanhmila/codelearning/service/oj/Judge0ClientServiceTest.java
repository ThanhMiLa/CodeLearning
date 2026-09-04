package com.thanhmila.codelearning.service.oj;

import com.thanhmila.codelearning.dto.judge0.Judge0BatchRequest;
import com.thanhmila.codelearning.dto.judge0.Judge0SubmissionItem;
import com.thanhmila.codelearning.dto.judge0.Judge0TokenResponse;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.MediaType;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("Judge0ClientService Unit Tests")
class Judge0ClientServiceTest {

    @Mock
    private WebClient judge0WebClient;

    @InjectMocks
    private Judge0ClientService judge0ClientService;

    @SuppressWarnings("rawtypes")
    private WebClient.RequestBodyUriSpec requestBodyUriSpec;
    private WebClient.RequestBodySpec requestBodySpec;
    @SuppressWarnings("rawtypes")
    private WebClient.RequestHeadersSpec requestHeadersSpec;
    private WebClient.ResponseSpec responseSpec;

    @BeforeEach
    void setUp() {
        requestBodyUriSpec = mock(WebClient.RequestBodyUriSpec.class);
        requestBodySpec = mock(WebClient.RequestBodySpec.class);
        requestHeadersSpec = mock(WebClient.RequestHeadersSpec.class);
        responseSpec = mock(WebClient.ResponseSpec.class);
    }

    @Test
    @DisplayName("sendBatchSubmission: Gửi batch submissions và nhận về danh sách Judge0TokenResponse")
    @SuppressWarnings("unchecked")
    void sendBatchSubmission_Success() {
        Judge0BatchRequest request = new Judge0BatchRequest();
        Judge0SubmissionItem item = new Judge0SubmissionItem();
        item.setSourceCode("print('hello')");
        item.setLanguageId(71);
        request.setSubmissions(List.of(item));

        List<Judge0TokenResponse> mockResponses = List.of(new Judge0TokenResponse("token-abc-123"));

        when(judge0WebClient.post()).thenReturn(requestBodyUriSpec);
        when(requestBodyUriSpec.uri("/submissions/batch?base64_encoded=false")).thenReturn(requestBodySpec);
        when(requestBodySpec.contentType(MediaType.APPLICATION_JSON)).thenReturn(requestBodySpec);
        when(requestBodySpec.body(any(Mono.class), eq(Judge0BatchRequest.class))).thenReturn(requestHeadersSpec);
        when(requestHeadersSpec.retrieve()).thenReturn(responseSpec);
        when(responseSpec.bodyToMono(any(ParameterizedTypeReference.class))).thenReturn(Mono.just(mockResponses));

        List<Judge0TokenResponse> result = judge0ClientService.sendBatchSubmission(request);

        assertThat(result).isNotNull();
        assertThat(result).hasSize(1);
        assertThat(result.get(0).getToken()).isEqualTo("token-abc-123");
    }
}
