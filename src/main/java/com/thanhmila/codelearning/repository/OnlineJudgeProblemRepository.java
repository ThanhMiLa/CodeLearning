package com.thanhmila.codelearning.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.repository.projection.OjProblemListProjection;

@Repository
public interface OnlineJudgeProblemRepository extends JpaRepository<OnlineJudgeProblemEntity, Long> {

    @Query(value = """
            SELECT
                olp.id AS id,
                olp.title AS title,
                olp.difficulty::varchar AS difficulty,
                EXISTS (
                    SELECT 1
                    FROM online_judge_submissions ols
                    WHERE ols.problem_id = olp.id
                      AND ols.user_id = :userId
                      AND ols.verdict = 'ACCEPTED'
                ) AS is_accepted
            FROM online_judge_problems olp
            WHERE olp.lesson_id = :lessonId
            """, nativeQuery = true)
    List<OjProblemListProjection> findProblemsByLessonWithStatus(
            @Param("lessonId") Long lessonId,
            @Param("userId") Long userId);

}
