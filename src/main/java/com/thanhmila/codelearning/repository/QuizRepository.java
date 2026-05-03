package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.exercise.QuizEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface QuizRepository extends JpaRepository<QuizEntity, Long> {

    @Query("SELECT q FROM QuizEntity q " +
            "JOIN FETCH q.questions " +
            "WHERE q.lesson.id = :lessonId")
    Optional<QuizEntity> findQuizByLessonId(@Param("lessonId") Long lessonId);

}
