package com.thanhmila.codelearning.repository.assignment;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FileSubmissionRepository extends JpaRepository<FileSubmissionEntity, Long> {
    List<FileSubmissionEntity> findByFileAssignmentIdOrderBySubmittedAtDesc(Long fileAssignmentId);
}

