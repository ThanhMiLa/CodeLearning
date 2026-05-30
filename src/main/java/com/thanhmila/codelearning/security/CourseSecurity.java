package com.thanhmila.codelearning.security;

import com.thanhmila.codelearning.repository.course.EnrollmentRepository;
import com.thanhmila.codelearning.repository.course.TeacherCourseAssignmentRepository;
import com.thanhmila.codelearning.repository.user.TeacherRepository;
import com.thanhmila.codelearning.repository.contest.ContestParticipantRepository;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeProblemRepository;
import java.util.List;
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
    TeacherRepository teacherRepository;
    TeacherCourseAssignmentRepository teacherCourseAssignmentRepository;
    ContestParticipantRepository contestParticipantRepository;
    OnlineJudgeProblemRepository onlineJudgeProblemRepository;

    public boolean canAccessContest(Long problemId){
        Long userId = getCurrentUserId();
        log.info("[CourseSecurity] canAccessContest - userId: {}, problemId: {}", userId, problemId);
        if (userId == null || problemId == null) {
            log.warn("[CourseSecurity] canAccessContest - userId or problemId is null!");
            return false;
        }

        List<Long> contestIds = onlineJudgeProblemRepository.findContestIdsByProblemId(problemId);
        if (contestIds == null || contestIds.isEmpty()) {
             log.warn("[CourseSecurity] canAccessContest - problem is not part of a contest!");
             return false;
        }

        boolean result = contestParticipantRepository.isUserParticipantOfAnyContest(userId, contestIds);
        log.info("[CourseSecurity] canAccessContest - result: {}", result);
        return result;
    }


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

        var accessDetailsOpt = onlineJudgeProblemRepository.findAccessDetailsByProblemId(problemId);
        if (accessDetailsOpt.isEmpty()) {
            log.warn("[CourseSecurity] canAccessProblem - problem not found: {}", problemId);
            return false;
        }

        var details = accessDetailsOpt.get();

        if (Boolean.TRUE.equals(details.getIsPublic())) {
            log.info("[CourseSecurity] canAccessProblem - problem is public, granting access");
            return true;
        }

        if (enrollmentRepository.isUserEnrolledByProblemId(userId, problemId)) {
            log.info("[CourseSecurity] canAccessProblem - lesson check: true");
            return true;
        }

        List<Long> contestIds = onlineJudgeProblemRepository.findContestIdsByProblemId(problemId);
        if (contestIds != null && !contestIds.isEmpty()) {
            boolean result = contestParticipantRepository.isUserParticipantOfAnyContest(userId, contestIds);
            log.info("[CourseSecurity] canAccessProblem - contest check: {}", result);
            return result;
        }

        log.info("[CourseSecurity] canAccessProblem - practice problem (non-public but no lesson/contest), granting access");
        return true;
    }

    public boolean canAccessQuiz(Long quizId){
        Long userId = getCurrentUserId();
        log.info("[CourseSecurity] canAccessQuiz - userId: {}, quizId: {}", userId, quizId);
        if (userId == null || quizId == null) {
            log.warn("[CourseSecurity] canAccessQuiz - userId or quizId is null!");
            return false;
        }
        boolean result = enrollmentRepository.isUserEnrolledInQuiz(userId, quizId);
        log.info("[CourseSecurity] canAccessQuiz - result: {}", result);
        return result;
    }   

    public boolean canManageLesson(Long lessonId){
        Long userId = getCurrentUserId();
        log.info("[CourseSecurity] canManageLesson - userId: {}, lessonId: {}", userId, lessonId);
        if (userId == null || lessonId == null) {
            log.warn("[CourseSecurity] canManageLesson - userId or lessonId is null!");
            return false;
        }

        Long teacherId = teacherRepository.findIdByUserId(userId);

        if (teacherId == null) {
            log.warn("[CourseSecurity] canManageLesson - teacherId is null!");
            return false;
        }

        boolean result = teacherCourseAssignmentRepository.existsByTeacherIdAndLessonId(teacherId, lessonId);
        log.info("[CourseSecurity] canManageLesson - result: {}", result);
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
