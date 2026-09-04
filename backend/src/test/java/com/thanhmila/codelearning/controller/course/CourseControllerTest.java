package com.thanhmila.codelearning.controller.course;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.dto.request.CourseSearchRequest;
import com.thanhmila.codelearning.dto.response.*;
import com.thanhmila.codelearning.security.UserRateLimitInterceptor;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import com.thanhmila.codelearning.service.course.CourseService;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Import;
import org.springframework.data.domain.Pageable;
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

import java.math.BigDecimal;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(CourseController.class)
@AutoConfigureMockMvc(addFilters = false)
@ActiveProfiles("test")
@Import(CourseControllerTest.TestConfig.class)
@DisplayName("CourseController WebMvc Slice Tests")
class CourseControllerTest {

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
    private CourseService courseService;

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
                new JwtAuthenticationToken(jwt, List.of(new SimpleGrantedAuthority("COURSE_CREATE")), username)
        );
    }

    @Test
    @DisplayName("GET /courses: Khách vãng lai tìm kiếm danh sách khóa học thành công")
    void getCourseList_Guest_ReturnsHttp200() throws Exception {
        CourseListItemResponse item = CourseListItemResponse.builder()
                .id(1L)
                .title("Java Core")
                .price(BigDecimal.ZERO)
                .build();

        PageResponse<CourseListItemResponse> pageResponse = PageResponse.<CourseListItemResponse>builder()
                .page(0)
                .size(10)
                .totalElements(1L)
                .totalPages(1)
                .content(List.of(item))
                .build();

        when(courseService.getCourseList(eq(null), any(CourseSearchRequest.class), any(Pageable.class)))
                .thenReturn(pageResponse);

        mockMvc.perform(get("/courses")
                        .param("page", "0")
                        .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.content[0].title").value("Java Core"));
    }

    @Test
    @DisplayName("GET /courses: Người dùng đăng nhập tìm kiếm danh sách khóa học thành công")
    void getCourseList_Authenticated_ReturnsHttp200() throws Exception {
        authenticate("user1", 100L);

        PageResponse<CourseListItemResponse> pageResponse = PageResponse.<CourseListItemResponse>builder()
                .page(0)
                .size(10)
                .totalElements(0L)
                .totalPages(0)
                .content(List.of())
                .build();

        when(courseService.getCourseList(eq(100L), any(CourseSearchRequest.class), any(Pageable.class)))
                .thenReturn(pageResponse);

        mockMvc.perform(get("/courses")
                        .param("page", "0")
                        .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000));
    }

    @Test
    @DisplayName("GET /courses/enrolled: Lấy danh sách khóa học đã ghi danh thành công")
    void getEnrolledCourses_Success_ReturnsHttp200() throws Exception {
        authenticate("user1", 100L);

        EnrolledCourseResponse enrolledCourse = EnrolledCourseResponse.builder()
                .id(1L)
                .title("Java Core")
                .progressPercentage(80)
                .build();

        PageResponse<EnrolledCourseResponse> pageResponse = PageResponse.<EnrolledCourseResponse>builder()
                .page(0)
                .size(10)
                .totalElements(1L)
                .totalPages(1)
                .content(List.of(enrolledCourse))
                .build();

        when(courseService.getEnrolledCourses(100L, 0, 10)).thenReturn(pageResponse);

        mockMvc.perform(get("/courses/enrolled")
                        .param("page", "0")
                        .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.content[0].id").value(1));
    }

    @Test
    @DisplayName("GET /courses/{courseId}: Xem chi tiết khóa học thành công")
    void getCourseDetail_Success_ReturnsHttp200() throws Exception {
        CourseDetailResponse detail = CourseDetailResponse.builder()
                .id(1L)
                .title("Java Core")
                .shortDescription("Detailed description")
                .build();

        when(courseService.getCourseDetail(1L, null)).thenReturn(detail);

        mockMvc.perform(get("/courses/{courseId}", 1L))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.id").value(1))
                .andExpect(jsonPath("$.result.title").value("Java Core"));
    }

    @Test
    @DisplayName("GET /courses/{courseId}/curriculum: Lấy danh mục chương mục bài học thành công")
    void getCourseCurriculum_Success_ReturnsHttp200() throws Exception {
        ChapterResponse chapter = ChapterResponse.builder()
                .id(10L)
                .title("Chương 1: Mở đầu")
                .build();

        when(courseService.getCourseCurriculum(1L, null)).thenReturn(List.of(chapter));

        mockMvc.perform(get("/courses/{courseId}/curriculum", 1L))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result[0].id").value(10));
    }

    @Test
    @DisplayName("GET /courses/categories: Lấy danh sách thể loại thành công")
    void getCategories_Success_ReturnsHttp200() throws Exception {
        CategoryResponse category = CategoryResponse.builder()
                .id(5L)
                .name("Backend Development")
                .build();

        when(courseService.getAllCategories()).thenReturn(List.of(category));

        mockMvc.perform(get("/courses/categories"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result[0].name").value("Backend Development"));
    }

    @Test
    @DisplayName("POST /courses: Tạo khóa học mới thành công")
    void createCourse_Success_ReturnsHttp200() throws Exception {
        authenticate("teacher", 50L);

        MockMultipartFile file = new MockMultipartFile("thumbnail", "thumb.png", "image/png", "img-bytes".getBytes());
        CourseDetailResponse detail = CourseDetailResponse.builder()
                .id(2L)
                .title("New Course")
                .build();

        when(courseService.createCourse(any())).thenReturn(detail);

        mockMvc.perform(multipart("/courses")
                        .file(file)
                        .param("title", "New Course Title")
                        .param("description", "A comprehensive course description")
                        .param("price", "200000")
                        .param("level", "BEGINNER")
                        .param("categoryId", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.title").value("New Course"));
    }
}
