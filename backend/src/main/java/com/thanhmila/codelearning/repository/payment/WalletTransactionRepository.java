package com.thanhmila.codelearning.repository.payment;

import com.thanhmila.codelearning.entity.payment.WalletTransactionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WalletTransactionRepository extends JpaRepository<WalletTransactionEntity, Long> {
    List<WalletTransactionEntity> findByWalletIdOrderByCreatedAtDesc(Long walletId);
}
