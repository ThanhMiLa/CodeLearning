package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.CompletedLessonsCountEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CompletedLessonCountRepository extends JpaRepository<CompletedLessonsCountEntity, Long> {
    Optional<CompletedLessonsCountEntity> getByUserIdAndCourseId(Long userId, Long courseId);

    List<CompletedLessonsCountEntity> findByUserIdAndCourseIdIn(Long userId, List<Long> courseIds);
}
