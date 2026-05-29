package com.thanhmila.codelearning.entity.lesson;

import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
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
@Table(name = "lesson_problems", uniqueConstraints = {
        @UniqueConstraint(columnNames = {"lesson_id", "problem_id"})
})
public class LessonProblemEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lesson_id", nullable = false)
    LessonEntity lesson;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "problem_id", nullable = false)
    OnlineJudgeProblemEntity problem;

    @Column(name = "order_index", nullable = false)
    Integer orderIndex;
}
