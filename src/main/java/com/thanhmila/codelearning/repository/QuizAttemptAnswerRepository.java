package com.thanhmila.codelearning.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.thanhmila.codelearning.entity.exercise.QuizAttemptAnswerEntity;

@Repository
public interface QuizAttemptAnswerRepository extends JpaRepository<QuizAttemptAnswerEntity, Long>  {
    
}
