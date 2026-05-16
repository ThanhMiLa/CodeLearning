package com.thanhmila.codelearning.entity.exercise;

import com.thanhmila.codelearning.entity.lesson.LessonEntity;
import com.thanhmila.codelearning.entity.user.TeacherEntity;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import java.time.ZonedDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "file_assignments")
public class FileAssignmentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lesson_id", nullable = false)
    LessonEntity lesson;

    @Column(nullable = false)
    String title;

    @Column(columnDefinition = "TEXT")
    String description;

    @Column(name = "assignment_file_url", length = 500)
    String assignmentFileUrl;

    @Column(name = "assignment_file_name")
    String assignmentFileName;

    @Column(name = "allowed_extensions")
    String allowedExtensions;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by_teacher_id", nullable = false)
    TeacherEntity createdByTeacher;

    @Column(name = "created_at", nullable = false, updatable = false)
    ZonedDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    ZonedDateTime updatedAt;

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