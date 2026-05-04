package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.progress.CompletedLessonsCountEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
    
@Repository
public interface CompletedLessonCountRepository extends JpaRepository<CompletedLessonsCountEntity, Long> {
    Optional<CompletedLessonsCountEntity> getByUserIdAndCourseId(Long userId, Long courseId);

    List<CompletedLessonsCountEntity> findByUserIdAndCourseIdIn(Long userId, List<Long> courseIds);
}
