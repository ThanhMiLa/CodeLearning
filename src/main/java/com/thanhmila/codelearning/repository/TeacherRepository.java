package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.TeacherEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TeacherRepository extends JpaRepository<TeacherEntity, Long> {
}
