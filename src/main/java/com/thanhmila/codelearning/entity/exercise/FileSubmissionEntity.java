package com.thanhmila.codelearning.entity.exercise;

import com.thanhmila.codelearning.entity.user.TeacherEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.entity.enums.FileSubmissionStatus;
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
@Table(name = "file_submissions")
public class FileSubmissionEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "file_assignment_id", nullable = false)
    FileAssignmentEntity fileAssignment;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    UserEntity user;

    @Column(name = "attempt_no", nullable = false)
    Integer attemptNo;

    @Column(name = "file_url", length = 500, nullable = false)
    String fileUrl;

    @Column(name = "file_name", nullable = false)
    String fileName;

    @Column(name = "submitted_at", nullable = false, updatable = false)
    ZonedDateTime submittedAt;

    @Column(columnDefinition = "TEXT")
    String feedback;

    @Column(name = "graded_at")
    ZonedDateTime gradedAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "graded_by_teacher_id")
    TeacherEntity gradedByTeacher;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    @Builder.Default
    FileSubmissionStatus status = FileSubmissionStatus.SUBMITTED;

    @PrePersist
    protected void onCreate() {
        submittedAt = ZonedDateTime.now();
    }
}