package com.thanhmila.codelearning.controller.course;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.dto.request.QuizOptionRequest;
import com.thanhmila.codelearning.dto.request.QuizQuestionRequest;
import com.thanhmila.codelearning.dto.request.QuizRequest;
import com.thanhmila.codelearning.dto.request.QuizSubmitRequest;
import com.thanhmila.codelearning.dto.request.SubmissionDetail;
import com.thanhmila.codelearning.dto.response.QuizSubmitResponse;
import com.thanhmila.codelearning.security.UserRateLimitInterceptor;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import com.thanhmila.codelearning.service.course.QuizService;
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

import java.math.BigDecimal;
import java.util.List;
import java.util.Set;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(QuizController.class)
@AutoConfigureMockMvc(addFilters = false)
@ActiveProfiles("test")
@Import(QuizControllerTest.TestConfig.class)
@DisplayName("QuizController WebMvc Slice Tests")
class QuizControllerTest {

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
    private QuizService quizService;

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
                new JwtAuthenticationToken(jwt, List.of(new SimpleGrantedAuthority("QUIZ_SUBMIT")), username)
        );
    }

    @Test
    @DisplayName("POST /quizzes/{quizId}/submit: Nộp bài quiz chấm điểm thành công")
    void submitQuiz_Success_ReturnsHttp200() throws Exception {
        authenticate("student", 10L);

        SubmissionDetail detail = SubmissionDetail.builder()
                .questionId(1L)
                .selectedOptionId(2L)
                .build();

        QuizSubmitRequest request = QuizSubmitRequest.builder()
                .submissions(Set.of(detail))
                .build();

        QuizSubmitResponse response = QuizSubmitResponse.builder()
                .score(new BigDecimal("10.0"))
                .correctAnswers(10)
                .build();

        when(quizService.submitQuiz(eq(5L), eq(10L), any(QuizSubmitRequest.class))).thenReturn(response);

        mockMvc.perform(post("/quizzes/{quizId}/submit", 5L)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.score").value(10.0))
                .andExpect(jsonPath("$.result.correctAnswers").value(10));
    }

    @Test
    @DisplayName("POST /lessons/{lessonId}/quiz: Tạo bài quiz cho lesson thành công")
    void createQuiz_Success_ReturnsHttp200() throws Exception {
        authenticate("teacher", 20L);

        QuizOptionRequest option = QuizOptionRequest.builder()
                .content("Answer 1")
                .isCorrect(true)
                .orderIndex(1)
                .build();

        QuizQuestionRequest question = QuizQuestionRequest.builder()
                .questionContent("Question 1?")
                .orderIndex(1)
                .options(List.of(option))
                .build();

        QuizRequest request = QuizRequest.builder()
                .title("Quiz title")
                .questions(List.of(question))
                .build();

        mockMvc.perform(post("/lessons/{lessonId}/quiz", 100L)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Create quiz successfully"));

        verify(quizService).createQuiz(eq(100L), eq(20L), any(QuizRequest.class));
    }

    @Test
    @DisplayName("PUT /lessons/{lessonId}/quiz: Cập nhật bài quiz thành công")
    void updateQuiz_Success_ReturnsHttp200() throws Exception {
        authenticate("teacher", 20L);

        QuizOptionRequest option = QuizOptionRequest.builder()
                .content("Answer 1")
                .isCorrect(true)
                .orderIndex(1)
                .build();

        QuizQuestionRequest question = QuizQuestionRequest.builder()
                .questionContent("Question 1?")
                .orderIndex(1)
                .options(List.of(option))
                .build();

        QuizRequest request = QuizRequest.builder()
                .title("Updated Quiz title")
                .questions(List.of(question))
                .build();

        mockMvc.perform(put("/lessons/{lessonId}/quiz", 100L)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Update quiz successfully"));

        verify(quizService).updateQuiz(eq(100L), eq(20L), any(QuizRequest.class));
    }

    @Test
    @DisplayName("DELETE /lessons/{lessonId}/quiz: Xóa bài quiz thành công")
    void deleteQuiz_Success_ReturnsHttp200() throws Exception {
        authenticate("teacher", 20L);

        mockMvc.perform(delete("/lessons/{lessonId}/quiz", 100L))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Delete quiz successfully"));

        verify(quizService).deleteQuiz(100L, 20L);
    }
}
