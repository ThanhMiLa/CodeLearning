package com.thanhmila.codelearning.entity.exercise;

import com.thanhmila.codelearning.entity.course.LessonEntity;
import com.thanhmila.codelearning.entity.user.TeacherEntity;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import java.time.ZonedDateTime;
import java.util.List;
import org.hibernate.annotations.SQLDelete;
import org.hibernate.annotations.SQLRestriction;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "quizzes")
@SQLDelete(sql = "UPDATE quizzes SET is_deleted = true WHERE id = ?")
@SQLRestriction("is_deleted = false")
public class QuizEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lesson_id", nullable = false, unique = true)
    LessonEntity lesson;

    @Column(nullable = false)
    String title;

    @Column(columnDefinition = "TEXT")
    String description;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by_teacher_id", nullable = false)
    TeacherEntity createdByTeacher;

    @Column(name = "created_at", nullable = false, updatable = false)
    ZonedDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    ZonedDateTime updatedAt;

    @OneToMany(mappedBy = "quiz", cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("orderIndex ASC")
    List<QuizQuestionEntity> questions;

    @Column(name = "is_deleted")
    @Builder.Default
    private boolean isDeleted = false;

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