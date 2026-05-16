package com.thanhmila.codelearning.repository.contest;

import com.thanhmila.codelearning.entity.contest.ContestParticipantEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ContestParticipantRepository extends JpaRepository<ContestParticipantEntity, Long> {
    List<ContestParticipantEntity> findByContestId(Long contestId);
    Optional<ContestParticipantEntity> findByContestIdAndUserId(Long contestId, Long userId);
}

