package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.course.CourseReviewEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


@Repository 
public interface CourseReviewRepository extends JpaRepository<CourseReviewEntity, Long> {
    Long countByCourseId(Long courseId);

    @Query("""
        SELECT COALESCE(AVG(r.rating), 0)
        FROM CourseReviewEntity r
        WHERE r.course.id = :courseId
        """)
    Double getAverageRatingByCourseId(@Param("courseId") Long courseId);
}
