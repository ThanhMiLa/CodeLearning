package com.thanhmila.codelearning.entity;

import com.thanhmila.codelearning.entity.enums.EnrollmentStatus;
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
        name = "enrollments",
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "uq_enrollments_user_course",
                        columnNames = {"user_id", "course_id"}
                )
        }
)
public class EnrollmentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    UserEntity user;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "course_id", nullable = false)
    CourseEntity course;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "payment_id")
    PaymentEntity payment;

    @Column(name = "enrolled_at", nullable = false)
    OffsetDateTime enrolledAt;

    @Builder.Default
    @Enumerated(EnumType.STRING)
    @JdbcTypeCode(SqlTypes.NAMED_ENUM)
    @Column(name = "status", nullable = false, columnDefinition = "enrollment_status")
    EnrollmentStatus status = EnrollmentStatus.ACTIVE;

    @PrePersist
    void prePersist() {
        if (enrolledAt == null) {
            enrolledAt = OffsetDateTime.now();
        }

        if (status == null) {
            status = EnrollmentStatus.ACTIVE;
        }
    }
}