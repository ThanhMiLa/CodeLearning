package com.thanhmila.codelearning.controller.course;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.dto.request.LessonCommentRequest;
import com.thanhmila.codelearning.dto.request.LessonReorderRequest;
import com.thanhmila.codelearning.dto.response.*;
import com.thanhmila.codelearning.security.UserRateLimitInterceptor;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import com.thanhmila.codelearning.service.course.LessonCommentService;
import com.thanhmila.codelearning.service.course.LessonService;
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
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;
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
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(LessonController.class)
@AutoConfigureMockMvc(addFilters = false)
@ActiveProfiles("test")
@Import(LessonControllerTest.TestConfig.class)
@DisplayName("LessonController WebMvc Slice Tests")
class LessonControllerTest {

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
    private LessonService lessonService;

    @MockitoBean
    private QuizService quizService;

    @MockitoBean
    private LessonCommentService lessonCommentService;

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
                new JwtAuthenticationToken(jwt, List.of(new SimpleGrantedAuthority("USER")), username)
        );
    }

    @Test
    @DisplayName("GET /lessons/{lessonId}: Xem chi tiết bài học thành công")
    void getLessonDetail_Success_ReturnsHttp200() throws Exception {
        LessonDetailResponse detail = LessonDetailResponse.builder()
                .id(100L)
                .title("Bài 1: Giới thiệu biến")
                .build();

        when(lessonService.getLessonDetail(100L, null)).thenReturn(detail);

        mockMvc.perform(get("/lessons/{lessonId}", 100L))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.id").value(100))
                .andExpect(jsonPath("$.result.title").value("Bài 1: Giới thiệu biến"));
    }

    @Test
    @DisplayName("GET /lessons/{lessonId}/quiz: Lấy chi tiết bài quiz của bài học thành công")
    void getQuizDetail_Success_ReturnsHttp200() throws Exception {
        authenticate("student", 1L);

        QuizDetailResponse quiz = QuizDetailResponse.builder()
                .id(50L)
                .title("Quiz Chương 1")
                .build();

        when(quizService.getQuizDetail(100L, 1L)).thenReturn(quiz);

        mockMvc.perform(get("/lessons/{lessonId}/quiz", 100L))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.id").value(50));
    }

    @Test
    @DisplayName("GET /lessons/{lessonId}/comments: Lấy danh sách bình luận gốc thành công")
    void getCommentList_Success_ReturnsHttp200() throws Exception {
        LessonCommentResponse comment = LessonCommentResponse.builder()
                .id(1L)
                .content("Bài học rất hay!")
                .build();

        when(lessonCommentService.getRootComments(eq(100L), any(Pageable.class)))
                .thenReturn(new PageImpl<>(List.of(comment)));

        mockMvc.perform(get("/lessons/{lessonId}/comments", 100L))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.content[0].content").value("Bài học rất hay!"));
    }

    @Test
    @DisplayName("GET /lessons/{lessonId}/comments/{commentId}/replies: Lấy danh sách câu trả lời bình luận thành công")
    void getCommentListWithReply_Success_ReturnsHttp200() throws Exception {
        LessonCommentResponse reply = LessonCommentResponse.builder()
                .id(2L)
                .content("Cảm ơn bạn!")
                .build();

        when(lessonCommentService.getReplies(eq(1L), any(Pageable.class)))
                .thenReturn(new PageImpl<>(List.of(reply)));

        mockMvc.perform(get("/lessons/{lessonId}/comments/{commentId}/replies", 100L, 1L))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.content[0].content").value("Cảm ơn bạn!"));
    }

    @Test
    @DisplayName("POST /lessons/{lessonId}/comments: Thêm bình luận mới thành công")
    void createComment_Success_ReturnsHttp200() throws Exception {
        authenticate("student", 1L);

        LessonCommentRequest request = LessonCommentRequest.builder()
                .content("Thắc mắc phần này")
                .build();

        LessonCommentResponse response = LessonCommentResponse.builder()
                .id(3L)
                .content("Thắc mắc phần này")
                .build();

        when(lessonCommentService.createComment(eq(100L), eq(1L), any(LessonCommentRequest.class)))
                .thenReturn(response);

        mockMvc.perform(post("/lessons/{lessonId}/comments", 100L)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.id").value(3));
    }

    @Test
    @DisplayName("POST /lessons/{lessonId}/complete: Đánh dấu hoàn thành bài học thành công")
    void completedLesson_Success_ReturnsHttp200() throws Exception {
        authenticate("student", 1L);

        LessonCompletionResponse response = LessonCompletionResponse.builder()
                .lessonId(100L)
                .courseId(10L)
                .completedLessonsCount(5)
                .totalLessons(10)
                .isCourseCompleted(false)
                .build();

        when(lessonService.completedLesson(100L, 1L)).thenReturn(response);

        mockMvc.perform(post("/lessons/{lessonId}/complete", 100L))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.lessonId").value(100))
                .andExpect(jsonPath("$.result.completedLessonsCount").value(5));
    }

    @Test
    @DisplayName("POST /lessons/chapters/{chapterId}/lessons: Tạo bài học mới thành công")
    void createLesson_Success_ReturnsHttp200() throws Exception {
        LessonDetailResponse response = LessonDetailResponse.builder()
                .id(101L)
                .title("Bài 2: Kiểu dữ liệu")
                .build();

        when(lessonService.createLesson(eq(10L), any())).thenReturn(response);

        mockMvc.perform(multipart("/lessons/chapters/{chapterId}/lessons", 10L)
                        .param("title", "Bài 2: Kiểu dữ liệu")
                        .param("lessonType", "THEORY")
                        .param("theoryContent", "Theory text"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.title").value("Bài 2: Kiểu dữ liệu"));
    }

    @Test
    @DisplayName("DELETE /lessons/{lessonId}: Xóa bài học thành công")
    void deleteLesson_Success_ReturnsHttp200() throws Exception {
        mockMvc.perform(delete("/lessons/{lessonId}", 100L))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Delete lesson successfully"));

        verify(lessonService).deleteLesson(100L);
    }

    @Test
    @DisplayName("PUT /lessons/chapters/{chapterId}/lessons/reorder: Sắp xếp lại thứ tự bài học thành công")
    void reorderLessons_Success_ReturnsHttp200() throws Exception {
        List<LessonReorderRequest> requests = List.of(
                LessonReorderRequest.builder().id(100L).orderIndex(2).build()
        );

        mockMvc.perform(put("/lessons/chapters/{chapterId}/lessons/reorder", 10L)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(requests)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Reorder lessons successfully"));

        verify(lessonService).reorderLessons(eq(10L), any());
    }
}
