package com.thanhmila.codelearning.service.payment.client;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class PayOsPaymentInfo {

    private String id;
    private Long orderCode;
    private BigDecimal amount;
    private BigDecimal amountPaid;
    private BigDecimal amountRemaining;
    private String status;
    private String createdAt;
    private String cancellationReason;
}
