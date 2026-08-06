package com.thanhmila.codelearning.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.thanhmila.codelearning.exception.ErrorCode;

import java.time.Instant;

@Component
@RequiredArgsConstructor
public class UserRateLimitInterceptor implements HandlerInterceptor {

    private final RateLimitService rateLimitService;
    private final ObjectMapper objectMapper;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null && authentication.isAuthenticated() && !authentication.getPrincipal().equals("anonymousUser")) {

            String userId = "";
            Object principal = authentication.getPrincipal();
            if (principal instanceof Jwt jwt) {
                Object userIdClaim = jwt.getClaim("userId");
                userId = userIdClaim != null ? userIdClaim.toString() : null;
            }

            if (!rateLimitService.tryConsumeUser(userId)) {
                response.setStatus(HttpStatus.TOO_MANY_REQUESTS.value());
                response.setContentType(MediaType.APPLICATION_JSON_VALUE);
                response.setCharacterEncoding("UTF-8");

                ErrorCode errorCode = ErrorCode.TOO_MANY_REQUESTS;

                ApiResponse<Object> errorResponse = ApiResponse.builder()
                        .timestamp(Instant.now().toString())
                        .status(errorCode.getHttpStatus().value())
                        .message(errorCode.getMessage())
                        .code(errorCode.getCode())
                        .result(null)
                        .build();

                response.getWriter().write(objectMapper.writeValueAsString(errorResponse));
                return false; 
            }
        }

        return true; 
    }
}
