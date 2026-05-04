package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.exercise.QuizAttemptEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface QuizAttemptRepository extends JpaRepository<QuizAttemptEntity, Long> {

    @Query("""
            SELECT qa 
            FROM QuizAttemptEntity qa 
            JOIN qa.quiz q ON q.id = :quizId
            WHERE qa.user.id = :userId
            ORDER BY qa.submittedAt DESC
            LIMIT 1
            """)
    Optional<QuizAttemptEntity> findLatestAttemptByLesson(Long quizId, Long userId);

}
