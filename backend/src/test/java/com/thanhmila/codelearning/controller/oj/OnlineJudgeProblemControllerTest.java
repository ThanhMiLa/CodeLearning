package com.thanhmila.codelearning.controller.oj;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.dto.request.CreateOjProblemRequest;
import com.thanhmila.codelearning.dto.request.ProblemSearchRequest;
import com.thanhmila.codelearning.dto.response.*;
import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;
import com.thanhmila.codelearning.entity.enums.ProblemScope;
import com.thanhmila.codelearning.security.UserRateLimitInterceptor;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import com.thanhmila.codelearning.service.oj.OjSubmissionService;
import com.thanhmila.codelearning.service.oj.OnlineJudgeProblemService;
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
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(OnlineJudgeProblemController.class)
@AutoConfigureMockMvc(addFilters = false)
@ActiveProfiles("test")
@Import(OnlineJudgeProblemControllerTest.TestConfig.class)
@DisplayName("OnlineJudgeProblemController WebMvc Slice Tests")
class OnlineJudgeProblemControllerTest {

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
    private OnlineJudgeProblemService onlineJudgeProblemService;

    @MockitoBean
    private OjSubmissionService ojSubmissionService;

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
                new JwtAuthenticationToken(jwt, List.of(new SimpleGrantedAuthority("OJ_PROBLEM_ADMIN")), username)
        );
    }

    @Test
    @DisplayName("GET /online-judge/problems/practice: Lấy danh sách bài tập luyện tập thành công")
    void getPracticeProblems_Success_ReturnsHttp200() throws Exception {
        OjPracticeProblemResponse problem = OjPracticeProblemResponse.builder()
                .id(1L)
                .title("Two Sum")
                .difficulty(ProblemDifficulty.EASY)
                .build();

        PageResponse<OjPracticeProblemResponse> pageResponse = PageResponse.<OjPracticeProblemResponse>builder()
                .page(0)
                .size(10)
                .totalElements(1L)
                .totalPages(1)
                .content(List.of(problem))
                .build();

        when(onlineJudgeProblemService.getPracticeProblems(any(ProblemSearchRequest.class), eq(null)))
                .thenReturn(pageResponse);

        mockMvc.perform(get("/online-judge/problems/practice"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.content[0].title").value("Two Sum"));
    }

    @Test
    @DisplayName("GET /online-judge/problems/{problemId}: Xem chi tiết bài tập thành công")
    void getProblemDetail_Success_ReturnsHttp200() throws Exception {
        authenticate("user1", 10L);

        OjProblemDetailResponse detail = OjProblemDetailResponse.builder()
                .id(1L)
                .title("Two Sum")
                .build();

        when(onlineJudgeProblemService.getProblemDetail(eq(1L), eq(10L), eq(null))).thenReturn(detail);

        mockMvc.perform(get("/online-judge/problems/{problemId}", 1L))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.id").value(1));
    }

    @Test
    @DisplayName("POST /online-judge/admin/problems: Tạo bài tập mới vào bank thành công")
    void createProblemInBank_Success_ReturnsHttp200() throws Exception {
        authenticate("admin", 1L);

        CreateOjProblemRequest request = CreateOjProblemRequest.builder()
                .title("Reverse String")
                .description("Reverse a string")
                .difficulty(ProblemDifficulty.EASY)
                .problemScope(ProblemScope.PRACTICE)
                .timeLimitMs(1000)
                .memoryLimitKb(262144)
                .build();

        when(onlineJudgeProblemService.createProblemInBank(any(CreateOjProblemRequest.class), eq(1L)))
                .thenReturn(100L);

        mockMvc.perform(post("/online-judge/admin/problems")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result").value(100L));
    }

    @Test
    @DisplayName("PUT /online-judge/admin/problems/{problemId}/public: Cập nhật hiển thị bài tập thành công")
    void updateProblemVisibility_Success_ReturnsHttp200() throws Exception {
        authenticate("admin", 1L);

        mockMvc.perform(put("/online-judge/admin/problems/{problemId}/public", 1L)
                        .param("isPublic", "true"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Update problem visibility successfully"));

        verify(onlineJudgeProblemService).updateProblemVisibility(1L, true);
    }
}
