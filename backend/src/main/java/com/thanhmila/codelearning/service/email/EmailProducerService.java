package com.thanhmila.codelearning.service.email;

public interface EmailProducerService {
    void processAndSendBulkEmail(String templateId);
}
