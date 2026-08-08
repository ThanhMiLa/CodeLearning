package com.thanhmila.codelearning.repository.email;

import com.thanhmila.codelearning.entity.email.FailedEmailQueueEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FailedEmailQueueRepository extends JpaRepository<FailedEmailQueueEntity, Long> {
    List<FailedEmailQueueEntity> findByStatus(String status);
}
