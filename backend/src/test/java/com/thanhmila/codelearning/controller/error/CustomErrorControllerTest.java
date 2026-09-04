package com.thanhmila.codelearning.controller.error;

import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.exception.ErrorCode;
import jakarta.servlet.RequestDispatcher;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockHttpServletRequest;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("CustomErrorController Unit Tests")
class CustomErrorControllerTest {

    private final CustomErrorController controller = new CustomErrorController();

    @Test
    @DisplayName("handleError: Không có status attribute thì trả về 500 mặc định")
    void handleError_NoStatus_Returns500Default() {
        MockHttpServletRequest request = new MockHttpServletRequest();

        ResponseEntity<ApiResponse<Object>> response = controller.handleError(request);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.INTERNAL_SERVER_ERROR);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getCode()).isEqualTo(ErrorCode.UNCATEGORIZED_EXCEPTION.getCode());
    }

    @Test
    @DisplayName("handleError: Status 404 thì trả về RESOURCE_NOT_FOUND và endpoint uri")
    void handleError_NotFound_Returns404() {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setAttribute(RequestDispatcher.ERROR_STATUS_CODE, 404);
        request.setAttribute(RequestDispatcher.FORWARD_REQUEST_URI, "/api/non-existent");

        ResponseEntity<ApiResponse<Object>> response = controller.handleError(request);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getCode()).isEqualTo(ErrorCode.RESOURCE_NOT_FOUND.getCode());
        assertThat(response.getBody().getMessage()).contains("Endpoint not found: /api/non-existent");
    }

    @Test
    @DisplayName("handleError: Status 403 thì trả về ACCESS_DENIED")
    void handleError_Forbidden_Returns403() {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setAttribute(RequestDispatcher.ERROR_STATUS_CODE, 403);

        ResponseEntity<ApiResponse<Object>> response = controller.handleError(request);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getCode()).isEqualTo(ErrorCode.ACCESS_DENIED.getCode());
    }

    @Test
    @DisplayName("handleError: Status 401 thì trả về UNAUTHENTICATED")
    void handleError_Unauthorized_Returns401() {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setAttribute(RequestDispatcher.ERROR_STATUS_CODE, 401);

        ResponseEntity<ApiResponse<Object>> response = controller.handleError(request);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.UNAUTHORIZED);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getCode()).isEqualTo(ErrorCode.UNAUTHENTICATED.getCode());
    }

    @Test
    @DisplayName("handleError: Status khác có message tuỳ chỉnh thì trả về status đó và message")
    void handleError_OtherStatusWithMessage_ReturnsCustomMessage() {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setAttribute(RequestDispatcher.ERROR_STATUS_CODE, 400);
        request.setAttribute(RequestDispatcher.ERROR_MESSAGE, "Custom Bad Request");

        ResponseEntity<ApiResponse<Object>> response = controller.handleError(request);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.BAD_REQUEST);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getMessage()).isEqualTo("Custom Bad Request");
    }
}
