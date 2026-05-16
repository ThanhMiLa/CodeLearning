package com.thanhmila.codelearning.entity.oj;

import com.thanhmila.codelearning.entity.contest.ContestEntity;
import com.thanhmila.codelearning.entity.lesson.LessonEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.entity.enums.OjVerdict;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;
import lombok.experimental.FieldDefaults;
import java.math.BigDecimal;
import java.time.ZonedDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "online_judge_submissions")
public class OnlineJudgeSubmissionEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    UserEntity user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "problem_id", nullable = false)
    OnlineJudgeProblemEntity problem;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lesson_id")
    LessonEntity lesson;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "contest_id")
    ContestEntity contest;

    @Column(name = "language_id", nullable = false)
    Integer languageId;

    @Column(name = "source_code", columnDefinition = "TEXT", nullable = false)
    String sourceCode;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "verdict", nullable = false)
    OjVerdict verdict;

    @Column(name = "execution_time_ms")
    Integer executionTimeMs;

    @Column(name = "memory_used_kb")
    Integer memoryUsedKb;

    @Column(precision = 6, scale = 2)
    BigDecimal score;

    @Column(name = "submitted_at", nullable = false, updatable = false)
    ZonedDateTime submittedAt;

    @PrePersist
    protected void onCreate() {
        submittedAt = ZonedDateTime.now();
    }
}