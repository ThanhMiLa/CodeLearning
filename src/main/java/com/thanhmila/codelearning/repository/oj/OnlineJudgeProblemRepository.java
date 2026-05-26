package com.thanhmila.codelearning.repository.oj;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.repository.projection.OjProblemDetailProjection;
import com.thanhmila.codelearning.repository.projection.OjProblemListProjection;
import com.thanhmila.codelearning.repository.projection.OjPracticeProblemProjection;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

@Repository
public interface OnlineJudgeProblemRepository extends JpaRepository<OnlineJudgeProblemEntity, Long>, JpaSpecificationExecutor<OnlineJudgeProblemEntity> {

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
            COALESCE(latest_accepted_sub.source_code, latest_any_sub.source_code) AS latestSourceCode,
            CASE WHEN :userId IS NOT NULL THEN
                EXISTS (
                    SELECT 1 
                    FROM online_judge_submissions ac_sub 
                    WHERE ac_sub.problem_id = olp.id 
                      AND ac_sub.user_id = :userId 
                      AND ac_sub.verdict = 'ACCEPTED'
                )
            ELSE FALSE END AS isAccepted
        FROM online_judge_problems olp
        LEFT JOIN LATERAL (
            SELECT source_code 
            FROM online_judge_submissions sub 
            WHERE :userId IS NOT NULL 
              AND sub.problem_id = olp.id 
              AND sub.user_id = :userId 
              AND sub.verdict = 'ACCEPTED'
            ORDER BY sub.submitted_at DESC 
            LIMIT 1
        ) latest_accepted_sub ON true
        LEFT JOIN LATERAL (
            SELECT source_code 
            FROM online_judge_submissions sub 
            WHERE :userId IS NOT NULL 
              AND sub.problem_id = olp.id 
              AND sub.user_id = :userId 
            ORDER BY sub.submitted_at DESC 
            LIMIT 1
        ) latest_any_sub ON true
        WHERE olp.id = :problemId
        """, nativeQuery = true)
    Optional<OjProblemDetailProjection> findProblemDetailWithStatus(
            @Param("problemId") Long problemId,
            @Param("userId") Long userId
    );

    @Query("SELECT p.lesson.id FROM OnlineJudgeProblemEntity p WHERE p.id = :problemId")
    Long findLessonIdByProblemId(@Param("problemId") Long problemId);

    @Query("SELECT p.contest.id FROM OnlineJudgeProblemEntity p WHERE p.id = :problemId")
    Long findContestIdByProblemId(@Param("problemId") Long problemId);

    @Query(value = """
            SELECT
                olp.id AS id,
                olp.title AS title,
                olp.difficulty::varchar AS difficulty,
                olp.total_submissions AS totalSubmissions,
                olp.total_accepted AS totalAccepted,
                CASE WHEN :userId IS NOT NULL THEN
                    EXISTS (
                        SELECT 1
                        FROM online_judge_submissions ols
                        WHERE ols.problem_id = olp.id
                          AND ols.user_id = :userId
                          AND ols.verdict = 'ACCEPTED'
                    )
                ELSE FALSE END AS isAccepted
            FROM online_judge_problems olp
            WHERE olp.is_public = true AND olp.is_active = true
            """,
            countQuery = """
            SELECT COUNT(*)
            FROM online_judge_problems olp
            WHERE olp.is_public = true AND olp.is_active = true
            """,
            nativeQuery = true)
    Page<OjPracticeProblemProjection> findPracticeProblems(
            @Param("userId") Long userId,
            Pageable pageable);
}

