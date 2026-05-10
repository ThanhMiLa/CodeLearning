package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.course.LessonEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface LessonRepository extends JpaRepository<LessonEntity, Long> {
  @Query("""
      SELECT COUNT(l)
      FROM LessonEntity l
      JOIN l.chapter c
      WHERE c.course.id = :courseId
        AND l.status = 'ACTIVE'
      """)
  Long countActiveLessonsByCourseId(@Param("courseId") Long courseId);

  @Query("SELECT l " +
      "FROM LessonEntity l " +
      "JOIN FETCH l.chapter c " +
      "JOIN FETCH c.course " +
      "WHERE l.id = :id")
  Optional<LessonEntity> findDetailWithCourseById(@Param("id") Long id);

  @Query("""
      SELECT l.chapter.course
      FROM LessonEntity l
      WHERE l.id = :lessonId
      """)
  Optional<CourseEntity> findCourseByLessonId(Long lessonId);

}
