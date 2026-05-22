package com.thanhmila.codelearning.repository.payment;

import com.thanhmila.codelearning.entity.payment.OrderEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<OrderEntity, Long> {
}
