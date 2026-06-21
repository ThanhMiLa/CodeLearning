package com.thanhmila.codelearning.service.contest;

import com.thanhmila.codelearning.entity.contest.ContestEntity;
import com.thanhmila.codelearning.entity.contest.ContestParticipantEntity;
import com.thanhmila.codelearning.entity.contest.ContestProblemEntity;
import com.thanhmila.codelearning.entity.contest.ContestProblemAttemptEntity;
import com.thanhmila.codelearning.entity.contest.ContestRankingEntity;
import com.thanhmila.codelearning.entity.enums.OjVerdict;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.contest.ContestParticipantRepository;
import com.thanhmila.codelearning.repository.contest.ContestProblemRepository;
import com.thanhmila.codelearning.repository.contest.ContestProblemAttemptRepository;
import com.thanhmila.codelearning.repository.contest.ContestRankingRepository;
import com.thanhmila.codelearning.repository.contest.ContestRepository;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeProblemRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Duration;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.Map;
import java.util.Collections;
import com.thanhmila.codelearning.dto.response.ContestLeaderboardItemResponse;
import com.thanhmila.codelearning.dto.response.ContestProblemStatusResponse;
import com.thanhmila.codelearning.dto.response.ContestLeaderboardResponse;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ContestLeaderboardService {

    ContestProblemRepository contestProblemRepository;
    ContestProblemAttemptRepository attemptRepo;
    ContestRankingRepository rankingRepo;
    ContestRepository contestRepository;
    UserRepository userRepository;
    OnlineJudgeProblemRepository problemRepository;
    SimpMessagingTemplate messagingTemplate;

    @Transactional
    public void initializeLeaderboardForUser(Long contestId, Long userId) {
        ContestEntity contest = contestRepository.findById(contestId)
                .orElseThrow(() -> new AppException(ErrorCode.CONTEST_NOT_FOUND));

        com.thanhmila.codelearning.entity.user.UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));

        List<ContestProblemEntity> problems = contestProblemRepository.findByContestIdOrderByOrderIndex(contestId);

        boolean rankingExists = rankingRepo.findByContestIdAndUserId(contestId, userId).isPresent();
        if (!rankingExists) {
            rankingRepo.save(ContestRankingEntity.builder()
                    .contest(contest)
                    .user(user)
                    .problemsSolved(0)
                    .totalPenalty(0)
                    .build());
        }

        List<ContestProblemAttemptEntity> newAttempts = new ArrayList<>();
        for (ContestProblemEntity cp : problems) {
            boolean attemptExists = attemptRepo.findByContestIdAndUserIdAndProblemId(contestId, userId, cp.getProblem().getId()).isPresent();
            if (!attemptExists) {
                newAttempts.add(ContestProblemAttemptEntity.builder()
                        .contest(contest)
                        .user(user)
                        .problem(cp.getProblem())
                        .isSolved(false)
                        .failedAttemptsCount(0)
                        .build());
            }
        }
        if (!newAttempts.isEmpty()) {
            attemptRepo.saveAll(newAttempts);
        }

        log.info("Initialized leaderboard for user {} in contest {}: attempts created = {}", userId, contestId, newAttempts.size());
    }

    @Transactional
    public void processIpcpLeaderboard(Long contestId, Long userId, Long problemId, OjVerdict verdict, ZonedDateTime submitTime) {

        // --- BƯỚC 1: Lấy thông tin trạng thái bài toán ---
        Optional<ContestProblemAttemptEntity> attemptOpt = attemptRepo.findByContestIdAndUserIdAndProblemId(contestId, userId, problemId);
        
        ContestProblemAttemptEntity attempt;
        if (attemptOpt.isPresent()) {
            attempt = attemptOpt.get();
        } else {
            attempt = ContestProblemAttemptEntity.builder()
                    .contest(contestRepository.getReferenceById(contestId))
                    .user(userRepository.getReferenceById(userId))
                    .problem(problemRepository.getReferenceById(problemId))
                    .isSolved(false)
                    .failedAttemptsCount(0)
                    .build();
        }

        // --- BƯỚC 2: Rẽ nhánh theo luật ICPC ---
        if (verdict == OjVerdict.COMPILATION_ERROR || attempt.getIsSolved()) {
            // TH 2.1: Lỗi dịch hoặc đã giải được rồi -> Bỏ qua, không phạt
            // Hoặc là Internal Error (bạn có thể check verdict cho chính xác)
            return;
        }

        if (verdict != OjVerdict.ACCEPTED) {
            // TH 2.2: Nộp sai (WA, TLE, MLE, RTE...) -> Tăng số lần nộp sai lên 1
            attempt.setFailedAttemptsCount(attempt.getFailedAttemptsCount() + 1);
            attemptRepo.save(attempt);
            
            // Bắn tín hiệu WebSocket để frontend cập nhật ô bị trừ điểm (-1, -2...)
            broadcastLeaderboardUpdate(contestId, userId);
            return; 
        }

        // --- TỚI ĐÂY CHẮC CHẮN LÀ: NỘP ĐÚNG (AC) LẦN ĐẦU TIÊN ---

        // BƯỚC 3: Cập nhật trạng thái bài toán (solved = true, lưu thời gian)
        ContestEntity contest = contestRepository.findById(contestId)
                .orElseThrow(() -> new AppException(ErrorCode.CONTEST_NOT_FOUND));

        long solvedAtSeconds = calculateSecondsFromContestStart(contest.getStartTime(), submitTime);
        attempt.setIsSolved(true);
        attempt.setSolvedAtSeconds((int) solvedAtSeconds);
        attemptRepo.save(attempt);

        // BƯỚC 4: Tính tổng Penalty và cập nhật Bảng Xếp Hạng (contest_rankings)
        long penaltyForThisProblem = solvedAtSeconds + (attempt.getFailedAttemptsCount() * 1200L); // 1 lần sai = 20 phút = 1200s

        ContestRankingEntity ranking = rankingRepo.findByContestIdAndUserId(contestId, userId)
                .orElseGet(() -> ContestRankingEntity.builder()
                        .contest(contestRepository.getReferenceById(contestId))
                        .user(userRepository.getReferenceById(userId))
                        .problemsSolved(0)
                        .totalPenalty(0)
                        .build());

        ranking.setProblemsSolved(ranking.getProblemsSolved() + 1);
        ranking.setTotalPenalty(ranking.getTotalPenalty() + (int) penaltyForThisProblem);
        rankingRepo.save(ranking);

        // BƯỚC 5: Bắn tín hiệu WebSocket báo hiệu Bảng Xếp Hạng vừa thay đổi
        broadcastLeaderboardUpdate(contestId, userId);
        
        log.info("Leaderboard updated for contest {}, user {}: +1 solved, +{} penalty", contestId, userId, penaltyForThisProblem);
    }

    private void broadcastLeaderboardUpdate(Long contestId, Long userId) {
        String topic = "/topic/contests/" + contestId + "/leaderboard";
        String messagePayload = "{\"event\": \"LEADERBOARD_UPDATED\", \"contest_id\": " + contestId + ", \"user_id\": " + userId + "}";
        messagingTemplate.convertAndSend(topic, messagePayload);
    }

    private long calculateSecondsFromContestStart(ZonedDateTime startTime, ZonedDateTime submitTime) {
        long seconds = Duration.between(startTime, submitTime).getSeconds();
        return Math.max(0, seconds); // Ensure it's not negative if submitted exactly at start or slightly before due to clock drift
    }

    @Transactional(readOnly = true)
    public ContestLeaderboardResponse getLeaderboard(Long contestId) {
        ContestEntity contest = contestRepository.findById(contestId)
                .orElseThrow(() -> new AppException(ErrorCode.CONTEST_NOT_FOUND));

        List<ContestRankingEntity> rankings = rankingRepo.findByContestIdOrderByProblemsSolvedDescTotalPenaltyAscUpdatedAtAsc(contestId);
        
        // Lấy tất cả lịch sử làm bài của contest này để hiển thị chi tiết (ô xanh/đỏ)
        List<ContestProblemAttemptEntity> allAttempts = attemptRepo.findByContestId(contestId);
        
        // Gom nhóm theo userId để truy xuất cho nhanh (tránh query N+1)
        Map<Long, List<ContestProblemAttemptEntity>> userAttemptsMap = allAttempts.stream()
                .collect(Collectors.groupingBy(attempt -> attempt.getUser().getId()));
        
        List<ContestLeaderboardItemResponse> finalItems = new ArrayList<>();
        
        for (int i = 0; i < rankings.size(); i++) {
            ContestRankingEntity ranking = rankings.get(i);
            Long userId = ranking.getUser().getId();
            
            // Map danh sách các bài đã làm của user này
            List<ContestProblemAttemptEntity> userAttempts = userAttemptsMap.getOrDefault(userId, Collections.emptyList());
            List<ContestProblemStatusResponse> problemStatuses = userAttempts.stream()
                    .map(attempt -> ContestProblemStatusResponse.builder()
                            .problemId(attempt.getProblem().getId())
                            .isSolved(attempt.getIsSolved())
                            .failedAttemptsCount(attempt.getFailedAttemptsCount())
                            .solvedAtSeconds(attempt.getSolvedAtSeconds())
                            .build())
                    .collect(Collectors.toList());

            finalItems.add(ContestLeaderboardItemResponse.builder()
                    .userId(userId)
                    .username(ranking.getUser().getUsername())
                    .problemsSolved(ranking.getProblemsSolved())
                    .totalPenalty(ranking.getTotalPenalty())
                    .rank(i + 1)
                    .problemStatuses(problemStatuses)
                    .build());
        }

        return ContestLeaderboardResponse.builder()
                .contestId(contestId)
                .title(contest.getTitle())
                .startTime(contest.getStartTime())
                .endTime(contest.getEndTime())
                .status(contest.getStatus().name())
                .leaderboard(finalItems)
                .build();
    }
}
