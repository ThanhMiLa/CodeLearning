package com.thanhmila.codelearning.repository.contest;

import com.thanhmila.codelearning.entity.contest.ContestProblemEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ContestProblemRepository extends JpaRepository<ContestProblemEntity, Long> {
    List<ContestProblemEntity> findByContestIdOrderByOrderIndex(Long contestId);
    boolean existsByContestIdAndProblemId(Long contestId, Long problemId);
    Optional<ContestProblemEntity> findByContestIdAndProblemId(Long contestId, Long problemId);

    @Query("SELECT COALESCE(MAX(cp.orderIndex), 0) " +
            "FROM ContestProblemEntity cp " +
            "WHERE cp.contest.id = :contestId")
    int findMaxOrderIndexByContestId(@Param("contestId") Long contestId);
}


