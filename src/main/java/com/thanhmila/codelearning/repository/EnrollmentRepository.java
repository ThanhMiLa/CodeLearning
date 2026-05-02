package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.EnrollmentEntity;
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
}
