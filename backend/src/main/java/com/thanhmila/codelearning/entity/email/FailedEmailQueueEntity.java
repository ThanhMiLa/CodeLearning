package com.thanhmila.codelearning.entity.email;

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
@Table(name = "failed_email_queues")
public class FailedEmailQueueEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @Column(name = "batch_id", nullable = false, length = 100)
    String batchId;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(name = "payload_json", nullable = false, columnDefinition = "jsonb")
    String payloadJson;

    @Column(name = "error_reason", columnDefinition = "text")
    String errorReason;

    @Column(name = "status", nullable = false, length = 50)
    @Builder.Default
    String status = "PENDING_RETRY";

    @Column(name = "retry_count", nullable = false)
    @Builder.Default
    Integer retryCount = 0;

    @Column(name = "created_at", nullable = false, updatable = false)
    OffsetDateTime createdAt;

    @PrePersist
    void prePersist() {
        if (createdAt == null) {
            createdAt = OffsetDateTime.now();
        }
        if (status == null) {
            status = "PENDING_RETRY";
        }
        if (retryCount == null) {
            retryCount = 0;
        }
    }
}
