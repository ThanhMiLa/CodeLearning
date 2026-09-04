package com.thanhmila.codelearning.controller.oj;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.dto.judge0.Judge0CallbackPayload;
import com.thanhmila.codelearning.dto.request.GenerateTestcaseRequest;
import com.thanhmila.codelearning.dto.request.OjSubmissionRequest;
import com.thanhmila.codelearning.dto.response.OjSubmissionInitialResponse;
import com.thanhmila.codelearning.security.UserRateLimitInterceptor;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import com.thanhmila.codelearning.service.oj.OjSubmissionService;
import com.thanhmila.codelearning.service.oj.OjTestcaseGenerationService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.security.web.method.annotation.AuthenticationPrincipalArgumentResolver;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(OnlineJudgeSubmissionController.class)
@AutoConfigureMockMvc(addFilters = false)
@ActiveProfiles("test")
@Import(OnlineJudgeSubmissionControllerTest.TestConfig.class)
@DisplayName("OnlineJudgeSubmissionController WebMvc Slice Tests")
class OnlineJudgeSubmissionControllerTest {

    @TestConfiguration
    static class TestConfig implements WebMvcConfigurer {
        @Override
        public void addArgumentResolvers(List<HandlerMethodArgumentResolver> resolvers) {
            resolvers.add(new AuthenticationPrincipalArgumentResolver());
        }
    }

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockitoBean
    private OjSubmissionService ojSubmissionService;

    @MockitoBean
    private OjTestcaseGenerationService ojTestcaseGenerationService;

    @MockitoBean
    private RateLimitService rateLimitService;

    @MockitoBean
    private UserRateLimitInterceptor userRateLimitInterceptor;

    @BeforeEach
    void setUp() throws Exception {
        when(userRateLimitInterceptor.preHandle(any(), any(), any())).thenReturn(true);
    }

    @AfterEach
    void tearDown() {
        SecurityContextHolder.clearContext();
    }

    private void authenticate(String username, Long userId) {
        Jwt jwt = Jwt.withTokenValue("mock-jwt-token")
                .header("alg", "none")
                .subject(username)
                .claim("userId", userId)
                .build();
        SecurityContextHolder.getContext().setAuthentication(
                new JwtAuthenticationToken(jwt, List.of(new SimpleGrantedAuthority("OJ_PROBLEM_SUBMIT")), username)
        );
    }

    @Test
    @DisplayName("POST /online-judge/submissions: Nộp code thành công trả về HTTP 200")
    void submitCode_Success_ReturnsHttp200() throws Exception {
        authenticate("student", 10L);

        OjSubmissionRequest request = OjSubmissionRequest.builder()
                .problemId(1L)
                .languageId(71)
                .sourceCode("print('Hello World')")
                .build();

        OjSubmissionInitialResponse response = OjSubmissionInitialResponse.builder()
                .submissionId(100L)
                .status("PENDING")
                .build();

        when(ojSubmissionService.submitCode(any(OjSubmissionRequest.class), eq(10L))).thenReturn(response);

        mockMvc.perform(post("/online-judge/submissions")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.submissionId").value(100));
    }

    @Test
    @DisplayName("PUT /online-judge/submissions: Webhook callback sai secret trả về HTTP 401")
    void processJudge0Callback_InvalidSecret_ReturnsHttp401() throws Exception {
        Judge0CallbackPayload payload = new Judge0CallbackPayload();

        mockMvc.perform(put("/online-judge/submissions")
                        .param("secret", "wrong-secret")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(payload)))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$.message").value("Invalid webhook secret"));
    }

    @Test
    @DisplayName("PUT /online-judge/submissions: Webhook callback đúng secret trả về HTTP 200 (status 204)")
    void processJudge0Callback_ValidSecret_ReturnsHttp200() throws Exception {
        Judge0CallbackPayload payload = new Judge0CallbackPayload();

        mockMvc.perform(put("/online-judge/submissions")
                        .param("secret", "test_secret_12345")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(payload)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value(204))
                .andExpect(jsonPath("$.message").value("Judge0 callback processed successfully"));

        verify(ojSubmissionService).processJudge0Callback(any(Judge0CallbackPayload.class));
    }

    @Test
    @DisplayName("POST /online-judge/problems/{problemId}/generate-testcases: Bắt đầu sinh testcase trả về HTTP 202")
    void generateTestcases_Success_ReturnsHttp202() throws Exception {
        GenerateTestcaseRequest request = new GenerateTestcaseRequest();
        request.setTotalTestcasesToGenerate(5);
        request.setGeneratorCode("gen");
        request.setSolutionCode("sol");
        request.setGeneratorLanguageId(71);
        request.setSolutionLanguageId(71);

        mockMvc.perform(post("/online-judge/problems/{problemId}/generate-testcases", 1L)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isAccepted())
                .andExpect(jsonPath("$.status").value(202))
                .andExpect(jsonPath("$.message").value("Testcase generation started"));

        verify(ojTestcaseGenerationService).generateTestcases(eq(1L), any(GenerateTestcaseRequest.class));
    }

    @Test
    @DisplayName("PUT /online-judge/webhooks/generate-inputs: Xử lý input webhook thành công trả về HTTP 200")
    void processInputWebhook_Success_ReturnsHttp200() throws Exception {
        Judge0CallbackPayload payload = new Judge0CallbackPayload();

        mockMvc.perform(put("/online-judge/webhooks/generate-inputs")
                        .param("secret", "test_secret_12345")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(payload)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Process input webhook successfully"));

        verify(ojTestcaseGenerationService).processInputWebhook(any(Judge0CallbackPayload.class));
    }

    @Test
    @DisplayName("PUT /online-judge/webhooks/generate-outputs: Xử lý output webhook thành công trả về HTTP 200")
    void processOutputWebhook_Success_ReturnsHttp200() throws Exception {
        Judge0CallbackPayload payload = new Judge0CallbackPayload();

        mockMvc.perform(put("/online-judge/webhooks/generate-outputs")
                        .param("secret", "test_secret_12345")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(payload)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Process output webhook successfully"));

        verify(ojTestcaseGenerationService).processOutputWebhook(any(Judge0CallbackPayload.class));
    }
}
