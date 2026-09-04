package com.thanhmila.codelearning.scheduler;

import com.thanhmila.codelearning.entity.enums.TransactionStatus;
import com.thanhmila.codelearning.entity.payment.PaymentTransactionEntity;
import com.thanhmila.codelearning.repository.payment.PaymentTransactionRepository;
import com.thanhmila.codelearning.service.payment.PaymentService;
import com.thanhmila.codelearning.service.payment.client.PayOsClient;
import com.thanhmila.codelearning.service.payment.client.PayOsErrorType;
import com.thanhmila.codelearning.service.payment.client.PayOsException;
import com.thanhmila.codelearning.service.payment.client.PayOsPaymentInfo;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.Clock;
import java.time.Instant;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.util.Collections;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("PaymentCronJob Unit Tests")
class PaymentCronJobTest {

    @Mock
    private PaymentTransactionRepository paymentTransactionRepository;

    @Mock
    private PaymentService paymentService;

    @Mock
    private PayOsClient payOsClient;

    private Clock fixedClock;
    private PaymentCronJob paymentCronJob;
    private OffsetDateTime now;

    @BeforeEach
    void setUp() {
        Instant fixedInstant = Instant.parse("2026-09-04T12:00:00Z");
        fixedClock = Clock.fixed(fixedInstant, ZoneOffset.UTC);
        now = OffsetDateTime.now(fixedClock);

        paymentCronJob = new PaymentCronJob(paymentTransactionRepository, paymentService, payOsClient, fixedClock);
    }

    @Test
    @DisplayName("scanPendingTransactions: Không có đơn pending thì kết thúc ngay")
    void scanPendingTransactions_EmptyList_ReturnsImmediately() {
        when(paymentTransactionRepository.findByStatus(TransactionStatus.PENDING))
                .thenReturn(Collections.emptyList());

        paymentCronJob.scanPendingTransactions();

        verifyNoInteractions(paymentService);
        verifyNoInteractions(payOsClient);
    }

    @Test
    @DisplayName("scanPendingTransactions: Giao dịch PAID khớp amountPaid -> gọi fallback nạp tiền")
    void scanPendingTransactions_StatusPaid_ValidAmount_CallsFallback() {
        PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                .transactionCode("TX-PAID")
                .status(TransactionStatus.PENDING)
                .amount(BigDecimal.valueOf(50000))
                .createdAt(now.minusMinutes(10))
                .build();

        PayOsPaymentInfo info = PayOsPaymentInfo.builder()
                .status("PAID")
                .amountPaid(BigDecimal.valueOf(50000))
                .build();

        when(paymentTransactionRepository.findByStatus(TransactionStatus.PENDING)).thenReturn(List.of(tx));
        when(payOsClient.getPaymentInformation("TX-PAID")).thenReturn(info);

        paymentCronJob.scanPendingTransactions();

        verify(paymentService).processSuccessfulPaymentFallback(eq("TX-PAID"), eq(BigDecimal.valueOf(50000)));
        verify(paymentTransactionRepository, never()).save(tx);
    }

    @Test
    @DisplayName("scanPendingTransactions: Giao dịch PAID nhưng amountPaid sai lệch -> cảnh báo không cộng ví")
    void scanPendingTransactions_StatusPaid_AmountMismatch_DoesNotCallFallback() {
        PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                .transactionCode("TX-MISMATCH")
                .status(TransactionStatus.PENDING)
                .amount(BigDecimal.valueOf(50000))
                .createdAt(now.minusMinutes(10))
                .build();

        PayOsPaymentInfo info = PayOsPaymentInfo.builder()
                .status("PAID")
                .amountPaid(BigDecimal.valueOf(30000)) // Nhỏ hơn amount mong muốn
                .build();

        when(paymentTransactionRepository.findByStatus(TransactionStatus.PENDING)).thenReturn(List.of(tx));
        when(payOsClient.getPaymentInformation("TX-MISMATCH")).thenReturn(info);

        paymentCronJob.scanPendingTransactions();

        verify(paymentService, never()).processSuccessfulPaymentFallback(any(), any());
        verify(paymentTransactionRepository, never()).save(tx);
    }

    @Test
    @DisplayName("scanPendingTransactions: Giao dịch CANCELLED trên PayOS -> cập nhật CANCELLED")
    void scanPendingTransactions_StatusCancelled_CancelsTransaction() {
        PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                .transactionCode("TX-CANCELLED")
                .status(TransactionStatus.PENDING)
                .amount(BigDecimal.valueOf(50000))
                .createdAt(now.minusMinutes(10))
                .build();

        PayOsPaymentInfo info = PayOsPaymentInfo.builder()
                .status("CANCELLED")
                .build();

        when(paymentTransactionRepository.findByStatus(TransactionStatus.PENDING)).thenReturn(List.of(tx));
        when(payOsClient.getPaymentInformation("TX-CANCELLED")).thenReturn(info);

        paymentCronJob.scanPendingTransactions();

        assertThat(tx.getStatus()).isEqualTo(TransactionStatus.CANCELLED);
        verify(paymentTransactionRepository).save(tx);
    }

    @Test
    @DisplayName("scanPendingTransactions: Giao dịch EXPIRED trên PayOS -> cập nhật CANCELLED")
    void scanPendingTransactions_StatusExpired_CancelsTransaction() {
        PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                .transactionCode("TX-EXPIRED")
                .status(TransactionStatus.PENDING)
                .amount(BigDecimal.valueOf(50000))
                .createdAt(now.minusMinutes(10))
                .build();

        PayOsPaymentInfo info = PayOsPaymentInfo.builder()
                .status("EXPIRED")
                .build();

        when(paymentTransactionRepository.findByStatus(TransactionStatus.PENDING)).thenReturn(List.of(tx));
        when(payOsClient.getPaymentInformation("TX-EXPIRED")).thenReturn(info);

        paymentCronJob.scanPendingTransactions();

        assertThat(tx.getStatus()).isEqualTo(TransactionStatus.CANCELLED);
        verify(paymentTransactionRepository).save(tx);
    }

    @Test
    @DisplayName("scanPendingTransactions: Giao dịch PENDING quá 30 phút -> gọi cancel PayOS và cập nhật CANCELLED")
    void scanPendingTransactions_StatusPending_OldTransaction_Cancels() {
        PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                .transactionCode("TX-OLD-PENDING")
                .status(TransactionStatus.PENDING)
                .amount(BigDecimal.valueOf(50000))
                .createdAt(now.minusMinutes(35))
                .build();

        PayOsPaymentInfo info = PayOsPaymentInfo.builder()
                .status("PENDING")
                .build();

        when(paymentTransactionRepository.findByStatus(TransactionStatus.PENDING)).thenReturn(List.of(tx));
        when(payOsClient.getPaymentInformation("TX-OLD-PENDING")).thenReturn(info);

        paymentCronJob.scanPendingTransactions();

        verify(payOsClient).cancelPaymentLink(eq("TX-OLD-PENDING"), any());
        assertThat(tx.getStatus()).isEqualTo(TransactionStatus.CANCELLED);
        verify(paymentTransactionRepository).save(tx);
    }

    @Test
    @DisplayName("scanPendingTransactions: Giao dịch PENDING dưới 30 phút -> giữ nguyên PENDING")
    void scanPendingTransactions_StatusPending_RecentTransaction_KeepsPending() {
        PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                .transactionCode("TX-RECENT-PENDING")
                .status(TransactionStatus.PENDING)
                .amount(BigDecimal.valueOf(50000))
                .createdAt(now.minusMinutes(15))
                .build();

        PayOsPaymentInfo info = PayOsPaymentInfo.builder()
                .status("PENDING")
                .build();

        when(paymentTransactionRepository.findByStatus(TransactionStatus.PENDING)).thenReturn(List.of(tx));
        when(payOsClient.getPaymentInformation("TX-RECENT-PENDING")).thenReturn(info);

        paymentCronJob.scanPendingTransactions();

        assertThat(tx.getStatus()).isEqualTo(TransactionStatus.PENDING);
        verify(paymentTransactionRepository, never()).save(tx);
    }

    @Test
    @DisplayName("scanPendingTransactions: Giao dịch PROCESSING quá 30 phút -> gọi cancel PayOS và cập nhật CANCELLED")
    void scanPendingTransactions_StatusProcessing_OldTransaction_Cancels() {
        PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                .transactionCode("TX-OLD-PROCESSING")
                .status(TransactionStatus.PENDING)
                .amount(BigDecimal.valueOf(50000))
                .createdAt(now.minusMinutes(45))
                .build();

        PayOsPaymentInfo info = PayOsPaymentInfo.builder()
                .status("PROCESSING")
                .build();

        when(paymentTransactionRepository.findByStatus(TransactionStatus.PENDING)).thenReturn(List.of(tx));
        when(payOsClient.getPaymentInformation("TX-OLD-PROCESSING")).thenReturn(info);

        paymentCronJob.scanPendingTransactions();

        verify(payOsClient).cancelPaymentLink(eq("TX-OLD-PROCESSING"), any());
        assertThat(tx.getStatus()).isEqualTo(TransactionStatus.CANCELLED);
        verify(paymentTransactionRepository).save(tx);
    }

    @Test
    @DisplayName("scanPendingTransactions: PayOS báo NOT_FOUND và đơn quá 30 phút -> ép hủy CANCELLED")
    void scanPendingTransactions_NotFound_OldTransaction_Cancels() {
        PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                .transactionCode("TX-NOTFOUND-OLD")
                .status(TransactionStatus.PENDING)
                .amount(BigDecimal.valueOf(50000))
                .createdAt(now.minusMinutes(35))
                .build();

        when(paymentTransactionRepository.findByStatus(TransactionStatus.PENDING)).thenReturn(List.of(tx));
        when(payOsClient.getPaymentInformation("TX-NOTFOUND-OLD"))
                .thenThrow(new PayOsException(PayOsErrorType.NOT_FOUND, "404", "Not found"));

        paymentCronJob.scanPendingTransactions();

        assertThat(tx.getStatus()).isEqualTo(TransactionStatus.CANCELLED);
        verify(paymentTransactionRepository).save(tx);
    }

    @Test
    @DisplayName("scanPendingTransactions: Lỗi mạng TRANSIENT -> giữ nguyên PENDING để retry vòng sau")
    void scanPendingTransactions_TransientError_KeepsPending() {
        PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                .transactionCode("TX-NETWORK-ERR")
                .status(TransactionStatus.PENDING)
                .amount(BigDecimal.valueOf(50000))
                .createdAt(now.minusMinutes(40))
                .build();

        when(paymentTransactionRepository.findByStatus(TransactionStatus.PENDING)).thenReturn(List.of(tx));
        when(payOsClient.getPaymentInformation("TX-NETWORK-ERR"))
                .thenThrow(new PayOsException(PayOsErrorType.TRANSIENT, "500", "Server Error"));

        paymentCronJob.scanPendingTransactions();

        assertThat(tx.getStatus()).isEqualTo(TransactionStatus.PENDING);
        verify(paymentTransactionRepository, never()).save(tx);
    }

    @Test
    @DisplayName("scanPendingTransactions: Lỗi đơn 1 không làm dừng xử lý đơn 2 trong danh sách")
    void scanPendingTransactions_FirstError_ContinuesToSecond() {
        PaymentTransactionEntity tx1 = PaymentTransactionEntity.builder()
                .transactionCode("TX-1")
                .status(TransactionStatus.PENDING)
                .amount(BigDecimal.valueOf(50000))
                .createdAt(now.minusMinutes(10))
                .build();

        PaymentTransactionEntity tx2 = PaymentTransactionEntity.builder()
                .transactionCode("TX-2")
                .status(TransactionStatus.PENDING)
                .amount(BigDecimal.valueOf(100000))
                .createdAt(now.minusMinutes(10))
                .build();

        when(paymentTransactionRepository.findByStatus(TransactionStatus.PENDING)).thenReturn(List.of(tx1, tx2));
        when(payOsClient.getPaymentInformation("TX-1"))
                .thenThrow(new RuntimeException("Unexpected error"));

        PayOsPaymentInfo info2 = PayOsPaymentInfo.builder()
                .status("CANCELLED")
                .build();
        when(payOsClient.getPaymentInformation("TX-2")).thenReturn(info2);

        paymentCronJob.scanPendingTransactions();

        assertThat(tx1.getStatus()).isEqualTo(TransactionStatus.PENDING);
        assertThat(tx2.getStatus()).isEqualTo(TransactionStatus.CANCELLED);
        verify(paymentTransactionRepository).save(tx2);
    }
}
