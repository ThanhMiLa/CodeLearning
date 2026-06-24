package com.thanhmila.codelearning.repository.user;

import com.thanhmila.codelearning.entity.user.TeacherEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
@Repository 
public interface TeacherRepository extends JpaRepository<TeacherEntity, Long> {
    @Query("SELECT t.id FROM TeacherEntity t WHERE t.user.id = :userId")
    Long findIdByUserId(@Param("userId") Long userId);
}
