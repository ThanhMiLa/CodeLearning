package com.thanhmila.codelearning.entity.exercise;

import com.thanhmila.codelearning.entity.user.UserEntity;
import jakarta.persistence.*;
import lombok.*;
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
@Table(name = "quiz_attempts")
public class QuizAttemptEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    UserEntity user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "quiz_id", nullable = false)
    QuizEntity quiz;

    @Column(name = "total_questions", nullable = false)
    Integer totalQuestions;

    @Column(name = "correct_answers", nullable = false)
    Integer correctAnswers;

    @Column(precision = 5, scale = 2, nullable = false)
    BigDecimal score;

    @Column(name = "submitted_at", nullable = false, updatable = false)
    ZonedDateTime submittedAt;

    @PrePersist
    protected void onCreate() {
        submittedAt = ZonedDateTime.now();
    }
}