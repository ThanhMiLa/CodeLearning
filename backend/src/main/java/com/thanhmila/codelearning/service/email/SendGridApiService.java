package com.thanhmila.codelearning.service.email;

import com.thanhmila.codelearning.dto.email.SendGridEmailRequest;

public interface SendGridApiService {
    void sendEmailBulk(SendGridEmailRequest request);
    Object getTemplates();
}
