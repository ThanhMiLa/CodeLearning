package com.thanhmila.codelearning.repository.oj;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.repository.projection.OjProblemDetailProjection;
import com.thanhmila.codelearning.repository.projection.OjProblemListProjection;
import com.thanhmila.codelearning.repository.projection.OjPracticeProblemProjection;
import com.thanhmila.codelearning.repository.projection.ProblemAccessProjection;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

@Repository
public interface OnlineJudgeProblemRepository extends JpaRepository<OnlineJudgeProblemEntity, Long>, JpaSpecificationExecutor<OnlineJudgeProblemEntity> {
    Optional<OnlineJudgeProblemEntity> findByIdAndIsPublicTrue(Long id);

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
            JOIN lesson_problems lp ON lp.problem_id = olp.id
            WHERE lp.lesson_id = :lessonId
            ORDER BY lp.order_index ASC
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
            CASE 
                WHEN olp.problem_scope::varchar = 'CONTEST' 
                     OR EXISTS (SELECT 1 FROM contest_problems cp WHERE cp.problem_id = olp.id) 
                THEN NULL
                ELSE olp.difficulty::varchar
            END AS difficulty,
            (SELECT string_agg(t.name, ',')
             FROM problem_tags t 
             JOIN problem_tag_mappings ptm ON t.id = ptm.tag_id 
             WHERE ptm.problem_id = olp.id) AS tagsRaw,
            CASE 
                WHEN (olp.problem_scope::varchar = 'CONTEST' OR EXISTS (SELECT 1 FROM contest_problems cp WHERE cp.problem_id = olp.id)) AND :contestId IS NULL
                THEN NULL
                ELSE COALESCE(latest_accepted_sub.source_code, latest_any_sub.source_code)
            END AS latestSourceCode,
            CASE WHEN :userId IS NOT NULL THEN
                CASE
                    WHEN (olp.problem_scope::varchar = 'CONTEST' OR EXISTS (SELECT 1 FROM contest_problems cp WHERE cp.problem_id = olp.id)) AND :contestId IS NULL
                    THEN NULL
                    ELSE EXISTS (
                        SELECT 1 
                        FROM online_judge_submissions ac_sub 
                        WHERE ac_sub.problem_id = olp.id 
                          AND ac_sub.user_id = :userId 
                          AND (:contestId IS NULL OR ac_sub.contest_id = :contestId)
                          AND ac_sub.verdict = 'ACCEPTED'
                    )
                END
            ELSE FALSE END AS isAccepted
        FROM online_judge_problems olp
        LEFT JOIN LATERAL (
            SELECT source_code 
            FROM online_judge_submissions sub 
            WHERE :userId IS NOT NULL 
              AND sub.problem_id = olp.id 
              AND sub.user_id = :userId 
              AND (:contestId IS NULL OR sub.contest_id = :contestId)
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
              AND (:contestId IS NULL OR sub.contest_id = :contestId)
            ORDER BY sub.submitted_at DESC 
            LIMIT 1
        ) latest_any_sub ON true
        WHERE olp.id = :problemId
        """, nativeQuery = true)
    Optional<OjProblemDetailProjection> findProblemDetailWithStatus(
            @Param("problemId") Long problemId,
            @Param("userId") Long userId,
            @Param("contestId") Long contestId
    );



    @Query("SELECT cp.contest.id " +
            "FROM ContestProblemEntity cp " +
            "WHERE cp.problem.id = :problemId")
    List<Long> findContestIdsByProblemId(@Param("problemId") Long problemId);

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

    @Query("SELECT p.isPublic AS isPublic " +
            "FROM OnlineJudgeProblemEntity p " +
            "WHERE p.id = :problemId")
    Optional<ProblemAccessProjection> findAccessDetailsByProblemId(@Param("problemId") Long problemId);

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
                      AND ols.contest_id = :contestId
                      AND ols.verdict = 'ACCEPTED'
                ) AS is_accepted
            FROM online_judge_problems olp
            JOIN contest_problems cp ON cp.problem_id = olp.id
            WHERE cp.contest_id = :contestId
            ORDER BY cp.order_index ASC
            """, nativeQuery = true)
    List<OjProblemListProjection> findProblemsByContestWithStatus(
            @Param("contestId") Long contestId,
            @Param("userId") Long userId);

    @Modifying
    @Query("UPDATE OnlineJudgeProblemEntity p SET p.totalSubmissions = p.totalSubmissions + 1 WHERE p.id = :problemId")
    void incrementTotalSubmissions(@Param("problemId") Long problemId);

    @Modifying
    @Query("UPDATE OnlineJudgeProblemEntity p SET p.totalAccepted = p.totalAccepted + 1 WHERE p.id = :problemId")
    void incrementTotalAccepted(@Param("problemId") Long problemId);
}

