package com.thanhmila.codelearning.repository.oj;

import com.thanhmila.codelearning.entity.oj.ProblemTagEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ProblemTagRepository extends JpaRepository<ProblemTagEntity, Long> {
    Optional<ProblemTagEntity> findBySlug(String slug);
}

