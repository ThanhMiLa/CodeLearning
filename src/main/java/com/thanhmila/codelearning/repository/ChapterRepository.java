package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.course.ChapterEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ChapterRepository extends JpaRepository<ChapterEntity, Long> {
    @Query( "SELECT ch " +
            "FROM ChapterEntity ch " +
            "LEFT JOIN FETCH ch.lessons l " +
            "WHERE ch.course.id = :courseId AND l.status = 'ACTIVE'" +
            "ORDER BY ch.orderIndex ASC, " +
                      "l.orderIndex ASC")
    List<ChapterEntity> findChaptersWithLessonsByCourseId(@Param("courseId") Long courseId);
}
