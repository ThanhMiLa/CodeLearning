package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.progress.LessonProgressEntity;
import org.springframework.data.repository.query.Param;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface LessonProgressRepository extends JpaRepository<LessonProgressEntity, Long> {

      @Query("SELECT lp.lesson.id " +
                  "FROM LessonProgressEntity lp " +
                  "WHERE lp.course.id = :courseId " +
                  "AND lp.user.id = :userId")
      Set<Long> findCompletedLessonIds(@Param("userId") Long userId,
                  @Param("courseId") Long courseId);

      Boolean existsByLessonIdAndUserId(Long lessonId, Long userId);

}
