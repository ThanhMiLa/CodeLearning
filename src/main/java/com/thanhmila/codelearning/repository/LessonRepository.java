package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.course.LessonEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface LessonRepository extends JpaRepository<LessonEntity, Long> {
    @Query("""
        SELECT COUNT(l)
        FROM LessonEntity l
        JOIN l.chapter c
        WHERE c.course.id = :courseId
          AND l.status = 'ACTIVE'
        """)
    Long countActiveLessonsByCourseId(@Param("courseId") Long courseId);
}
