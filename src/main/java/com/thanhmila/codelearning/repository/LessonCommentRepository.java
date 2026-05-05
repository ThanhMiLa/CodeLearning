package com.thanhmila.codelearning.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import com.thanhmila.codelearning.entity.course.LessonCommentEntity;
import com.thanhmila.codelearning.repository.projection.RootLessonCommentProjection;
import org.springframework.data.repository.query.Param;


@Repository
public interface LessonCommentRepository extends JpaRepository<LessonCommentEntity, Long> {
    @Query(value = """
            WITH ReplyCounts AS (
                SELECT parent_comment_id, COUNT(id) as count
                FROM lesson_comments
                WHERE lesson_id = :lessonId AND parent_comment_id IS NOT NULL
                GROUP BY parent_comment_id
            )
            SELECT 
                lm.id AS id, 
                u.id AS userId, 
                u.display_name AS displayName, 
                lm.content AS content, 
                lm.created_at AS createdAt, 
                lm.updated_at AS updatedAt,
                COALESCE(rc.count, 0) AS replyCount
            FROM lesson_comments lm
            JOIN users u ON lm.user_id = u.id
            LEFT JOIN ReplyCounts rc ON lm.id = rc.parent_comment_id
            WHERE lm.lesson_id = :lessonId AND lm.parent_comment_id IS NULL
            """, 
            countQuery = "SELECT COUNT(id) FROM lesson_comments WHERE lesson_id = :lessonId AND parent_comment_id IS NULL",
            nativeQuery = true)
    Page<RootLessonCommentProjection> findRootCommentsWithReplyCount(@Param("lessonId") Long lessonId, Pageable pageable);
}
