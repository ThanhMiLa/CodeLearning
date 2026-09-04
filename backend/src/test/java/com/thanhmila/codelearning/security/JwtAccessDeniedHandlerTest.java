package com.thanhmila.codelearning.security;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.security.access.AccessDeniedException;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("JwtAccessDeniedHandler Unit Tests")
class JwtAccessDeniedHandlerTest {

    private final JwtAccessDeniedHandler accessDeniedHandler = new JwtAccessDeniedHandler();

    @Test
    @DisplayName("handle: Ghi response HTTP 403 Forbidden với đúng định dạng JSON ApiResponse")
    void handle_WritesAccessDeniedResponse() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        MockHttpServletResponse response = new MockHttpServletResponse();

        accessDeniedHandler.handle(request, response, new AccessDeniedException("Forbidden"));

        assertThat(response.getStatus()).isEqualTo(403);
        assertThat(response.getContentType()).isEqualTo("application/json");
        assertThat(response.getContentAsString()).contains("\"code\":1004");
        assertThat(response.getContentAsString()).contains("You do not have permission");
    }
}
