package com.thanhmila.codelearning.scheduler;

import com.thanhmila.codelearning.configuration.ProjectProperties;
import com.thanhmila.codelearning.entity.enums.TransactionStatus;
import com.thanhmila.codelearning.entity.payment.PaymentTransactionEntity;
import com.thanhmila.codelearning.repository.payment.PaymentTransactionRepository;
import com.thanhmila.codelearning.service.payment.PaymentService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.OffsetDateTime;
import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("PaymentCronJob Unit Tests")
class PaymentCronJobTest {

    @Mock
    private PaymentTransactionRepository paymentTransactionRepository;

    @Mock
    private ProjectProperties.Payos payosProps;

    @Mock
    private PaymentService paymentService;

    @InjectMocks
    private PaymentCronJob paymentCronJob;

    @Test
    @DisplayName("scanPendingTransactions: Không có đơn pending thì kết thúc ngay")
    void scanPendingTransactions_EmptyList_ReturnsImmediately() {
        when(paymentTransactionRepository.findByStatus(TransactionStatus.PENDING))
                .thenReturn(Collections.emptyList());

        paymentCronJob.scanPendingTransactions();

        verifyNoInteractions(paymentService);
        verifyNoInteractions(payosProps);
    }

    @Test
    @DisplayName("scanPendingTransactions: Giao dịch lỗi kết nối quá 30 phút thì tự động hủy")
    void scanPendingTransactions_ExceptionOldTransaction_Cancels() {
        PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                .transactionCode("TX-OLD-1")
                .status(TransactionStatus.PENDING)
                .createdAt(OffsetDateTime.now().minusMinutes(35))
                .build();

        when(paymentTransactionRepository.findByStatus(TransactionStatus.PENDING))
                .thenReturn(List.of(tx));
        when(payosProps.getClientId()).thenReturn("client-id");
        when(payosProps.getApiKey()).thenReturn("api-key");

        paymentCronJob.scanPendingTransactions();

        verify(paymentTransactionRepository).save(tx);
        assertThat(tx.getStatus()).isEqualTo(TransactionStatus.CANCELLED);
    }

    @Test
    @DisplayName("scanPendingTransactions: Giao dịch lỗi kết nối chưa quá 30 phút thì không hủy")
    void scanPendingTransactions_ExceptionRecentTransaction_DoesNotCancel() {
        PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                .transactionCode("TX-RECENT-1")
                .status(TransactionStatus.PENDING)
                .createdAt(OffsetDateTime.now().minusMinutes(10))
                .build();

        when(paymentTransactionRepository.findByStatus(TransactionStatus.PENDING))
                .thenReturn(List.of(tx));
        when(payosProps.getClientId()).thenReturn("client-id");
        when(payosProps.getApiKey()).thenReturn("api-key");

        paymentCronJob.scanPendingTransactions();

        verify(paymentTransactionRepository, never()).save(tx);
        assertThat(tx.getStatus()).isEqualTo(TransactionStatus.PENDING);
    }
}
