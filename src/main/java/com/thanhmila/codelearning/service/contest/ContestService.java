package com.thanhmila.codelearning.service.contest;

import com.thanhmila.codelearning.dto.request.ContestCreateRequest;
import com.thanhmila.codelearning.dto.response.ContestResponse;
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
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ContestService {
    ContestRepository contestRepository;
    TeacherRepository teacherRepository;
    PasswordEncoder passwordEncoder;
    ContestMapper contestMapper;

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

        return contestMapper.toContestResponse(savedContest);
    }
}
