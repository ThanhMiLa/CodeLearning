package com.thanhmila.codelearning.entity.contest;

import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.ZonedDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "contest_problem_attempts", uniqueConstraints = {
        @UniqueConstraint(name = "uq_contest_problem_attempts", columnNames = {"contest_id", "user_id", "problem_id"})
})
public class ContestProblemAttemptEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "contest_id", nullable = false)
    ContestEntity contest;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    UserEntity user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "problem_id", nullable = false)
    OnlineJudgeProblemEntity problem;

    @Column(name = "is_solved", nullable = false)
    @Builder.Default
    Boolean isSolved = false;

    @Column(name = "solved_at_seconds")
    Integer solvedAtSeconds;

    @Column(name = "failed_attempts_count", nullable = false)
    @Builder.Default
    Integer failedAttemptsCount = 0;

    @Column(name = "created_at", nullable = false, updatable = false)
    ZonedDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    ZonedDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = ZonedDateTime.now();
        updatedAt = ZonedDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = ZonedDateTime.now();
    }
}
