package com.thanhmila.codelearning.entity.course;

import com.thanhmila.codelearning.entity.enums.LessonStatus;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.OffsetDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(
        name = "lessons",
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "uq_lessons_chapter_order",
                        columnNames = {"chapter_id", "order_index"}
                )
        }
)
public class LessonEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "chapter_id", nullable = false)
    ChapterEntity chapter;

    @Column(name = "title", nullable = false, length = 255)
    String title;

    @Column(name = "description", columnDefinition = "TEXT")
    String description;

    @Column(name = "video_url", length = 500)
    String videoUrl;

    @Column(name = "theory_content", columnDefinition = "TEXT")
    String theoryContent;

    @Column(name = "sample_code", columnDefinition = "TEXT")
    String sampleCode;

    @Builder.Default
    @Column(name = "is_trial", nullable = false)
    Boolean trial = false;

    @Column(name = "order_index", nullable = false)
    Integer orderIndex;

    @Column(name = "estimated_duration_minutes")
    Integer estimatedDurationMinutes;

    @Builder.Default
    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "status", nullable = false, columnDefinition = "lesson_status")
    LessonStatus status = LessonStatus.DRAFT;

    @Column(name = "created_at", nullable = false)
    OffsetDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    OffsetDateTime updatedAt;

    @PrePersist
    void prePersist() {
        OffsetDateTime now = OffsetDateTime.now();

        if (trial == null) {
            trial = false;
        }

        if (status == null) {
            status = LessonStatus.DRAFT;
        }

        if (createdAt == null) {
            createdAt = now;
        }

        if (updatedAt == null) {
            updatedAt = now;
        }
    }

    @PreUpdate
    void preUpdate() {
        updatedAt = OffsetDateTime.now();
    }
}