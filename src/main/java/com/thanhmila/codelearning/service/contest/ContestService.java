package com.thanhmila.codelearning.service.contest;

import com.thanhmila.codelearning.dto.request.ContestCreateRequest;
import com.thanhmila.codelearning.dto.request.ContestUpdateRequest;
import com.thanhmila.codelearning.dto.response.ContestListResponse;
import com.thanhmila.codelearning.dto.response.ContestResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;

import com.thanhmila.codelearning.entity.contest.ContestEntity;
import com.thanhmila.codelearning.entity.enums.ContestStatus;
import com.thanhmila.codelearning.entity.user.TeacherEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.ContestMapper;
import com.thanhmila.codelearning.repository.contest.ContestRepository;
import com.thanhmila.codelearning.repository.user.TeacherRepository;
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

    public PageResponse<ContestListResponse> getContests(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<ContestListResponse> contestPage = contestRepository.findAllContestsWithCustomSort(pageable);
        return PageResponse.from(contestPage);
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
