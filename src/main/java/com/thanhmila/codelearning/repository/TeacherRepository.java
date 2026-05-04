package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.user.TeacherEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository 
public interface TeacherRepository extends JpaRepository<TeacherEntity, Long> {
}
