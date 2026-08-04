package com.thanhmila.codelearning.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.service.RateLimitService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.util.HashMap;
import java.util.Map;

@Component
@RequiredArgsConstructor
public class UserRateLimitInterceptor implements HandlerInterceptor {

    private final RateLimitService rateLimitService;
    private final ObjectMapper objectMapper;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null && authentication.isAuthenticated() && !authentication.getPrincipal().equals("anonymousUser")) {

            String userId = authentication.getName();

            if (!rateLimitService.tryConsumeUser(userId)) {
                response.setStatus(HttpStatus.TOO_MANY_REQUESTS.value());
                response.setContentType(MediaType.APPLICATION_JSON_VALUE);
                response.setCharacterEncoding("UTF-8");

                Map<String, Object> errorResponse = new HashMap<>();
                errorResponse.put("status", 429);
                errorResponse.put("error", "Too Many Requests");
                errorResponse.put("message", "Bạn đang thao tác quá nhanh. Vui lòng chậm lại.");

                response.getWriter().write(objectMapper.writeValueAsString(errorResponse));
                return false; 
            }
        }

        return true; 
    }
}
