package com.thanhmila.codelearning.service.payment;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import java.math.BigDecimal;
import org.springframework.stereotype.Service;
import org.springframework.transaction.event.TransactionPhase;
import org.springframework.transaction.event.TransactionalEventListener;
import com.thanhmila.codelearning.entity.enums.WalletStatus;
import com.thanhmila.codelearning.entity.payment.WalletEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.event.UserRegisteredEvent;
import com.thanhmila.codelearning.repository.payment.WalletRepository;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class WalletService {
    WalletRepository walletRepository;

    @TransactionalEventListener(phase = TransactionPhase.BEFORE_COMMIT)
    public void handleUserRegisteredEvent(UserRegisteredEvent event) {
        UserEntity user = event.getUserEntity();

        // Logic tạo ví
        WalletEntity wallet = WalletEntity.builder()
                .user(user)
                .balance(BigDecimal.ZERO)
                .status(WalletStatus.ACTIVE)
                .build();

        walletRepository.save(wallet);
    }

}
