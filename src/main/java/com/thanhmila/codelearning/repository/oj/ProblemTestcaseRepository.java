package com.thanhmila.codelearning.repository.oj;

import com.thanhmila.codelearning.entity.oj.ProblemTestcaseEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProblemTestcaseRepository extends JpaRepository<ProblemTestcaseEntity, Long> {
    List<ProblemTestcaseEntity> findByProblemIdOrderByOrderIndex(Long problemId);
}

