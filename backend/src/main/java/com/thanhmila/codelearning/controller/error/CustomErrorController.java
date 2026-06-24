package com.thanhmila.codelearning.controller.error;

import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.exception.ErrorCode;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;

@RestController
public class CustomErrorController implements ErrorController {

    @RequestMapping("/error")
    public ResponseEntity<ApiResponse<Object>> handleError(HttpServletRequest request) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        Object message = request.getAttribute(RequestDispatcher.ERROR_MESSAGE);

        HttpStatus httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
        int code = ErrorCode.UNCATEGORIZED_EXCEPTION.getCode();
        String errorMessage = ErrorCode.UNCATEGORIZED_EXCEPTION.getMessage();

        if (status != null) {
            try {
                int statusCode = Integer.parseInt(status.toString());
                HttpStatus resolved = HttpStatus.resolve(statusCode);
                if (resolved != null) {
                    httpStatus = resolved;
                }

                if (statusCode == HttpStatus.NOT_FOUND.value()) {
                    code = ErrorCode.RESOURCE_NOT_FOUND.getCode();
                    Object requestUri = request.getAttribute(RequestDispatcher.FORWARD_REQUEST_URI);
                    errorMessage = "Endpoint not found: " + (requestUri != null ? requestUri.toString() : "");
                } else if (statusCode == HttpStatus.FORBIDDEN.value()) {
                    code = ErrorCode.ACCESS_DENIED.getCode();
                    errorMessage = ErrorCode.ACCESS_DENIED.getMessage();
                } else if (statusCode == HttpStatus.UNAUTHORIZED.value()) {
                    code = ErrorCode.UNAUTHENTICATED.getCode();
                    errorMessage = ErrorCode.UNAUTHENTICATED.getMessage();
                } else {
                    if (message != null && !message.toString().isEmpty()) {
                        errorMessage = message.toString();
                    }
                }
            } catch (NumberFormatException e) {
                // Keep default internal server error
            }
        }

        return ResponseEntity.status(httpStatus)
                .body(ApiResponse.builder()
                        .status(httpStatus.value())
                        .code(code)
                        .message(errorMessage)
                        .result(null)
                        .timestamp(Instant.now().toString())
                        .build());
    }
}
