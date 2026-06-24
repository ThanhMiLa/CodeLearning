package com.thanhmila.codelearning.entity.contest;

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
@Table(name = "contest_rankings", uniqueConstraints = {
        @UniqueConstraint(name = "uq_contest_rankings_contest_user", columnNames = {"contest_id", "user_id"})
})
public class ContestRankingEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "contest_id", nullable = false)
    ContestEntity contest;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    UserEntity user;

    @Column(name = "problems_solved", nullable = false)
    @Builder.Default
    Integer problemsSolved = 0;

    @Column(name = "total_penalty", nullable = false)
    @Builder.Default
    Integer totalPenalty = 0;

    @Column(name = "updated_at", nullable = false)
    ZonedDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        updatedAt = ZonedDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = ZonedDateTime.now();
    }
}
