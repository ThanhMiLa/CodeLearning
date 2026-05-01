package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.CourseEntity;
import com.thanhmila.codelearning.entity.enums.CourseStatus;
import com.thanhmila.codelearning.repository.projection.CourseListItemProjection;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
@SuppressWarnings("all")
public interface CourseRepository extends JpaRepository<CourseEntity, Long> {
    Page<CourseEntity> findAllByStatus(CourseStatus status, Pageable pageable);

    @Query(value = """
        SELECT * FROM (
            SELECT 
                c.id AS id, 
                c.title AS title, 
                c.short_description AS shortDescription, 
                c.thumbnail_url AS thumbnailUrl, 
                c.price AS price,
                COALESCE(AVG(cr.rating), 0.0) AS averageRating,
                COUNT(DISTINCT cr.id) AS totalReviews,
                (
                    SELECT COUNT(*)
                    FROM Enrollments er
                    WHERE er.course_id = c.id
                ) AS totalEnrolled,
                CASE WHEN COUNT(e.id) > 0 THEN true ELSE false END AS enrolled,
                COALESCE(MAX(clc.completed_lessons_count), 0) AS completedLessons,
                (
                    SELECT COUNT(l.id) 
                    FROM lessons l 
                    JOIN chapters ch ON l.chapter_id = ch.id 
                    WHERE ch.course_id = c.id AND l.status = 'ACTIVE'
                ) AS totalActiveLessons
            FROM courses c
            LEFT JOIN course_reviews cr ON c.id = cr.course_id
            LEFT JOIN enrollments e ON c.id = e.course_id 
                                     AND e.user_id = :userId 
                                     AND e.status IN ('ACTIVE', 'COMPLETED')
            LEFT JOIN completed_lessons_count clc ON c.id = clc.course_id 
                                                  AND clc.user_id = :userId
            WHERE c.status = 'ACTIVE'
            GROUP BY 
                c.id, c.title, c.short_description, c.thumbnail_url, c.price
        ) AS result_table
        """,
            countQuery = "SELECT COUNT(id) FROM courses WHERE status = 'ACTIVE'",
            nativeQuery = true)
    Page<CourseListItemProjection> findAllCoursesWithDetails(@Param("userId") Long userId, Pageable pageable);
}
