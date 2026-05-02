package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.ChapterEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ChapterRepository extends JpaRepository<ChapterEntity, Long> {
    @Query( "SELECT ch " +
            "FROM ChapterEntity ch " +
            "LEFT JOIN FETCH ch.lessons l " +
            "WHERE ch.course.id = :courseId " +
            "ORDER BY ch.orderIndex ASC, " +
                      "l.orderIndex ASC")
    List<ChapterEntity> findChaptersWithLessonsByCourseId(@Param("courseId") Long courseId);
}
