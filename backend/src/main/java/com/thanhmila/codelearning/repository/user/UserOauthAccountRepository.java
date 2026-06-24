package com.thanhmila.codelearning.repository.user;

import com.thanhmila.codelearning.entity.user.UserOauthAccountEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserOauthAccountRepository extends JpaRepository<UserOauthAccountEntity, Long> {
    Optional<UserOauthAccountEntity> findByProviderAndProviderAccountId(String provider, String providerAccountId);
}
