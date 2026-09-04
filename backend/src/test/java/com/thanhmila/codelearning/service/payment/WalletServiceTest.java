package com.thanhmila.codelearning.service.payment;

import com.thanhmila.codelearning.entity.enums.WalletStatus;
import com.thanhmila.codelearning.entity.payment.WalletEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.event.UserRegisteredEvent;
import com.thanhmila.codelearning.repository.payment.WalletRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
@DisplayName("WalletService Unit Tests")
class WalletServiceTest {

    @Mock WalletRepository walletRepository;

    @InjectMocks WalletService walletService;

    @Test
    @DisplayName("Creates active wallet with zero balance on UserRegisteredEvent")
    void shouldCreateWallet_OnUserRegisteredEvent() {
        UserEntity user = UserEntity.builder().id(100L).username("alice").build();
        UserRegisteredEvent event = UserRegisteredEvent.builder().userEntity(user).build();

        walletService.handleUserRegisteredEvent(event);

        ArgumentCaptor<WalletEntity> captor = ArgumentCaptor.forClass(WalletEntity.class);
        verify(walletRepository).save(captor.capture());

        WalletEntity savedWallet = captor.getValue();
        assertThat(savedWallet).isNotNull();
        assertThat(savedWallet.getUser()).isEqualTo(user);
        assertThat(savedWallet.getBalance()).isEqualByComparingTo(BigDecimal.ZERO);
        assertThat(savedWallet.getStatus()).isEqualTo(WalletStatus.ACTIVE);
    }
}
