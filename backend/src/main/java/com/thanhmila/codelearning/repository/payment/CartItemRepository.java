package com.thanhmila.codelearning.repository.payment;

import com.thanhmila.codelearning.entity.payment.CartItemEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartItemRepository extends JpaRepository<CartItemEntity, Long> {
}
