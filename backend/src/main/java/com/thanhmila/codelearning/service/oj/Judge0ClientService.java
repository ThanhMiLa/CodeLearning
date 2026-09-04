package com.thanhmila.codelearning.service.oj;

import com.thanhmila.codelearning.dto.judge0.Judge0BatchRequest;
import com.thanhmila.codelearning.dto.judge0.Judge0TokenResponse;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;
import java.util.List;

@Slf4j
@Service
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class Judge0ClientService {

    WebClient judge0WebClient;

    public Judge0ClientService(@Qualifier("judge0WebClient") WebClient judge0WebClient) {
        this.judge0WebClient = judge0WebClient;
    }

    public List<Judge0TokenResponse> sendBatchSubmission(Judge0BatchRequest request) {
        log.info("Sending {} testcases to Judge0...", request.getSubmissions().size());

        List<Judge0TokenResponse> tokens = judge0WebClient.post()
                // Gắn query param base64_encoded=false vì ta gửi text thuần
                .uri("/submissions/batch?base64_encoded=false")
                .contentType(MediaType.APPLICATION_JSON)
                .body(Mono.just(request), Judge0BatchRequest.class)
                .retrieve()
                .bodyToMono(new ParameterizedTypeReference<List<Judge0TokenResponse>>() {})
                .block(); // Chặn chờ kết quả (Vì đã có timeout 20s ở config nên rất an toàn)

        log.info("Successfully received {} tokens from Judge0.", tokens != null ? tokens.size() : 0);
        return tokens;
    }
}