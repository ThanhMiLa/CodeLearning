package com.thanhmila.codelearning.repository.contest;

import com.thanhmila.codelearning.entity.contest.ContestParticipantEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ContestParticipantRepository extends JpaRepository<ContestParticipantEntity, Long> {
    List<ContestParticipantEntity> findByContestId(Long contestId);
    Optional<ContestParticipantEntity> findByContestIdAndUserId(Long contestId, Long userId);

    @Query("SELECT COUNT(cp.id) > 0 FROM ContestParticipantEntity cp WHERE cp.user.id = :userId AND cp.contest.id IN :contestIds")
    boolean isUserParticipantOfAnyContest(@Param("userId") Long userId, @Param("contestIds") List<Long> contestIds);
}

