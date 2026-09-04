package com.thanhmila.codelearning.service.payment.client;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PayOsCreatePaymentRequest {

    private long orderCode;
    private int amount;
    private String description;
    private Long expiredAt;
}
