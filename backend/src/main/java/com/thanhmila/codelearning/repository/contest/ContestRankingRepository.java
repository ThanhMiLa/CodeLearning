package com.thanhmila.codelearning.repository.contest;

import com.thanhmila.codelearning.entity.contest.ContestRankingEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ContestRankingRepository extends JpaRepository<ContestRankingEntity, Long> {
    List<ContestRankingEntity> findByContestId(Long contestId);
    Optional<ContestRankingEntity> findByContestIdAndUserId(Long contestId, Long userId);
    
    // Retrieves ranked participants sorted by ICPC rules:
    // 1. Most problems solved (Desc)
    // 2. Lowest total penalty (Asc)
    // 3. Reached the score earlier (updatedAt Asc)
    List<ContestRankingEntity> findByContestIdOrderByProblemsSolvedDescTotalPenaltyAscUpdatedAtAsc(Long contestId);
}
