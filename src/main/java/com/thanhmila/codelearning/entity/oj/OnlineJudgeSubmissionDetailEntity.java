package com.thanhmila.codelearning.entity.oj;

import com.thanhmila.codelearning.entity.enums.OjVerdict;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.ZonedDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "online_judge_submission_details")
public class OnlineJudgeSubmissionDetailEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    // Nối về Submission tổng (1 bài nộp có nhiều detail testcases)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "submission_id", nullable = false)
    OnlineJudgeSubmissionEntity submission;

    // Nối về Testcase cụ thể để biết đây là kết quả của bộ test nào
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "testcase_id", nullable = false)
    ProblemTestcaseEntity testcase;

    @Column(name = "token", nullable = false, unique = true)
    String token;

    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "verdict", nullable = false)
    OjVerdict verdict;

    @Column(name = "execution_time_ms")
    Integer executionTimeMs;

    @Column(name = "memory_used_kb")
    Integer memoryUsedKb;

    @Column(name = "created_at", nullable = false, updatable = false)
    @Builder.Default
    ZonedDateTime createdAt = ZonedDateTime.now();
}