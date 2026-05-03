package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.auth.InvalidatedTokenEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InvalidatedTokenRepository extends JpaRepository<InvalidatedTokenEntity, Long> {
    boolean existsByTokenJti(String tokenJti);
}
