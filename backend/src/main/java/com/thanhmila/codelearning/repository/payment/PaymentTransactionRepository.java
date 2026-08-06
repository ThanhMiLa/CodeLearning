package com.thanhmila.codelearning.repository.payment;

import com.thanhmila.codelearning.entity.enums.PaymentTransactionType;
import com.thanhmila.codelearning.entity.enums.TransactionStatus;
import com.thanhmila.codelearning.entity.payment.PaymentTransactionEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PaymentTransactionRepository extends JpaRepository<PaymentTransactionEntity, Long> {
    Optional<PaymentTransactionEntity> findByTransactionCode(String transactionCode);
    java.util.List<PaymentTransactionEntity> findByStatus(TransactionStatus status);

    @Query(value = "SELECT pt FROM PaymentTransactionEntity pt " +
                   "JOIN FETCH pt.wallet w " +
                   "JOIN FETCH w.user u",
           countQuery = "SELECT COUNT(pt) FROM PaymentTransactionEntity pt")
    Page<PaymentTransactionEntity> findAllForAdmin(Pageable pageable);

    @Query(value = "SELECT pt FROM PaymentTransactionEntity pt " +
                   "JOIN FETCH pt.wallet w " +
                   "JOIN FETCH w.user u " +
                   "WHERE (CAST(:keyword AS string) IS NULL OR :keyword = '' OR " +
                   "LOWER(pt.transactionCode) LIKE LOWER(CONCAT('%', CAST(:keyword AS string), '%')) OR " +
                   "LOWER(u.displayName) LIKE LOWER(CONCAT('%', CAST(:keyword AS string), '%')) OR " +
                   "LOWER(u.username) LIKE LOWER(CONCAT('%', CAST(:keyword AS string), '%'))) " +
                   "AND (CAST(:status AS string) IS NULL OR pt.status = :status) " +
                   "AND (CAST(:type AS string) IS NULL OR pt.type = :type)",
           countQuery = "SELECT COUNT(pt) FROM PaymentTransactionEntity pt " +
                        "JOIN pt.wallet w " +
                        "JOIN w.user u " +
                        "WHERE (CAST(:keyword AS string) IS NULL OR :keyword = '' OR " +
                        "LOWER(pt.transactionCode) LIKE LOWER(CONCAT('%', CAST(:keyword AS string), '%')) OR " +
                        "LOWER(u.displayName) LIKE LOWER(CONCAT('%', CAST(:keyword AS string), '%')) OR " +
                        "LOWER(u.username) LIKE LOWER(CONCAT('%', CAST(:keyword AS string), '%'))) " +
                        "AND (CAST(:status AS string) IS NULL OR pt.status = :status) " +
                        "AND (CAST(:type AS string) IS NULL OR pt.type = :type)")
    Page<PaymentTransactionEntity> searchForAdmin(@Param("keyword") String keyword,
                                                  @Param("status") TransactionStatus status,
                                                  @Param("type") PaymentTransactionType type,
                                                  Pageable pageable);
}
