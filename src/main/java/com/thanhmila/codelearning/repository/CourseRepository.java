package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.dto.response.CourseListItemResponse;
import com.thanhmila.codelearning.entity.CourseEntity;
import com.thanhmila.codelearning.entity.enums.CourseStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CourseRepository extends JpaRepository<CourseEntity, Long> {
    Page<CourseEntity> findAllByStatus(CourseStatus status, Pageable pageable);

//    @Query(
//            value = """
//                    SELECT new com.thanhmila.codelearning.dto.response.CourseListItemResponse(
//                        c.id,
//                        c.title,
//                        c.shortDescription,
//                        c.thumbnailUrl,
//                        c.price,
//                        COALESCE(AVG(r.rating), 0.0),
//                        COUNT(r.id)
//                    )
//                    FROM CourseEntity c
//                    LEFT JOIN CourseReviewEntity r ON r.course = c
//                    WHERE c.status = :status
//                    GROUP BY c.id, c.title, c.shortDescription, c.thumbnailUrl, c.price
//                    ORDER BY COUNT(r.id) DESC, c.createdAt DESC
//                    """,
//            countQuery = """
//                    SELECT COUNT(c)
//                    FROM CourseEntity c
//                    WHERE c.status = :status
//                    """
//    )
//    Page<CourseListItemResponse> findCourseListOrderByTotalReviews(
//            @Param("status") CourseStatus status,
//            Pageable pageable
//    );
}
