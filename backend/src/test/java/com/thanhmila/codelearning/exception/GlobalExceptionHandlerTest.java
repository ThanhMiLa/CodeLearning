package com.thanhmila.codelearning.exception;

import com.thanhmila.codelearning.dto.response.ApiResponse;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("GlobalExceptionHandler Unit Tests")
class GlobalExceptionHandlerTest {

    private final GlobalExceptionHandler handler = new GlobalExceptionHandler();

    @Test
    @DisplayName("appException: maps AppException to proper ResponseEntity and ApiResponse")
    void shouldHandleAppException() {
        AppException ex = new AppException(ErrorCode.COURSE_NOT_FOUND);

        ResponseEntity<ApiResponse<Object>> response = handler.appException(ex);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getCode()).isEqualTo(ErrorCode.COURSE_NOT_FOUND.getCode());
        assertThat(response.getBody().getMessage()).isEqualTo(ErrorCode.COURSE_NOT_FOUND.getMessage());
        assertThat(response.getBody().getTimestamp()).isNotBlank();
    }

    @Test
    @DisplayName("inValidInput: maps MethodArgumentNotValidException to ErrorCode")
    void shouldHandleMethodArgumentNotValidException() {
        BeanPropertyBindingResult bindingResult = new BeanPropertyBindingResult(new Object(), "target");
        bindingResult.addError(new FieldError("target", "password", "PASSWORD_INVALID"));
        MethodArgumentNotValidException ex = new MethodArgumentNotValidException(null, bindingResult);

        ResponseEntity<ApiResponse<Object>> response = handler.inValidInput(ex);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.BAD_REQUEST);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getCode()).isEqualTo(ErrorCode.PASSWORD_INVALID.getCode());
        assertThat(response.getBody().getMessage()).isEqualTo(ErrorCode.PASSWORD_INVALID.getMessage());
    }

    @Test
    @DisplayName("handleTypeMismatch: maps MethodArgumentTypeMismatchException with details")
    void shouldHandleMethodArgumentTypeMismatchException() {
        MethodArgumentTypeMismatchException ex =
                new MethodArgumentTypeMismatchException("invalid_id", Long.class, "id", null, null);

        ResponseEntity<ApiResponse<Object>> response = handler.handleTypeMismatch(ex);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.BAD_REQUEST);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getCode()).isEqualTo(4000);
        assertThat(response.getBody().getMessage()).contains("id", "invalid_id", "Long");
    }

    @Test
    @DisplayName("handleTypeMismatch: handles null value and null requiredType gracefully")
    void shouldHandleMethodArgumentTypeMismatchException_WhenValueAndTypeNull() {
        MethodArgumentTypeMismatchException ex =
                new MethodArgumentTypeMismatchException(null, null, "id", null, null);

        ResponseEntity<ApiResponse<Object>> response = handler.handleTypeMismatch(ex);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.BAD_REQUEST);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getMessage()).contains("null", "unknown");
    }

    @Test
    @DisplayName("handlingHttpMessageNotReadableException: returns INVALID_REQUEST_BODY")
    void shouldHandleHttpMessageNotReadableException() {
        HttpMessageNotReadableException ex = new HttpMessageNotReadableException("Invalid input");

        ResponseEntity<ApiResponse<Object>> response = handler.handlingHttpMessageNotReadableException(ex);

        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.BAD_REQUEST);
        assertThat(response.getBody()).isNotNull();
        assertThat(response.getBody().getCode()).isEqualTo(ErrorCode.INVALID_REQUEST_BODY.getCode());
        assertThat(response.getBody().getMessage()).isEqualTo(ErrorCode.INVALID_REQUEST_BODY.getMessage());
    }
}
