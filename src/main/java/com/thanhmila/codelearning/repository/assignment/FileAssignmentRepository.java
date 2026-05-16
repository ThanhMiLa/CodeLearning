package com.thanhmila.codelearning.repository.assignment;

import com.thanhmila.codelearning.entity.exercise.FileAssignmentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FileAssignmentRepository extends JpaRepository<FileAssignmentEntity, Long> {
    List<FileAssignmentEntity> findByLessonId(Long lessonId);
}

