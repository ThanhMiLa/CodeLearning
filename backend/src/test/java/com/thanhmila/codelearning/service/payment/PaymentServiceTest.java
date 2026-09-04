package com.thanhmila.codelearning.service.payment;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.thanhmila.codelearning.configuration.ProjectProperties;
import com.thanhmila.codelearning.dto.request.PaymentDepositRequest;
import com.thanhmila.codelearning.entity.enums.PaymentTransactionType;
import com.thanhmila.codelearning.entity.enums.TransactionStatus;
import com.thanhmila.codelearning.entity.enums.UserStatus;
import com.thanhmila.codelearning.entity.enums.WalletTransactionType;
import com.thanhmila.codelearning.entity.payment.PaymentTransactionEntity;
import com.thanhmila.codelearning.entity.payment.WalletEntity;
import com.thanhmila.codelearning.entity.payment.WalletTransactionEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.payment.PaymentTransactionRepository;
import com.thanhmila.codelearning.repository.payment.WalletRepository;
import com.thanhmila.codelearning.repository.payment.WalletTransactionRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;
import vn.payos.PayOS;
import vn.payos.type.Webhook;
import vn.payos.type.WebhookData;

import java.math.BigDecimal;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("PaymentService Unit Tests")
class PaymentServiceTest {

    @Mock PayOS payOS;
    @Mock ProjectProperties.Payos payosProps;
    @Mock WalletRepository walletRepository;
    @Mock PaymentTransactionRepository paymentTransactionRepository;
    @Mock WalletTransactionRepository walletTransactionRepository;
    @Mock UserRepository userRepository;

    @InjectMocks PaymentService paymentService;

    private final ObjectMapper objectMapper = new ObjectMapper();

    private ObjectNode createWebhookPayload() {
        ObjectNode payload = objectMapper.createObjectNode();
        payload.put("code", "00");
        payload.put("desc", "success");
        payload.put("signature", "dummy_sig");
        ObjectNode dataNode = payload.putObject("data");
        dataNode.put("orderCode", 12345L);
        dataNode.put("amount", 50000);
        dataNode.put("description", "desc");
        dataNode.put("accountNumber", "123");
        dataNode.put("reference", "ref");
        dataNode.put("transactionDateTime", "2026-01-01");
        dataNode.put("currency", "VND");
        dataNode.put("paymentLinkId", "linkId");
        dataNode.put("code", "00");
        dataNode.put("desc", "success");
        return payload;
    }

    private WebhookData createMockWebhookData(String code, long orderCode, int amount) {
        WebhookData data = mock(WebhookData.class);
        when(data.getCode()).thenReturn(code);
        when(data.getOrderCode()).thenReturn(orderCode);
        when(data.getAmount()).thenReturn(amount);
        return data;
    }

    @Nested
    @DisplayName("createDepositPayment Tests")
    class CreateDepositPaymentTests {

        @Test
        @DisplayName("User not found throws USER_NOT_FOUND")
        void shouldThrow_WhenUserNotFound() {
            when(userRepository.findById(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> paymentService.createDepositPayment(1L, new PaymentDepositRequest(BigDecimal.valueOf(50000))))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.USER_NOT_FOUND);
        }

        @Test
        @DisplayName("User locked throws ACCOUNT_LOCKED")
        void shouldThrow_WhenUserLocked() {
            UserEntity user = UserEntity.builder().id(1L).status(UserStatus.LOCKED).build();
            when(userRepository.findById(1L)).thenReturn(Optional.of(user));

            assertThatThrownBy(() -> paymentService.createDepositPayment(1L, new PaymentDepositRequest(BigDecimal.valueOf(50000))))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.ACCOUNT_LOCKED);
        }

        @Test
        @DisplayName("Wallet not found throws RESOURCE_NOT_FOUND")
        void shouldThrow_WhenWalletNotFound() {
            UserEntity user = UserEntity.builder().id(1L).status(UserStatus.ACTIVE).build();
            when(userRepository.findById(1L)).thenReturn(Optional.of(user));
            when(walletRepository.findByUserId(1L)).thenReturn(Optional.empty());

            assertThatThrownBy(() -> paymentService.createDepositPayment(1L, new PaymentDepositRequest(BigDecimal.valueOf(50000))))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.RESOURCE_NOT_FOUND);
        }
    }

    @Nested
    @DisplayName("handlePayOSWebhook Tests")
    class HandlePayOSWebhookTests {

        @Test
        @DisplayName("Invalid signature throws UNCATEGORIZED_EXCEPTION")
        void shouldThrow_WhenSignatureInvalid() throws Exception {
            ObjectNode payload = createWebhookPayload();
            when(payOS.verifyPaymentWebhookData(any())).thenThrow(new RuntimeException("Invalid signature"));

            assertThatThrownBy(() -> paymentService.handlePayOSWebhook(payload))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.UNCATEGORIZED_EXCEPTION);
        }

        @Test
        @DisplayName("Non-success code returns early without processing")
        void shouldReturnEarly_WhenCodeNot00() throws Exception {
            ObjectNode payload = createWebhookPayload();
            WebhookData data = createMockWebhookData("01", 12345L, 50000);
            when(payOS.verifyPaymentWebhookData(any())).thenReturn(data);

            paymentService.handlePayOSWebhook(payload);

            verify(paymentTransactionRepository, never()).findByTransactionCode(any());
        }

        @Test
        @DisplayName("Already SUCCESS or LATE_SUCCESS is idempotent and returns early")
        void shouldReturnEarly_WhenAlreadySuccessful() throws Exception {
            ObjectNode payload = createWebhookPayload();
            WebhookData data = createMockWebhookData("00", 12345L, 50000);
            PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                    .transactionCode("12345")
                    .status(TransactionStatus.SUCCESS)
                    .build();

            when(payOS.verifyPaymentWebhookData(any())).thenReturn(data);
            when(paymentTransactionRepository.findByTransactionCode("12345")).thenReturn(Optional.of(tx));

            paymentService.handlePayOSWebhook(payload);

            verify(walletRepository, never()).findByUserIdWithLock(any());
        }

        @Test
        @DisplayName("Processes PENDING transaction to SUCCESS and adds wallet balance")
        void shouldProcessPendingToSuccess() throws Exception {
            ObjectNode payload = createWebhookPayload();
            WebhookData data = createMockWebhookData("00", 12345L, 50000);

            UserEntity user = UserEntity.builder().id(10L).build();
            WalletEntity wallet = WalletEntity.builder().id(1L).user(user).balance(BigDecimal.valueOf(10000)).build();
            PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                    .id(100L)
                    .wallet(wallet)
                    .transactionCode("12345")
                    .status(TransactionStatus.PENDING)
                    .build();

            when(payOS.verifyPaymentWebhookData(any())).thenReturn(data);
            when(paymentTransactionRepository.findByTransactionCode("12345")).thenReturn(Optional.of(tx));
            when(walletRepository.findByUserIdWithLock(10L)).thenReturn(Optional.of(wallet));

            paymentService.handlePayOSWebhook(payload);

            assertThat(tx.getStatus()).isEqualTo(TransactionStatus.SUCCESS);
            assertThat(tx.getAmount()).isEqualByComparingTo(BigDecimal.valueOf(50000));
            assertThat(wallet.getBalance()).isEqualByComparingTo(BigDecimal.valueOf(60000));
            verify(paymentTransactionRepository).save(tx);
            verify(walletTransactionRepository).save(any(WalletTransactionEntity.class));
            verify(walletRepository).save(wallet);
        }

        @Test
        @DisplayName("Processes CANCELLED transaction to LATE_SUCCESS and adds wallet balance")
        void shouldProcessCancelledToLateSuccess() throws Exception {
            ObjectNode payload = createWebhookPayload();
            WebhookData data = createMockWebhookData("00", 12345L, 50000);

            UserEntity user = UserEntity.builder().id(10L).build();
            WalletEntity wallet = WalletEntity.builder().id(1L).user(user).balance(BigDecimal.valueOf(10000)).build();
            PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                    .id(100L)
                    .wallet(wallet)
                    .transactionCode("12345")
                    .status(TransactionStatus.CANCELLED)
                    .build();

            when(payOS.verifyPaymentWebhookData(any())).thenReturn(data);
            when(paymentTransactionRepository.findByTransactionCode("12345")).thenReturn(Optional.of(tx));
            when(walletRepository.findByUserIdWithLock(10L)).thenReturn(Optional.of(wallet));

            paymentService.handlePayOSWebhook(payload);

            assertThat(tx.getStatus()).isEqualTo(TransactionStatus.LATE_SUCCESS);
            assertThat(wallet.getBalance()).isEqualByComparingTo(BigDecimal.valueOf(60000));
            verify(paymentTransactionRepository).save(tx);
            verify(walletRepository).save(wallet);
        }
    }

    @Nested
    @DisplayName("processSuccessfulPaymentFallback Tests")
    class FallbackTests {

        @Test
        @DisplayName("Transaction not found throws RESOURCE_NOT_FOUND")
        void shouldThrow_WhenTransactionNotFound() {
            when(paymentTransactionRepository.findByTransactionCode("123")).thenReturn(Optional.empty());

            assertThatThrownBy(() -> paymentService.processSuccessfulPaymentFallback("123", BigDecimal.valueOf(50000)))
                    .isInstanceOf(AppException.class)
                    .hasFieldOrPropertyWithValue("errorCode", ErrorCode.RESOURCE_NOT_FOUND);
        }

        @Test
        @DisplayName("Already successful transaction returns without updating")
        void shouldReturn_WhenAlreadySuccessful() {
            PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                    .transactionCode("123")
                    .status(TransactionStatus.SUCCESS)
                    .build();
            when(paymentTransactionRepository.findByTransactionCode("123")).thenReturn(Optional.of(tx));

            paymentService.processSuccessfulPaymentFallback("123", BigDecimal.valueOf(50000));

            verify(walletRepository, never()).findByUserIdWithLock(any());
        }

        @Test
        @DisplayName("Fallback updates PENDING transaction to SUCCESS and adds balance")
        void shouldUpdatePendingToSuccess() {
            UserEntity user = UserEntity.builder().id(10L).build();
            WalletEntity wallet = WalletEntity.builder().id(1L).user(user).balance(BigDecimal.ZERO).build();
            PaymentTransactionEntity tx = PaymentTransactionEntity.builder()
                    .id(100L)
                    .wallet(wallet)
                    .transactionCode("123")
                    .status(TransactionStatus.PENDING)
                    .build();

            when(paymentTransactionRepository.findByTransactionCode("123")).thenReturn(Optional.of(tx));
            when(walletRepository.findByUserIdWithLock(10L)).thenReturn(Optional.of(wallet));

            paymentService.processSuccessfulPaymentFallback("123", BigDecimal.valueOf(50000));

            assertThat(tx.getStatus()).isEqualTo(TransactionStatus.SUCCESS);
            assertThat(wallet.getBalance()).isEqualByComparingTo(BigDecimal.valueOf(50000));
            verify(paymentTransactionRepository).save(tx);
            verify(walletRepository).save(wallet);
        }
    }
}
