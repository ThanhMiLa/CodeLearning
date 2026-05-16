package com.thanhmila.codelearning.repository.oj;

import com.thanhmila.codelearning.dto.judge0.SubmissionCountDto;
import com.thanhmila.codelearning.entity.enums.OjVerdict;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeSubmissionDetailEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface OnlineJudgeSubmissionDetailRepository extends JpaRepository<OnlineJudgeSubmissionDetailEntity, Long> {

    // 1. Tìm Detail bằng Token (Dành cho Webhook gọi về)
    Optional<OnlineJudgeSubmissionDetailEntity> findByToken(String token);

    // 2. Query "1 mũi tên trúng 2 đích": Đếm tổng số và số đã chấm
    @Query("""
        SELECT new com.thanhmila.codelearning.dto.judge0.SubmissionCountDto(
            COUNT(d.id), 
            SUM(CASE WHEN d.verdict != 'PENDING' THEN 1L ELSE 0L END)
        ) 
        FROM OnlineJudgeSubmissionDetailEntity d 
        WHERE d.submission.id = :submissionId
    """)
    SubmissionCountDto countTestcasesStatus(@Param("submissionId") Long submissionId);

    // 3. Tìm lỗi đầu tiên để chốt Final Verdict
    Optional<OnlineJudgeSubmissionDetailEntity> findFirstBySubmissionIdAndVerdictNotOrderByTestcaseOrderIndexAsc(
            Long submissionId,
            OjVerdict verdict
    );
}

