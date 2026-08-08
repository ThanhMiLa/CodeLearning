package com.thanhmila.codelearning.dto.email;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class SendGridWebhookEvent {
    private String email;
    private Long timestamp;
    private String event;
    private String sg_event_id;
    private String sg_message_id;
    private String reason;
}
