package com.thanhmila.codelearning.entity.exercise;

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
@Table(name = "quiz_options")
public class QuizOptionEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id", nullable = false)
    QuizQuestionEntity question;

    @Column(columnDefinition = "TEXT", nullable = false)
    String content;

    @Column(name = "is_correct", nullable = false)
    @Builder.Default
    Boolean isCorrect = false;

    @Column(name = "order_index")
    Integer orderIndex;
}