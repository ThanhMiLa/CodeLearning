package com.thanhmila.codelearning.repository.contest;

import com.thanhmila.codelearning.entity.contest.ContestProblemAttemptEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ContestProblemAttemptRepository extends JpaRepository<ContestProblemAttemptEntity, Long> {
    List<ContestProblemAttemptEntity> findByContestId(Long contestId);
    List<ContestProblemAttemptEntity> findByContestIdAndUserId(Long contestId, Long userId);
    Optional<ContestProblemAttemptEntity> findByContestIdAndUserIdAndProblemId(Long contestId, Long userId, Long problemId);
}
