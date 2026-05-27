package com.thanhmila.codelearning.entity.contest;


import com.thanhmila.codelearning.entity.user.TeacherEntity;
import com.thanhmila.codelearning.entity.enums.ContestStatus;
import com.thanhmila.codelearning.entity.enums.ScoringRule;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;
import java.time.ZonedDateTime;
import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "contests")
public class ContestEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @Column(nullable = false)
    String title;

    @Column(columnDefinition = "TEXT")
    String description;

    @Column(name = "password_hash")
    String passwordHash;

    @Column(name = "start_time", nullable = false)
    ZonedDateTime startTime;

    @Column(name = "end_time", nullable = false)
    ZonedDateTime endTime;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "status", nullable = false, columnDefinition = "contest_status")
    @Builder.Default
    ContestStatus status = ContestStatus.UPCOMING;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "scoring_rule", nullable = false, columnDefinition = "scoring_rule")
    @Builder.Default
    ScoringRule scoringRule = ScoringRule.ICPC;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by_teacher_id", nullable = false)
    TeacherEntity createdByTeacher;

    @Column(name = "created_at", nullable = false, updatable = false)
    ZonedDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    ZonedDateTime updatedAt;

    @OneToMany(mappedBy = "contest", cascade = CascadeType.ALL)
    List<ContestProblemEntity> contestProblems;

    @OneToMany(mappedBy = "contest")
    List<ContestParticipantEntity> participants;

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
