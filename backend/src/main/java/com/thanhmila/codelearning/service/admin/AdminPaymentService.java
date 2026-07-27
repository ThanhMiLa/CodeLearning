package com.thanhmila.codelearning.service.admin;

import com.thanhmila.codelearning.dto.response.AdminPaymentTransactionResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.enums.PaymentTransactionType;
import com.thanhmila.codelearning.entity.enums.TransactionStatus;
import org.springframework.data.domain.Pageable;

public interface AdminPaymentService {
    PageResponse<AdminPaymentTransactionResponse> getPaymentTransactionsForAdmin(
            String keyword,
            TransactionStatus status,
            PaymentTransactionType type,
            Pageable pageable
    );
}
