package com.thanhmila.codelearning.service.admin.impl;

import com.thanhmila.codelearning.dto.response.AdminPaymentTransactionResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.enums.PaymentTransactionType;
import com.thanhmila.codelearning.entity.enums.TransactionStatus;
import com.thanhmila.codelearning.entity.payment.PaymentTransactionEntity;
import com.thanhmila.codelearning.repository.payment.PaymentTransactionRepository;
import com.thanhmila.codelearning.service.admin.AdminPaymentService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AdminPaymentServiceImpl implements AdminPaymentService {

    PaymentTransactionRepository paymentTransactionRepository;

    @Override
    @Transactional(readOnly = true)
    public PageResponse<AdminPaymentTransactionResponse> getPaymentTransactionsForAdmin(
            String keyword,
            TransactionStatus status,
            PaymentTransactionType type,
            Pageable pageable) {

        String queryKeyword = (keyword != null && !keyword.trim().isEmpty()) ? keyword.trim() : null;

        Page<PaymentTransactionEntity> txPage;
        if (queryKeyword == null && status == null && type == null) {
            txPage = paymentTransactionRepository.findAllForAdmin(pageable);
        } else {
            txPage = paymentTransactionRepository.searchForAdmin(queryKeyword, status, type, pageable);
        }

        Page<AdminPaymentTransactionResponse> responsePage = txPage.map(tx -> {
            String userDisplayName = null;
            Long userId = null;
            if (tx.getWallet() != null && tx.getWallet().getUser() != null) {
                userDisplayName = tx.getWallet().getUser().getDisplayName();
                userId = tx.getWallet().getUser().getId();
            }

            return AdminPaymentTransactionResponse.builder()
                    .id(tx.getId())
                    .transactionCode(tx.getTransactionCode())
                    .userDisplayName(userDisplayName)
                    .userId(userId)
                    .amount(tx.getAmount())
                    .type(tx.getType())
                    .status(tx.getStatus())
                    .note(tx.getNote())
                    .createdAt(tx.getCreatedAt())
                    .build();
        });

        return PageResponse.from(responsePage);
    }
}
