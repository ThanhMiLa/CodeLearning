package com.thanhmila.codelearning.service.contest;

import com.thanhmila.codelearning.dto.request.ContestCreateRequest;
import com.thanhmila.codelearning.dto.request.ContestUpdateRequest;
import com.thanhmila.codelearning.dto.request.AddContestProblemsRequest;
import com.thanhmila.codelearning.dto.request.ContestProblemReorderRequest;
import com.thanhmila.codelearning.dto.request.ContestRegisterRequest;
import com.thanhmila.codelearning.dto.response.ContestListResponse;
import com.thanhmila.codelearning.dto.response.ContestResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;

import com.thanhmila.codelearning.entity.contest.ContestEntity;
import com.thanhmila.codelearning.entity.contest.ContestProblemEntity;
import com.thanhmila.codelearning.entity.contest.ContestParticipantEntity;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.entity.enums.ContestStatus;
import com.thanhmila.codelearning.entity.enums.ProblemScope;
import com.thanhmila.codelearning.entity.user.TeacherEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.ContestMapper;
import com.thanhmila.codelearning.repository.contest.ContestRepository;
import com.thanhmila.codelearning.repository.contest.ContestProblemRepository;
import com.thanhmila.codelearning.repository.contest.ContestParticipantRepository;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeProblemRepository;
import com.thanhmila.codelearning.repository.user.TeacherRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import com.thanhmila.codelearning.configuration.RabbitMQConfig;
import com.thanhmila.codelearning.dto.message.ContestStatusMessage;
import java.time.Instant;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;


@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ContestService {
    ContestRepository contestRepository;
    TeacherRepository teacherRepository;
    PasswordEncoder passwordEncoder;
    ContestMapper contestMapper;
    RabbitTemplate rabbitTemplate;
    ContestProblemRepository contestProblemRepository;
    OnlineJudgeProblemRepository onlineJudgeProblemRepository;
    ContestParticipantRepository contestParticipantRepository;
    UserRepository userRepository;

    public PageResponse<ContestListResponse> getContests(int page, int size, Long userId) {
        Pageable pageable = PageRequest.of(page, size);
        Page<ContestListResponse> contestPage = contestRepository.findAllContestsWithCustomSort(pageable);
        
        if (userId != null && contestPage.getContent() != null && !contestPage.getContent().isEmpty()) {
            java.util.List<Long> registeredContestIds = contestParticipantRepository.findContestIdsByUserId(userId);
            java.util.Set<Long> registeredSet = new java.util.HashSet<>(registeredContestIds);
            contestPage.getContent().forEach(c -> c.setRegistered(registeredSet.contains(c.getId())));
        }

        return PageResponse.from(contestPage);
    }

    public ContestResponse getContestById(Long contestId, Long userId) {
        ContestEntity contest = contestRepository.findById(contestId)
                .orElseThrow(() -> new AppException(ErrorCode.CONTEST_NOT_FOUND));

        boolean isParticipant = contestParticipantRepository.findByContestIdAndUserId(contestId, userId).isPresent();
        Long teacherId = teacherRepository.findIdByUserId(userId);
        boolean isCreator = teacherId != null && contest.getCreatedByTeacher().getId().equals(teacherId);

        if (!isParticipant && !isCreator) {
            throw new AppException(ErrorCode.CONTEST_NOT_JOINED);
        }

        return contestMapper.toContestResponse(contest);
    }

    public List<com.thanhmila.codelearning.dto.response.OjLessonProblemResponse> getContestProblems(Long contestId, Long userId) {
        ContestEntity contest = contestRepository.findById(contestId)
                .orElseThrow(() -> new AppException(ErrorCode.CONTEST_NOT_FOUND));

        boolean isParticipant = contestParticipantRepository.findByContestIdAndUserId(contestId, userId).isPresent();
        Long teacherId = teacherRepository.findIdByUserId(userId);
        boolean isCreator = teacherId != null && contest.getCreatedByTeacher().getId().equals(teacherId);

        if (!isParticipant && !isCreator) {
            throw new AppException(ErrorCode.CONTEST_NOT_JOINED);
        }

        List<com.thanhmila.codelearning.repository.projection.OjProblemListProjection> ojProblemList = 
                onlineJudgeProblemRepository.findProblemsByContestWithStatus(contestId, userId);
        
        return ojProblemList.stream()
                .map(projection -> com.thanhmila.codelearning.dto.response.OjLessonProblemResponse.builder()
                        .id(projection.getId())
                        .title(projection.getTitle())
                        .difficulty(com.thanhmila.codelearning.entity.enums.ProblemDifficulty.valueOf(projection.getDifficulty()))
                        .isAccepted(projection.getIsAccepted())
                        .build())
                .collect(Collectors.toList());
    }

    @Transactional
    public ContestResponse createContest(ContestCreateRequest request, Long userId) {
        if (request.getStartTime().isAfter(request.getEndTime()) || request.getStartTime().isEqual(request.getEndTime())) {
            throw new AppException(ErrorCode.INVALID_REQUEST);
        }

        Long teacherId = teacherRepository.findIdByUserId(userId);
        if (teacherId == null) {
            throw new AppException(ErrorCode.ACCESS_DENIED);
        }

        TeacherEntity teacher = teacherRepository.findById(teacherId)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));

        ContestEntity contest = ContestEntity.builder()
                .title(request.getTitle())
                .description(request.getDescription())
                .passwordHash(StringUtils.hasText(request.getPassword()) ? passwordEncoder.encode(request.getPassword()) : null)
                .scoringRule(request.getScoringRule())
                .startTime(request.getStartTime())
                .endTime(request.getEndTime())
                .status(ContestStatus.UPCOMING)
                .createdByTeacher(teacher)
                .build();

        ContestEntity savedContest = contestRepository.save(contest);

        publishStartMessage(savedContest);
        publishEndMessage(savedContest);

        return contestMapper.toContestResponse(savedContest);
    }

    @Transactional
    public ContestResponse updateContest(Long contestId, ContestUpdateRequest request, Long userId) {
        ContestEntity contest = contestRepository.findById(contestId)
                .orElseThrow(() -> new AppException(ErrorCode.CONTEST_NOT_FOUND));

        Long teacherId = teacherRepository.findIdByUserId(userId);
        if (teacherId == null || !contest.getCreatedByTeacher().getId().equals(teacherId)) {
            throw new AppException(ErrorCode.ACCESS_DENIED);
        }

        if (request.getStartTime().isAfter(request.getEndTime()) || request.getStartTime().isEqual(request.getEndTime())) {
            throw new AppException(ErrorCode.INVALID_REQUEST);
        }

        boolean startTimeChanged = !contest.getStartTime().equals(request.getStartTime());
        boolean endTimeChanged = !contest.getEndTime().equals(request.getEndTime());

        contest.setTitle(request.getTitle() == null || request.getTitle().isEmpty() ? contest.getTitle() : request.getTitle());
        contest.setDescription(request.getDescription() == null || request.getDescription().isEmpty() ? contest.getDescription() : request.getDescription());
        
        String oldPassword = request.getOldPassword();
        String newPassword = request.getNewPassword();

        boolean isPasswordChangeRequested = StringUtils.hasText(newPassword) || StringUtils.hasText(oldPassword);
        if (isPasswordChangeRequested) {
            boolean isCurrentlyPrivate = contest.getPasswordHash() != null;
            if (isCurrentlyPrivate && (!StringUtils.hasText(oldPassword) || !passwordEncoder.matches(oldPassword, contest.getPasswordHash()))) {
                throw new AppException(ErrorCode.CONTEST_PASSWORD_INVALID);
            }
            contest.setPasswordHash(StringUtils.hasText(newPassword) ? passwordEncoder.encode(newPassword) : null);
        }
        
        contest.setScoringRule(request.getScoringRule());
        contest.setStartTime(request.getStartTime());
        contest.setEndTime(request.getEndTime());

        if (startTimeChanged || endTimeChanged) {
            ZonedDateTime now = ZonedDateTime.now();
            if (contest.getEndTime().isBefore(now)) {
                contest.setStatus(ContestStatus.ENDED);
            } else if (contest.getStartTime().isAfter(now)) {
                contest.setStatus(ContestStatus.UPCOMING);
            } else {
                contest.setStatus(ContestStatus.RUNNING);
            }
        }

        ContestEntity savedContest = contestRepository.save(contest);

        if (startTimeChanged && savedContest.getStatus() == ContestStatus.UPCOMING) {
            publishStartMessage(savedContest);
        }
        if (endTimeChanged && savedContest.getStatus() != ContestStatus.ENDED) {
            publishEndMessage(savedContest);
        }

        return contestMapper.toContestResponse(savedContest);
    }

    @Transactional
    public void addProblemsToContest(Long contestId, AddContestProblemsRequest request, Long userId) {
        ContestEntity contest = contestRepository.findById(contestId)
                .orElseThrow(() -> new AppException(ErrorCode.CONTEST_NOT_FOUND));

        Long teacherId = teacherRepository.findIdByUserId(userId);
        if (teacherId == null || !contest.getCreatedByTeacher().getId().equals(teacherId)) {
            throw new AppException(ErrorCode.ACCESS_DENIED);
        }

        if (contest.getStatus() != ContestStatus.UPCOMING) {
            throw new AppException(ErrorCode.CONTEST_ALREADY_STARTED);
        }

        if (request.getProblemIds() == null || request.getProblemIds().isEmpty()) {
            throw new AppException(ErrorCode.INVALID_REQUEST);
        }

        // Ensure no duplicates in the input list
        List<Long> problemIds = request.getProblemIds();
        long distinctCount = problemIds.stream().distinct().count();
        if (distinctCount != problemIds.size()) {
            throw new AppException(ErrorCode.INVALID_REQUEST);
        }

        // Fetch all requested problems in one query
        List<OnlineJudgeProblemEntity> problems = onlineJudgeProblemRepository.findAllById(problemIds);
        if (problems.size() != problemIds.size()) {
            throw new AppException(ErrorCode.OJ_PROBLEM_NOT_FOUND);
        }

        // Map problems by ID for quick lookup and preserving request order
        Map<Long, OnlineJudgeProblemEntity> problemMap = problems.stream()
                .collect(Collectors.toMap(OnlineJudgeProblemEntity::getId, p -> p));

        // Get existing problems in the contest to check for duplicates
        List<ContestProblemEntity> currentProblems = contestProblemRepository.findByContestIdOrderByOrderIndex(contestId);
        Set<Long> existingProblemIds = currentProblems.stream()
                .map(cp -> cp.getProblem().getId())
                .collect(Collectors.toSet());

        int currentMaxOrder = contestProblemRepository.findMaxOrderIndexByContestId(contestId);
        List<ContestProblemEntity> newContestProblems = new ArrayList<>();

        for (int i = 0; i < problemIds.size(); i++) {
            Long problemId = problemIds.get(i);
            OnlineJudgeProblemEntity problem = problemMap.get(problemId);

            // Validate constraints
            if (problem == null || problem.getProblemScope() != ProblemScope.CONTEST ||
                    !Boolean.TRUE.equals(problem.getIsActive()) ||
                    !Boolean.TRUE.equals(problem.getIsPublic())) {
                throw new AppException(ErrorCode.INVALID_REQUEST);
            }

            // Check if already in the contest
            if (existingProblemIds.contains(problemId)) {
                throw new AppException(ErrorCode.INVALID_REQUEST);
            }

            ContestProblemEntity contestProblem = ContestProblemEntity.builder()
                    .contest(contest)
                    .problem(problem)
                    .orderIndex(currentMaxOrder + i + 1)
                    .build();

            newContestProblems.add(contestProblem);
        }

        contestProblemRepository.saveAll(newContestProblems);
    }

    @Transactional
    public void reorderContestProblems(Long contestId, List<ContestProblemReorderRequest> requests, Long userId) {
        ContestEntity contest = contestRepository.findById(contestId)
                .orElseThrow(() -> new AppException(ErrorCode.CONTEST_NOT_FOUND));

        Long teacherId = teacherRepository.findIdByUserId(userId);
        if (teacherId == null || !contest.getCreatedByTeacher().getId().equals(teacherId)) {
            throw new AppException(ErrorCode.ACCESS_DENIED);
        }

        if (contest.getStatus() != ContestStatus.UPCOMING) {
            throw new AppException(ErrorCode.CONTEST_ALREADY_STARTED);
        }

        if (requests == null || requests.isEmpty()) {
            throw new AppException(ErrorCode.INVALID_REQUEST);
        }

        List<ContestProblemEntity> contestProblemEntityList = contestProblemRepository.findByContestIdOrderByOrderIndex(contestId);
        if (contestProblemEntityList.size() != requests.size()) {
            throw new AppException(ErrorCode.INVALID_REQUEST);
        }

        // Ensure all requests have unique problemIds and unique, positive orderIndex values
        long uniqueProblemIds = requests.stream()
                .map(ContestProblemReorderRequest::getProblemId)
                .distinct()
                .count();
        long uniqueOrderIndices = requests.stream().
                map(ContestProblemReorderRequest::getOrderIndex)
                .distinct()
                .count();
        if (uniqueProblemIds != requests.size() || uniqueOrderIndices != requests.size()) {
            throw new AppException(ErrorCode.INVALID_REQUEST);
        }

        Map<Long, ContestProblemEntity> problemMap = contestProblemEntityList.stream()
                .collect(Collectors.toMap(
                        cp -> cp.getProblem().getId(),
                        cp -> cp)
                );

        // Verify all request problemIds are valid and part of this contest
        for (ContestProblemReorderRequest req : requests) {
            if (req.getOrderIndex() <= 0 || !problemMap.containsKey(req.getProblemId())) {
                throw new AppException(ErrorCode.INVALID_REQUEST);
            }
        }

        // Step 1: Temporarily set all orderIndex values to satisfy UNIQUE constraints
        for (ContestProblemEntity cp : contestProblemEntityList) {
            cp.setOrderIndex(cp.getId().intValue() + 100000);
        }
        contestProblemRepository.saveAllAndFlush(contestProblemEntityList);

        // Step 2: Set the requested orderIndex values
        for (ContestProblemReorderRequest req : requests) {
            ContestProblemEntity cp = problemMap.get(req.getProblemId());
            cp.setOrderIndex(req.getOrderIndex());
        }
        contestProblemRepository.saveAll(contestProblemEntityList);
    }

    @Transactional
    public void deleteProblemFromContest(Long contestId, Long problemId, Long userId) {
        ContestEntity contest = contestRepository.findById(contestId)
                .orElseThrow(() -> new AppException(ErrorCode.CONTEST_NOT_FOUND));

        Long teacherId = teacherRepository.findIdByUserId(userId);
        if (teacherId == null || !contest.getCreatedByTeacher().getId().equals(teacherId)) {
            throw new AppException(ErrorCode.ACCESS_DENIED);
        }

        if (contest.getStatus() != ContestStatus.UPCOMING) {
            throw new AppException(ErrorCode.CONTEST_ALREADY_STARTED);
        }

        ContestProblemEntity contestProblem = contestProblemRepository.findByContestIdAndProblemId(contestId, problemId)
                .orElseThrow(() -> new AppException(ErrorCode.INVALID_REQUEST));

        contestProblemRepository.delete(contestProblem);
        contestProblemRepository.flush();

        // Re-index remaining problems
        List<ContestProblemEntity> remainingProblems = contestProblemRepository.findByContestIdOrderByOrderIndex(contestId);

        // Step 1: Set temporary order index values
        for (ContestProblemEntity cp : remainingProblems) {
            cp.setOrderIndex(cp.getId().intValue() + 100000);
        }
        contestProblemRepository.saveAllAndFlush(remainingProblems);

        // Step 2: Assign consecutive 1-based order index values
        for (int i = 0; i < remainingProblems.size(); i++) {
            remainingProblems.get(i).setOrderIndex(i + 1);
        }
        contestProblemRepository.saveAll(remainingProblems);
    }

    @Transactional
    public void registerContest(Long contestId, ContestRegisterRequest request, Long userId) {
        ContestEntity contest = contestRepository.findById(contestId)
                .orElseThrow(() -> new AppException(ErrorCode.CONTEST_NOT_FOUND));

        boolean isAlreadyRegistered = contestParticipantRepository.findByContestIdAndUserId(contestId, userId).isPresent();
        if (isAlreadyRegistered) {
            return; // Succeed silently
        }

        if (contest.getStatus() != ContestStatus.UPCOMING && contest.getStatus() != ContestStatus.RUNNING) {
            throw new AppException(ErrorCode.INVALID_REQUEST);
        }

        if (contest.getPasswordHash() != null) {
            if (!StringUtils.hasText(request.getPassword()) || !passwordEncoder.matches(request.getPassword(), contest.getPasswordHash())) {
                throw new AppException(ErrorCode.CONTEST_PASSWORD_INVALID);
            }
        }

        ContestParticipantEntity participant = ContestParticipantEntity.builder()
                .contest(contestRepository.getReferenceById(contestId))
                .user(userRepository.getReferenceById(userId))
                .build();

        contestParticipantRepository.save(participant);
    }

    private void publishStartMessage(ContestEntity contest) {
        long delayStart = contest.getStartTime().toInstant().toEpochMilli() - Instant.now().toEpochMilli();
        if (delayStart > 0) {
            ContestStatusMessage startMsg = ContestStatusMessage.builder()
                    .contestId(contest.getId().toString())
                    .action("START")
                    .targetTime(contest.getStartTime().toInstant())
                    .build();
            rabbitTemplate.convertAndSend(RabbitMQConfig.CONTEST_EXCHANGE, RabbitMQConfig.ROUTING_KEY_RUNNING, startMsg, message -> {
                message.getMessageProperties().setHeader("x-delay", delayStart);
                return message;
            });
            log.info("Scheduled START message for contest {} with delay {}ms", contest.getId(), delayStart);
        }
    }

    private void publishEndMessage(ContestEntity contest) {
        long delayEnd = contest.getEndTime().toInstant().toEpochMilli() - Instant.now().toEpochMilli();
        if (delayEnd > 0) {
            ContestStatusMessage endMsg = ContestStatusMessage.builder()
                    .contestId(contest.getId().toString())
                    .action("END")
                    .targetTime(contest.getEndTime().toInstant())
                    .build();
            rabbitTemplate.convertAndSend(RabbitMQConfig.CONTEST_EXCHANGE, RabbitMQConfig.ROUTING_KEY_ENDED, endMsg, message -> {
                message.getMessageProperties().setHeader("x-delay", delayEnd);
                return message;
            });
            log.info("Scheduled END message for contest {} with delay {}ms", contest.getId(), delayEnd);
        }
    }
}
