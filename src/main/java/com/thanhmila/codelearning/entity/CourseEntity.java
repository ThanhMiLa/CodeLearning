package com.thanhmila.codelearning.entity;

import com.thanhmila.codelearning.entity.enums.CourseStatus;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "courses")
public class CourseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @Column(name = "title", nullable = false, length = 255)
    String title;

    @Column(name = "short_description", columnDefinition = "TEXT")
    String shortDescription;

    @Column(name = "course_content", columnDefinition = "TEXT")
    String courseContent;

    @Column(name = "learning_outcomes", columnDefinition = "TEXT")
    String learningOutcomes;

    @Column(name = "course_highlights", columnDefinition = "TEXT")
    String courseHighlights;

    @Column(name = "technologies_tools", columnDefinition = "TEXT")
    String technologiesTools;

    @Column(name = "prerequisites", columnDefinition = "TEXT")
    String prerequisites;

    @Column(name = "target_audience", columnDefinition = "TEXT")
    String targetAudience;

    @Column(name = "completion_benefits", columnDefinition = "TEXT")
    String completionBenefits;

    @Builder.Default
    @Column(name = "price", nullable = false, precision = 12, scale = 2)
    BigDecimal price = BigDecimal.ZERO;

    @Column(name = "thumbnail_url", length = 500)
    String thumbnailUrl;

    @Column(name = "estimated_duration_hours")
    Integer estimatedDurationHours;

    @Builder.Default
    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "status", nullable = false, columnDefinition = "course_status")
    CourseStatus status = CourseStatus.DRAFT;

    @Column(name = "created_at", nullable = false)
    OffsetDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    OffsetDateTime updatedAt;

    @Column(name = "average_rating", nullable = false)
    Double averageRating = 0.0;

    @Column(name = "total_reviews", nullable = false)
    Integer totalReviews = 0;

    @Column(name = "total_enrolled", nullable = false)
    Integer totalEnrolled = 0;

    @ManyToMany
    @JoinTable(
            name = "course_category_mappings",
            joinColumns = @JoinColumn(name = "course_id"),
            inverseJoinColumns = @JoinColumn(name = "category_id")
    )
    Set<CategoryEntity> categories = new HashSet<>();

    @OneToMany(mappedBy = "course", fetch = FetchType.LAZY)
    Set<TeacherCourseAssignmentEntity> teacherAssignments = new HashSet<>();

    @PrePersist
    void prePersist() {
        OffsetDateTime now = OffsetDateTime.now();

        if (price == null) {
            price = BigDecimal.ZERO;
        }

        if (status == null) {
            status = CourseStatus.DRAFT;
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