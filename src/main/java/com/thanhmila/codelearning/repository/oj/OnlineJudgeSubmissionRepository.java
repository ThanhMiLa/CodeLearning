package com.thanhmila.codelearning.repository.oj;

import com.thanhmila.codelearning.entity.oj.OnlineJudgeSubmissionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OnlineJudgeSubmissionRepository extends JpaRepository<OnlineJudgeSubmissionEntity, Long> {
    List<OnlineJudgeSubmissionEntity> findByProblemIdOrderBySubmittedAtDesc(Long problemId);
    List<OnlineJudgeSubmissionEntity> findByUserIdOrderBySubmittedAtDesc(Long userId);
}

