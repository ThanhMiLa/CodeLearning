package com.thanhmila.codelearning.entity.oj;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "problem_testcases")
public class ProblemTestcaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "problem_id", nullable = false)
    OnlineJudgeProblemEntity problem;

    @Column(name = "input_data", columnDefinition = "TEXT", nullable = false)
    String inputData;

    @Column(name = "expected_output", columnDefinition = "TEXT", nullable = false)
    String expectedOutput;

    @Column(name = "is_hidden", nullable = false)
    @Builder.Default
    Boolean isHidden = false;

    @Column(name = "order_index", nullable = false)
    Integer orderIndex;
}