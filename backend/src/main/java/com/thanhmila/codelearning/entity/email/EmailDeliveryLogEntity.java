package com.thanhmila.codelearning.entity.email;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.OffsetDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
@Table(name = "email_delivery_logs")
public class EmailDeliveryLogEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @Column(name = "email", nullable = false, length = 255)
    String email;

    @Column(name = "event_type", nullable = false, length = 50)
    String eventType; // delivered, bounce, dropped, spamreport, deferred

    @Column(name = "reason", columnDefinition = "text")
    String reason; // Lỗi chi tiết từ SendGrid (nếu có)

    @Column(name = "sg_event_id", length = 255)
    String sgEventId;

    @Column(name = "sg_message_id", length = 255)
    String sgMessageId;

    @Column(name = "timestamp")
    Long timestamp; // Unix timestamp từ SendGrid

    @Column(name = "created_at", nullable = false, updatable = false)
    OffsetDateTime createdAt;

    @PrePersist
    void prePersist() {
        if (createdAt == null) {
            createdAt = OffsetDateTime.now();
        }
    }
}
