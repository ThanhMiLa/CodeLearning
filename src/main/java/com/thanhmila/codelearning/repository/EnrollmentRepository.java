package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.EnrollmentEntity;
import com.thanhmila.codelearning.entity.enums.EnrollmentStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;

public interface EnrollmentRepository extends JpaRepository<EnrollmentEntity, Long> {
    Boolean existsByUserIdAndCourseIdAndStatusIn(Long userId, Long courseId, Collection<EnrollmentStatus> statuses);
}
