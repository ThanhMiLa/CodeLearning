package com.thanhmila.codelearning.repository.course;

import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.course.EnrollmentEntity;
import com.thanhmila.codelearning.entity.enums.EnrollmentStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
import java.util.Set;

@Repository
public interface EnrollmentRepository extends JpaRepository<EnrollmentEntity, Long> {
    Boolean existsByUserIdAndCourseIdAndStatusIn(Long userId, Long courseId, Collection<EnrollmentStatus> statuses);

    @Query("SELECT e.course.id FROM EnrollmentEntity e " +
            "WHERE e.user.id = :userId " +
            "AND e.course.id IN (:courseIds) " +
            "AND e.status IN (:statuses)")
    Set<Long> findEnrolledCourseIdsByUserIdAndCourseIds(
            @Param("userId") Long userId,
            @Param("courseIds") List<Long> courseIds,
            @Param("statuses") List<EnrollmentStatus> statuses);

    @Query(value = """
            SELECT EXISTS (
                SELECT 1
                FROM enrollments e
                JOIN chapters ch ON e.course_id = ch.course_id
                JOIN lessons l ON l.chapter_id = ch.id
                WHERE e.user_id = :userId
                  AND l.id = :lessonId
                  AND e.status IN ('ACTIVE', 'COMPLETED')
            )
            """, nativeQuery = true)
    boolean isUserEnrolledInLesson(@Param("userId") Long userId, @Param("lessonId") Long lessonId);

    @Query(value = """
            SELECT EXISTS (
                SELECT 1
                FROM enrollments e
                JOIN chapters ch ON e.course_id = ch.course_id
                JOIN lessons l ON l.chapter_id = ch.id
                JOIN lesson_problems lp ON lp.lesson_id = l.id
                WHERE lp.problem_id = :problemId
                  AND e.user_id = :userId
                  AND e.status IN ('ACTIVE', 'COMPLETED')
            )
            """, nativeQuery = true)
    boolean isUserEnrolledByProblemId(@Param("userId") Long userId, @Param("problemId") Long problemId);

    @Modifying
    @Query("UPDATE EnrollmentEntity e SET e.status = :status WHERE e.user.id = :userId AND e.course.id = :courseId")
    void updateStatusByUserIdAndCourseId(@Param("userId") Long userId,
            @Param("courseId") Long courseId,
            @Param("status") EnrollmentStatus status);

    @Query(value = """
            SELECT EXISTS (
                SELECT 1
                FROM enrollments e
                JOIN chapters ch ON e.course_id = ch.course_id
                JOIN lessons l ON l.chapter_id = ch.id
                JOIN quizzes q ON q.lesson_id = l.id
                WHERE q.id = :quizId
                  AND e.user_id = :userId
                  AND e.status IN ('ACTIVE', 'COMPLETED')
            )
            """, nativeQuery = true)
    boolean isUserEnrolledInQuiz(@Param("userId") Long userId, @Param("quizId") Long quizId);

    @Query("SELECT c FROM EnrollmentEntity e JOIN e.course c WHERE e.user.id = :userId AND e.status IN ('ACTIVE', 'COMPLETED')")
    Set<CourseEntity> findActiveCoursesByUserId(@Param("userId") Long userId);

    @Query(value = "SELECT e " +
            "FROM EnrollmentEntity e " +
            "JOIN FETCH e.course " +
            "WHERE e.user.id = :userId " +
            "AND e.status IN (:statuses)",
           countQuery = "SELECT COUNT(e) " +
                   "FROM EnrollmentEntity e " +
                   "WHERE e.user.id = :userId " +
                   "AND e.status IN (:statuses)")
    Page<EnrollmentEntity> findActiveEnrollmentsByUserId(
            @Param("userId") Long userId,
            @Param("statuses") List<EnrollmentStatus> statuses,
            Pageable pageable);
}
