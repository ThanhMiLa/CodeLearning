package com.thanhmila.codelearning.repository.payment;

import com.thanhmila.codelearning.entity.payment.CartEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CartRepository extends JpaRepository<CartEntity, Long> {

    @Query("SELECT c FROM CartEntity c " +
           "LEFT JOIN FETCH c.items i " +
           "LEFT JOIN FETCH i.course " +
           "WHERE c.user.id = :userId")
    Optional<CartEntity> findByUserIdWithItemsAndCourses(@Param("userId") Long userId);
}
