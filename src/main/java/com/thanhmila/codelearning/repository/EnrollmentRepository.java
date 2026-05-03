package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.course.EnrollmentEntity;
import com.thanhmila.codelearning.entity.enums.EnrollmentStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;
import java.util.Set;

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



    @Query(value = "SELECT COUNT(e) > 0 " +
            "FROM enrollments e " +
            "JOIN chapters ch ON e.course_id = ch.course_id " +
            "JOIN lessons l ON l.chapter_id = ch.id " +
            "WHERE e.user_id = :userId " +
            "AND l.id = :lessonId " +
            "AND e.status IN ('ACTIVE', 'COMPLETED')",
            nativeQuery = true)
    boolean isUserEnrolledInLesson(@Param("userId") Long userId,
                                   @Param("lessonId") Long lessonId);
}
