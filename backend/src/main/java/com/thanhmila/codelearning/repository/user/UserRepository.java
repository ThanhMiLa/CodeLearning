package com.thanhmila.codelearning.repository.user;

import com.thanhmila.codelearning.entity.user.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Long> {
    Optional<UserEntity> findByUsername(String username);
    Optional<UserEntity> findByEmail(String email);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
    
    List<UserEntity> findByIsEmailValidTrue();

    @Query("SELECT u FROM UserEntity u LEFT JOIN FETCH u.wallet WHERE u.username = :username")
    Optional<UserEntity> findByUsernameWithWallet(@Param("username") String username);

    @EntityGraph(attributePaths = {"roles", "wallet"})
    @Query("SELECT u FROM UserEntity u")
    Page<UserEntity> findAllForAdmin(Pageable pageable);

    @EntityGraph(attributePaths = {"roles", "wallet"})
    @Query("SELECT u FROM UserEntity u WHERE " +
           "LOWER(u.username) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(u.email) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(u.displayName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(u.phoneNumber) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    Page<UserEntity> searchForAdmin(@Param("keyword") String keyword, Pageable pageable);

    @EntityGraph(attributePaths = {"roles", "wallet"})
    @Query("SELECT u FROM UserEntity u WHERE u.id IN :ids")
    Page<UserEntity> findOnlineUsersForAdmin(@Param("ids") List<Long> ids, Pageable pageable);

    @Query("SELECT DISTINCT u FROM UserEntity u " +
           "LEFT JOIN FETCH u.roles r " +
           "WHERE u.isEmailValid = true " +
           "AND (:keyword IS NULL OR :keyword = '' OR LOWER(u.email) LIKE LOWER(CONCAT('%', :keyword, '%')) OR LOWER(u.displayName) LIKE LOWER(CONCAT('%', :keyword, '%'))) " +
           "AND (:role IS NULL OR :role = '' OR r.name = :role)")
    List<UserEntity> searchEmailTargets(@Param("keyword") String keyword, @Param("role") String role);
}
