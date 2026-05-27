package com.thanhmila.codelearning.repository.contest;

import com.thanhmila.codelearning.dto.response.ContestListResponse;
import com.thanhmila.codelearning.entity.contest.ContestEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContestRepository extends JpaRepository<ContestEntity, Long> {
    List<ContestEntity> findByCreatedByTeacherId(Long teacherId);

    @Query(value = """
            SELECT new com.thanhmila.codelearning.dto.response.ContestListResponse(
                c.id, c.title, c.startTime, c.endTime, c.status,
                t.fullName,
                CAST(COUNT(p.id) AS long),
                CASE WHEN (c.passwordHash IS NULL OR c.passwordHash = '') THEN true ELSE false END
            )
            FROM ContestEntity c
            JOIN c.createdByTeacher t
            LEFT JOIN c.participants p
            GROUP BY c.id, c.title, c.startTime, c.endTime, c.status, t.fullName, c.passwordHash
            ORDER BY
                CASE cast(c.status as string)
                    WHEN 'RUNNING' THEN 1
                    WHEN 'UPCOMING' THEN 2
                    WHEN 'ENDED' THEN 3
                    ELSE 4
                END ASC,
                c.startTime DESC
            """,
            countQuery = "SELECT COUNT(c.id) FROM ContestEntity c")
    Page<ContestListResponse> findAllContestsWithCustomSort(Pageable pageable);
}

