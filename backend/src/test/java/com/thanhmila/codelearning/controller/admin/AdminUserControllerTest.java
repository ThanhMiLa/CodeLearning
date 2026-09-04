package com.thanhmila.codelearning.controller.admin;

import com.thanhmila.codelearning.dto.response.AdminUserResponse;
import com.thanhmila.codelearning.dto.response.EmailTargetUserResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.security.UserRateLimitInterceptor;
import com.thanhmila.codelearning.service.admin.AdminUserService;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.data.domain.Pageable;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(AdminUserController.class)
@AutoConfigureMockMvc(addFilters = false)
@ActiveProfiles("test")
@DisplayName("AdminUserController WebMvc Slice Tests")
class AdminUserControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private AdminUserService adminUserService;

    @MockitoBean
    private RateLimitService rateLimitService;

    @MockitoBean
    private UserRateLimitInterceptor userRateLimitInterceptor;

    @BeforeEach
    void setUp() throws Exception {
        when(userRateLimitInterceptor.preHandle(any(), any(), any())).thenReturn(true);
    }

    @Test
    @DisplayName("GET /admin/users: Lấy danh sách người dùng với sắp xếp ASC thành công")
    void getUsers_SortAsc_ReturnsHttp200() throws Exception {
        AdminUserResponse user = AdminUserResponse.builder()
                .id(1L)
                .username("admin")
                .email("admin@example.com")
                .status("ACTIVE")
                .build();

        PageResponse<AdminUserResponse> pageResponse = PageResponse.<AdminUserResponse>builder()
                .page(0)
                .size(10)
                .totalElements(1L)
                .totalPages(1)
                .content(List.of(user))
                .build();

        when(adminUserService.getUsersForAdmin(eq("admin"), any(Pageable.class)))
                .thenReturn(pageResponse);

        mockMvc.perform(get("/admin/users")
                        .param("keyword", "admin")
                        .param("sortDir", "asc"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.content[0].username").value("admin"));
    }

    @Test
    @DisplayName("GET /admin/users/online: Lấy danh sách người dùng online thành công")
    void getOnlineUsers_Success_ReturnsHttp200() throws Exception {
        PageResponse<AdminUserResponse> pageResponse = PageResponse.<AdminUserResponse>builder()
                .page(0)
                .size(20)
                .totalElements(0L)
                .totalPages(0)
                .content(List.of())
                .build();

        when(adminUserService.getOnlineUsers(any(Pageable.class))).thenReturn(pageResponse);

        mockMvc.perform(get("/admin/users/online")
                        .param("sortDir", "desc"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000));
    }

    @Test
    @DisplayName("GET /admin/users/email-targets: Lấy danh sách mục tiêu gửi email thành công")
    void getEmailTargets_Success_ReturnsHttp200() throws Exception {
        EmailTargetUserResponse target = EmailTargetUserResponse.builder()
                .id("1")
                .email("target@example.com")
                .displayName("target")
                .build();

        when(adminUserService.getEmailTargets("test", "USER")).thenReturn(List.of(target));

        mockMvc.perform(get("/admin/users/email-targets")
                        .param("keyword", "test")
                        .param("role", "USER"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result[0].email").value("target@example.com"));
    }
}
