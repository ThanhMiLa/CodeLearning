package com.thanhmila.codelearning.repository.quiz;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.thanhmila.codelearning.entity.exercise.QuizOptionEntity;

@Repository
public interface QuizOptionRepository extends JpaRepository<QuizOptionEntity, Long> {
}
