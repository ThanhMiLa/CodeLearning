package com.thanhmila.codelearning.service.email;

import com.thanhmila.codelearning.dto.email.SendGridWebhookEvent;

import java.util.List;

public interface SendGridWebhookService {
    void processWebhookEvents(List<SendGridWebhookEvent> events);
}
