package com.thanhmila.codelearning.repository.oj;

import com.thanhmila.codelearning.entity.oj.OnlineJudgeSubmissionEntity;

import io.lettuce.core.dynamic.annotation.Param;
import jakarta.persistence.LockModeType;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface OnlineJudgeSubmissionRepository extends JpaRepository<OnlineJudgeSubmissionEntity, Long> {
    List<OnlineJudgeSubmissionEntity> findByProblemIdOrderBySubmittedAtDesc(Long problemId);
    List<OnlineJudgeSubmissionEntity> findByUserIdOrderBySubmittedAtDesc(Long userId);

    @Query("SELECT s FROM OnlineJudgeSubmissionEntity s WHERE s.id = :id")
    Optional<OnlineJudgeSubmissionEntity> findById(@Param("id") Long id);
}

