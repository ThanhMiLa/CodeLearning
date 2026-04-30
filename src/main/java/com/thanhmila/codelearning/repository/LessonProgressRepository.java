package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.LessonProgressEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LessonProgressRepository extends JpaRepository<LessonProgressEntity, Long> {
}
