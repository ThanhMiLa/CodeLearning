package com.thanhmila.codelearning.repository.oj;

import com.thanhmila.codelearning.entity.oj.OnlineJudgeSubmissionEntity;
import org.springframework.data.repository.query.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import com.thanhmila.codelearning.entity.enums.OjVerdict;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

@Repository
public interface OnlineJudgeSubmissionRepository extends JpaRepository<OnlineJudgeSubmissionEntity, Long>, JpaSpecificationExecutor<OnlineJudgeSubmissionEntity> {
    List<OnlineJudgeSubmissionEntity> findByProblemIdOrderBySubmittedAtDesc(Long problemId);
    List<OnlineJudgeSubmissionEntity> findByUserIdOrderBySubmittedAtDesc(Long userId);

    Page<OnlineJudgeSubmissionEntity> findByUserIdAndProblemIdOrderBySubmittedAtDesc(Long userId, Long problemId, Pageable pageable);

    Page<OnlineJudgeSubmissionEntity> findByUserIdAndContestIdOrderBySubmittedAtDesc(Long userId, Long contestId, Pageable pageable);

    @Query("SELECT s FROM OnlineJudgeSubmissionEntity s WHERE s.id = :id")
    Optional<OnlineJudgeSubmissionEntity> findById(@Param("id") Long id);

    @Query("SELECT DISTINCT s.problem.id FROM OnlineJudgeSubmissionEntity s WHERE s.user.id = :userId AND s.problem.id IN :problemIds AND s.verdict = :verdict")
    Set<Long> findProblemIdsByUserIdAndProblemIdsAndVerdict(@Param("userId") Long userId, @Param("problemIds") List<Long> problemIds, @Param("verdict") OjVerdict verdict);
}

