package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.progress.CompletedLessonsCountEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.Set;
    
@Repository
public interface CompletedLessonCountRepository extends JpaRepository<CompletedLessonsCountEntity, Long> {
    Optional<CompletedLessonsCountEntity> getByUserIdAndCourseId(Long userId, Long courseId);

    List<CompletedLessonsCountEntity> findByUserIdAndCourseIdIn(Long userId, Set<Long> courseIds);

    @Query(value = "UPDATE completed_lessons_count " +
                   "SET completed_lessons_count = completed_lessons_count + 1, updated_at = CURRENT_TIMESTAMP " +
                   "WHERE user_id = :userId AND course_id = :courseId " +
                   "RETURNING completed_lessons_count", 
           nativeQuery = true)
    Integer incrementAndGetCount(@Param("userId") Long userId, @Param("courseId") Long courseId);
}
