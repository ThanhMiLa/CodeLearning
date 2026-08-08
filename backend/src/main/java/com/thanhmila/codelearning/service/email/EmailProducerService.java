package com.thanhmila.codelearning.service.email;

import com.thanhmila.codelearning.dto.request.EmailCampaignRequest;

public interface EmailProducerService {
    void processAndSendCampaign(EmailCampaignRequest request);
}
