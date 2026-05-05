package com.thanhmila.codelearning.repository;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.repository.projection.OjProblemDetailProjection;
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



    @Query(value = """
        SELECT 
            olp.id, 
            olp.title, 
            olp.description,
            olp.input_description,
            olp.output_description,
            olp.constraints,
            olp.example_input,
            olp.example_output,
            olp.hint,
            olp.difficulty::varchar AS difficulty,
            (SELECT string_agg(t.name, ',')
            FROM problem_tags t 
            JOIN problem_tag_mappings ptm ON t.id = ptm.tag_id 
            WHERE ptm.problem_id = olp.id) AS tagsRaw,
            latest_sub.source_code AS latestSourceCode,
            EXISTS (
                SELECT 1 
                FROM online_judge_submissions ac_sub 
                WHERE ac_sub.problem_id = olp.id 
                  AND ac_sub.user_id = :userId 
                  AND ac_sub.verdict = 'ACCEPTED'
            ) AS isAccepted
        FROM online_judge_problems olp
        LEFT JOIN LATERAL (
            SELECT source_code 
            FROM online_judge_submissions sub 
            WHERE sub.problem_id = olp.id 
              AND sub.user_id = :userId 
            ORDER BY sub.submitted_at DESC 
            LIMIT 1
        ) latest_sub ON true
        WHERE olp.id = :problemId
        """, nativeQuery = true)
    Optional<OjProblemDetailProjection> findProblemDetailWithStatus(
            @Param("problemId") Long problemId, 
            @Param("userId") Long userId
    );

    @Query("SELECT p.lesson.id FROM OnlineJudgeProblemEntity p WHERE p.id = :problemId")
    Long findLessonIdByProblemId(@Param("problemId") Long problemId);

}
