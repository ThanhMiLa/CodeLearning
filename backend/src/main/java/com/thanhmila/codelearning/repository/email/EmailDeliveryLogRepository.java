package com.thanhmila.codelearning.repository.email;

import com.thanhmila.codelearning.entity.email.EmailDeliveryLogEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmailDeliveryLogRepository extends JpaRepository<EmailDeliveryLogEntity, Long> {
    List<EmailDeliveryLogEntity> findByEmail(String email);
}
