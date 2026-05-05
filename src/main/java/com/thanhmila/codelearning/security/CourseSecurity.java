package com.thanhmila.codelearning.security;

import com.thanhmila.codelearning.repository.EnrollmentRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.stereotype.Component;

@Slf4j
@Component("courseSecurity")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class CourseSecurity {
    EnrollmentRepository enrollmentRepository;

    public boolean canAccessLesson(Long lessonId){
        Long userId = getCurrentUserId();
        log.info("[CourseSecurity] canAccessLesson - userId: {}, lessonId: {}", userId, lessonId);
        if (userId == null || lessonId == null) {
            log.warn("[CourseSecurity] canAccessLesson - userId or lessonId is null!");
            return false;
        }
        boolean result = enrollmentRepository.isUserEnrolledInLesson(userId, lessonId);
        log.info("[CourseSecurity] canAccessLesson - result: {}", result);
        return result;
    }

    public boolean canAccessProblem(Long problemId){
        Long userId = getCurrentUserId();
        log.info("[CourseSecurity] canAccessProblem - userId: {}, problemId: {}", userId, problemId);
        if (userId == null || problemId == null) {
            log.warn("[CourseSecurity] canAccessProblem - userId or problemId is null!");
            return false;
        }
        boolean result = enrollmentRepository.isUserEnrolledByProblemId(userId, problemId);
        log.info("[CourseSecurity] canAccessProblem - result: {}", result);
        return result;
    }

    private Long getCurrentUserId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth == null || !auth.isAuthenticated() || !(auth.getPrincipal() instanceof Jwt jwt)) {
            log.warn("[CourseSecurity] No valid JWT authentication found");
            return null;
        }
        Object userIdClaim = jwt.getClaim("userId");
        log.info("[CourseSecurity] userId claim type: {}, value: {}", 
                userIdClaim != null ? userIdClaim.getClass().getSimpleName() : "null", userIdClaim);
        if (userIdClaim instanceof Number) {
            return ((Number) userIdClaim).longValue();
        }
        return null;
    }
}
