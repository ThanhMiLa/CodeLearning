package com.thanhmila.codelearning.service.admin.impl;

import com.thanhmila.codelearning.dto.response.AdminPaymentTransactionResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.enums.PaymentTransactionType;
import com.thanhmila.codelearning.entity.enums.TransactionStatus;
import com.thanhmila.codelearning.entity.payment.PaymentTransactionEntity;
import com.thanhmila.codelearning.entity.payment.WalletEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.repository.payment.PaymentTransactionRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.math.BigDecimal;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("AdminPaymentServiceImpl Unit Tests")
class AdminPaymentServiceImplTest {

    @Mock PaymentTransactionRepository paymentTransactionRepository;

    @InjectMocks AdminPaymentServiceImpl adminPaymentService;

    @Test
    @DisplayName("Finds all transactions when no filter params are provided")
    void shouldFindAll_WhenNoFilter() {
        Pageable pageable = PageRequest.of(0, 10);
        UserEntity user = UserEntity.builder().id(5L).displayName("John Doe").build();
        WalletEntity wallet = WalletEntity.builder().user(user).build();
        PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                .id(1L)
                .transactionCode("TX-100")
                .wallet(wallet)
                .amount(BigDecimal.valueOf(50000))
                .status(TransactionStatus.SUCCESS)
                .type(PaymentTransactionType.DEPOSIT)
                .build();
        Page<PaymentTransactionEntity> page = new PageImpl<>(List.of(tx));

        when(paymentTransactionRepository.findAllForAdmin(pageable)).thenReturn(page);

        PageResponse<AdminPaymentTransactionResponse> response = adminPaymentService.getPaymentTransactionsForAdmin(null, null, null, pageable);

        assertThat(response).isNotNull();
        assertThat(response.getContent()).hasSize(1);
        AdminPaymentTransactionResponse item = response.getContent().get(0);
        assertThat(item.getTransactionCode()).isEqualTo("TX-100");
        assertThat(item.getUserDisplayName()).isEqualTo("John Doe");
        assertThat(item.getUserId()).isEqualTo(5L);
        verify(paymentTransactionRepository).findAllForAdmin(pageable);
    }

    @Test
    @DisplayName("Searches transactions with filters when keyword or status provided")
    void shouldSearch_WhenFilterProvided() {
        Pageable pageable = PageRequest.of(0, 10);
        Page<PaymentTransactionEntity> page = new PageImpl<>(List.of());

        when(paymentTransactionRepository.searchForAdmin("TX", TransactionStatus.SUCCESS, PaymentTransactionType.DEPOSIT, pageable))
                .thenReturn(page);

        PageResponse<AdminPaymentTransactionResponse> response = adminPaymentService.getPaymentTransactionsForAdmin(" TX ", TransactionStatus.SUCCESS, PaymentTransactionType.DEPOSIT, pageable);

        assertThat(response).isNotNull();
        assertThat(response.getContent()).isEmpty();
        verify(paymentTransactionRepository).searchForAdmin("TX", TransactionStatus.SUCCESS, PaymentTransactionType.DEPOSIT, pageable);
    }
}
