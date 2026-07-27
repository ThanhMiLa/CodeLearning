package com.thanhmila.codelearning.dto.response;

import com.thanhmila.codelearning.entity.enums.PaymentTransactionType;
import com.thanhmila.codelearning.entity.enums.TransactionStatus;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;
import java.time.OffsetDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AdminPaymentTransactionResponse {
    Long id;
    String transactionCode;
    String userDisplayName;
    Long userId;
    BigDecimal amount;
    PaymentTransactionType type;
    TransactionStatus status;
    String note;
    OffsetDateTime createdAt;
}
