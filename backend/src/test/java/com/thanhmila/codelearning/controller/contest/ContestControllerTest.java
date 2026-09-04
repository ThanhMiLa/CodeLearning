package com.thanhmila.codelearning.controller.contest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.dto.request.ContestCreateRequest;
import com.thanhmila.codelearning.dto.request.ContestRegisterRequest;
import com.thanhmila.codelearning.dto.response.ContestLeaderboardResponse;
import com.thanhmila.codelearning.dto.response.ContestListResponse;
import com.thanhmila.codelearning.dto.response.ContestResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.enums.ScoringRule;
import com.thanhmila.codelearning.security.UserRateLimitInterceptor;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import com.thanhmila.codelearning.service.contest.ContestLeaderboardService;
import com.thanhmila.codelearning.service.contest.ContestService;
import com.thanhmila.codelearning.service.oj.OjSubmissionService;
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

import java.time.ZonedDateTime;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(ContestController.class)
@AutoConfigureMockMvc(addFilters = false)
@ActiveProfiles("test")
@Import(ContestControllerTest.TestConfig.class)
@DisplayName("ContestController WebMvc Slice Tests")
class ContestControllerTest {

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
    private ContestService contestService;

    @MockitoBean
    private ContestLeaderboardService contestLeaderboardService;

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
                new JwtAuthenticationToken(jwt, List.of(new SimpleGrantedAuthority("CONTEST_CREATE")), username)
        );
    }

    @Test
    @DisplayName("GET /contests: Lấy danh sách cuộc thi thành công trả về HTTP 200")
    void getContests_Success_ReturnsHttp200() throws Exception {
        ContestListResponse item = ContestListResponse.builder()
                .id(1L)
                .title("ICPC Mock Contest")
                .build();

        PageResponse<ContestListResponse> pageResponse = PageResponse.<ContestListResponse>builder()
                .page(0)
                .size(10)
                .totalElements(1L)
                .totalPages(1)
                .content(List.of(item))
                .build();

        when(contestService.getContests(0, 10, null)).thenReturn(pageResponse);

        mockMvc.perform(get("/contests")
                        .param("page", "0")
                        .param("size", "10"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.result.content[0].title").value("ICPC Mock Contest"));
    }

    @Test
    @DisplayName("POST /contests: Tạo cuộc thi mới thành công trả về HTTP 200")
    void createContest_Success_ReturnsHttp200() throws Exception {
        authenticate("teacher", 10L);

        ContestCreateRequest request = ContestCreateRequest.builder()
                .title("New ICPC Contest")
                .scoringRule(ScoringRule.ICPC)
                .startTime(ZonedDateTime.now().plusDays(1))
                .endTime(ZonedDateTime.now().plusDays(2))
                .build();

        ContestResponse response = ContestResponse.builder()
                .id(100L)
                .title("New ICPC Contest")
                .scoringRule(ScoringRule.ICPC)
                .build();

        when(contestService.createContest(any(ContestCreateRequest.class), eq(10L))).thenReturn(response);

        mockMvc.perform(post("/contests")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.result.id").value(100L));
    }

    @Test
    @DisplayName("GET /contests/{id}/leaderboard: Lấy bảng xếp hạng cuộc thi thành công")
    void getLeaderboard_Success_ReturnsHttp200() throws Exception {
        ContestLeaderboardResponse leaderboard = ContestLeaderboardResponse.builder()
                .contestId(1L)
                .title("ICPC Mock Contest")
                .leaderboard(List.of())
                .build();

        when(contestLeaderboardService.getLeaderboard(1L)).thenReturn(leaderboard);

        mockMvc.perform(get("/contests/{id}/leaderboard", 1L))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.result.contestId").value(1));
    }

    @Test
    @DisplayName("POST /contests/{id}/register: Đăng ký tham gia cuộc thi thành công")
    void registerContest_Success_ReturnsHttp200() throws Exception {
        authenticate("student", 20L);

        ContestRegisterRequest request = new ContestRegisterRequest();

        mockMvc.perform(post("/contests/{id}/register", 1L)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(200))
                .andExpect(jsonPath("$.message").value("Registered for contest successfully"));

        verify(contestService).registerContest(eq(1L), any(ContestRegisterRequest.class), eq(20L));
    }
}
