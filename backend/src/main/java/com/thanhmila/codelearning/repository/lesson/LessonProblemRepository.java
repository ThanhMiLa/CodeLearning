package com.thanhmila.codelearning.repository.lesson;

import com.thanhmila.codelearning.entity.lesson.LessonProblemEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LessonProblemRepository extends JpaRepository<LessonProblemEntity, Long> {
    boolean existsByLessonIdAndProblemId(Long lessonId, Long problemId);
}
