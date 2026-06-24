package com.thanhmila.codelearning.entity.oj;

import com.thanhmila.codelearning.entity.user.TeacherEntity;
import com.thanhmila.codelearning.entity.contest.ContestEntity;
import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;
import com.thanhmila.codelearning.entity.enums.ProblemScope;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;
import java.time.ZonedDateTime;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.hibernate.annotations.Formula;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "online_judge_problems")
public class OnlineJudgeProblemEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @Column(precision = 6, scale = 2)
    BigDecimal score;


    @Column(nullable = false)
    String title;

    @Column(columnDefinition = "TEXT")
    String description;

    @Column(name = "input_description", columnDefinition = "TEXT")
    String inputDescription;

    @Column(name = "output_description", columnDefinition = "TEXT")
    String outputDescription;

    @Column(columnDefinition = "TEXT")
    String constraints;

    @Column(name = "example_input", columnDefinition = "TEXT")
    String exampleInput;

    @Column(name = "example_output", columnDefinition = "TEXT")
    String exampleOutput;

    @Column(columnDefinition = "TEXT")
    String hint;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "problem_scope", nullable = false)
    ProblemScope problemScope;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(nullable = false)
    ProblemDifficulty difficulty;

    @Column(name = "is_active", nullable = false)
    @Builder.Default
    Boolean isActive = false;

    @Column(name = "is_public", nullable = false)
    @Builder.Default
    Boolean isPublic = false;

    @Column(name = "total_submissions", nullable = false)
    @Builder.Default
    Integer totalSubmissions = 0;

    @Column(name = "total_accepted", nullable = false)
    @Builder.Default
    Integer totalAccepted = 0;

    @Formula("CASE WHEN total_submissions = 0 THEN 0 ELSE (total_accepted * 100.0 / total_submissions) END")
    Double acceptanceRate;

    @Formula("CASE difficulty WHEN 'EASY' THEN 1 WHEN 'MEDIUM' THEN 2 WHEN 'HARD' THEN 3 ELSE 0 END")
    Integer difficultyLevel;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by_teacher_id", nullable = false)
    TeacherEntity createdByTeacher;

    @Column(name = "created_at", nullable = false, updatable = false)
    ZonedDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    ZonedDateTime updatedAt;

    @OneToMany(mappedBy = "problem", cascade = CascadeType.ALL, orphanRemoval = true)
    List<ProblemTestcaseEntity> testcases;

    @ManyToMany
    @JoinTable(
            name = "problem_tag_mappings",
            joinColumns = @JoinColumn(name = "problem_id"),
            inverseJoinColumns = @JoinColumn(name = "tag_id")
    )
    @Builder.Default
    Set<ProblemTagEntity> tags = new HashSet<>();

    @Column(name = "total_testcase", nullable = false)
    @Builder.Default
    Integer totalTestCase = 0;

    @Column(name = "time_limit_ms", nullable = false)
    @Builder.Default
    Integer timeLimitMs = 2000;

    @Column(name = "memory_limit_kb", nullable = false)
    @Builder.Default
    Integer memoryLimitKb = 128000;

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