package com.thanhmila.codelearning.repository.contest;

import com.thanhmila.codelearning.entity.contest.ContestProblemEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContestProblemRepository extends JpaRepository<ContestProblemEntity, Long> {
    List<ContestProblemEntity> findByContestIdOrderByOrderIndex(Long contestId);
    boolean existsByContestIdAndProblemId(Long contestId, Long problemId);
}

