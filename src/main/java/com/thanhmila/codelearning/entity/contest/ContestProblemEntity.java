package com.thanhmila.codelearning.entity.contest;

import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import java.math.BigDecimal;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "contest_problems")
public class ContestProblemEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "contest_id", nullable = false)
    ContestEntity contest;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "problem_id", nullable = false)
    OnlineJudgeProblemEntity problem;

    @Column(name = "order_index", nullable = false)
    Integer orderIndex;

    @Column(precision = 6, scale = 2, nullable = false)
    @Builder.Default
    BigDecimal point = BigDecimal.valueOf(100.00);
}
