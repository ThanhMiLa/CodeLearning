package com.thanhmila.codelearning.service.oj;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.dto.response.OjPracticeProblemResponse;
import com.thanhmila.codelearning.dto.response.OjAdminProblemResponse;
import com.thanhmila.codelearning.entity.enums.OjVerdict;
import com.thanhmila.codelearning.entity.enums.ProblemDifficulty;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeProblemRepository;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import com.thanhmila.codelearning.dto.response.OjProblemDetailResponse;
import com.thanhmila.codelearning.dto.response.OjLessonProblemResponse;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.projection.OjProblemDetailProjection;
import com.thanhmila.codelearning.repository.projection.OjProblemListProjection;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.jpa.domain.Specification;
import com.thanhmila.codelearning.dto.request.ProblemSearchRequest;
import com.thanhmila.codelearning.repository.specification.ProblemSpecification;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.repository.oj.OnlineJudgeSubmissionRepository;
import java.util.Set;
import java.util.HashSet;
import org.springframework.transaction.annotation.Transactional;
import com.thanhmila.codelearning.repository.user.TeacherRepository;
import com.thanhmila.codelearning.dto.request.CreateOjProblemRequest;
import com.thanhmila.codelearning.entity.enums.ProblemScope;
import com.thanhmila.codelearning.mapper.OjProblemMapper;
import com.thanhmila.codelearning.repository.oj.ProblemTagRepository;
import com.thanhmila.codelearning.entity.oj.ProblemTagEntity;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OnlineJudgeProblemService {
    OnlineJudgeProblemRepository onlineJudgeProblemRepository;
    OnlineJudgeSubmissionRepository onlineJudgeSubmissionRepository;
    TeacherRepository teacherRepository;
    OjProblemMapper ojProblemMapper;
    ProblemTagRepository problemTagRepository;


    public PageResponse<OjPracticeProblemResponse> getPracticeProblems(ProblemSearchRequest request, Long userId) {
        Specification<OnlineJudgeProblemEntity> spec = Specification.allOf(
                ProblemSpecification.isPublicAndActive(),
                ProblemSpecification.hasScope(ProblemScope.PRACTICE)
        );

        if (StringUtils.hasText(request.getKeyword())) {
            spec = spec.and(ProblemSpecification.hasKeyword(request.getKeyword()));
        }
        if (request.getTagIds() != null && !request.getTagIds().isEmpty()) {
            spec = spec.and(ProblemSpecification.hasTags(request.getTagIds()));
        }
        if (request.getDifficulties() != null && !request.getDifficulties().isEmpty()) {
            spec = spec.and(ProblemSpecification.hasDifficulties(request.getDifficulties()));
        }
        if (request.getIsAccepted() != null && userId != null) {
            spec = spec.and(ProblemSpecification.hasUserAccepted(request.getIsAccepted(), userId));
        }

        Page<OnlineJudgeProblemEntity> problemPage = onlineJudgeProblemRepository.findAll(spec, request.getPageable());

        List<Long> problemIds = problemPage.getContent().stream()
                .map(OnlineJudgeProblemEntity::getId)
                .collect(Collectors.toList());

        Set<Long> acceptedProblemIds = new HashSet<>();
        if (userId != null && !problemIds.isEmpty()) {
            acceptedProblemIds = onlineJudgeSubmissionRepository.findProblemIdsByUserIdAndProblemIdsAndVerdict(
                    userId, problemIds, OjVerdict.ACCEPTED);
        }

        final Set<Long> finalAcceptedProblemIds = acceptedProblemIds;

        List<OjPracticeProblemResponse> content = problemPage.getContent().stream()
                .map(entity -> {
                    Double acceptanceRate = entity.getAcceptanceRate() != null ? entity.getAcceptanceRate() : 0.0;
                    acceptanceRate = BigDecimal.valueOf(acceptanceRate)
                            .setScale(2, RoundingMode.HALF_UP)
                            .doubleValue();

                    return OjPracticeProblemResponse.builder()
                            .id(entity.getId())
                            .title(entity.getTitle())
                            .difficulty(entity.getDifficulty())
                            .isAccepted(finalAcceptedProblemIds.contains(entity.getId()))
                            .totalSubmissions(entity.getTotalSubmissions())
                            .totalAccepted(entity.getTotalAccepted())
                            .acceptanceRate(acceptanceRate)
                            .build();
                })
                .collect(Collectors.toList());

        return PageResponse.<OjPracticeProblemResponse>builder()
                .page(problemPage.getNumber())
                .size(problemPage.getSize())
                .numberOfElements(problemPage.getNumberOfElements())
                .totalElements(problemPage.getTotalElements())
                .totalPages(problemPage.getTotalPages())
                .first(problemPage.isFirst())
                .last(problemPage.isLast())
                .content(content)
                .build();
    }

    public List<OjLessonProblemResponse> getLessonProblems(Long lessonId, Long userId) {
        List<OjProblemListProjection> ojProblemList = onlineJudgeProblemRepository.findProblemsByLessonWithStatus(lessonId, userId);
        return ojProblemList.stream()
                .map(this::mapToOnlineJudgeProblemResponse)
                .collect(Collectors.toList());
    }


    public OjProblemDetailResponse getProblemDetail(Long problemId, Long userId, Long contestId) {
        OjProblemDetailProjection ojProblemDetail = onlineJudgeProblemRepository.findProblemDetailWithStatus(problemId, userId, contestId)
                    .orElseThrow(() -> new AppException(ErrorCode.OJ_PROBLEM_NOT_FOUND));

        return mapToOnlineJudgeProblemDetailResponse(ojProblemDetail);       
    }

    private OjProblemDetailResponse mapToOnlineJudgeProblemDetailResponse(OjProblemDetailProjection ojProblem) {
        List<String> tags = ojProblem.getTagsRaw() != null
                ? Arrays.stream(ojProblem.getTagsRaw().split(",")).collect(Collectors.toList())
                : List.of();

        return OjProblemDetailResponse.builder()
                .id(ojProblem.getId())
                .title(ojProblem.getTitle())
                .description(ojProblem.getDescription())
                .inputDescription(ojProblem.getInputDescription())
                .outputDescription(ojProblem.getOutputDescription())
                .constraints(ojProblem.getConstraints())
                .exampleInput(ojProblem.getExampleInput())
                .exampleOutput(ojProblem.getExampleOutput())
                .hint(ojProblem.getHint())
                .tags(tags)
                .difficulty(ojProblem.getDifficulty() != null ? ProblemDifficulty.valueOf(ojProblem.getDifficulty()) : null)
                .latestSourceCode(ojProblem.getLatestSourceCode())
                .isAccepted(ojProblem.getIsAccepted())
                .build();
    }


    private OjLessonProblemResponse mapToOnlineJudgeProblemResponse(OjProblemListProjection ojProblem) {
        return OjLessonProblemResponse.builder()
                .id(ojProblem.getId())
                .title(ojProblem.getTitle())
                .difficulty(ProblemDifficulty.valueOf(ojProblem.getDifficulty()))
                .isAccepted(ojProblem.getIsAccepted())
                .build();
    }

    @Transactional
    public Long createProblemInBank(CreateOjProblemRequest request, Long userId) {
        if (request.getProblemScope() == ProblemScope.SHARED) {
            throw new AppException(ErrorCode.INVALID_REQUEST_BODY);
        }

        Long teacherId = teacherRepository.findIdByUserId(userId);
        if (teacherId == null) {
            throw new AppException(ErrorCode.USER_NOT_FOUND);
        }

        OnlineJudgeProblemEntity problem = ojProblemMapper.toEntity(request);
        problem.setCreatedByTeacher(teacherRepository.getReferenceById(teacherId));
        
        if (request.getTagIds() != null && !request.getTagIds().isEmpty()) {
            Set<ProblemTagEntity> tags = request.getTagIds().stream()
                    .map(problemTagRepository::getReferenceById)
                    .collect(Collectors.toSet());
            problem.setTags(tags);
        }

        onlineJudgeProblemRepository.save(problem);
        return problem.getId();
    }

    public PageResponse<OjAdminProblemResponse> getAdminProblems(int page, ProblemScope scope, Boolean isPublic, ProblemDifficulty difficulty) {
        Specification<OnlineJudgeProblemEntity> spec = (root, query, cb) -> cb.conjunction();

        if (scope != null) {
            spec = spec.and(ProblemSpecification.hasScope(scope));
        }
        if (isPublic != null) {
            spec = spec.and(ProblemSpecification.hasIsPublic(isPublic));
        }
        if (difficulty != null) {
            spec = spec.and(ProblemSpecification.hasDifficulty(difficulty));
        }

        Pageable pageable = PageRequest.of(page, 20, Sort.by("id").descending());
        Page<OnlineJudgeProblemEntity> problemPage = onlineJudgeProblemRepository.findAll(spec, pageable);

        List<OjAdminProblemResponse> content = problemPage.getContent().stream()
                .map(ojProblemMapper::toOjAdminProblemResponse)
                .collect(Collectors.toList());

        return PageResponse.<OjAdminProblemResponse>builder()
                .page(problemPage.getNumber())
                .size(problemPage.getSize())
                .numberOfElements(problemPage.getNumberOfElements())
                .totalElements(problemPage.getTotalElements())
                .totalPages(problemPage.getTotalPages())
                .first(problemPage.isFirst())
                .last(problemPage.isLast())
                .content(content)
                .build();
    }

    @Transactional
    public void updateProblemVisibility(Long problemId, Boolean isPublic) {
        OnlineJudgeProblemEntity problem = onlineJudgeProblemRepository.findById(problemId)
                .orElseThrow(() -> new AppException(ErrorCode.OJ_PROBLEM_NOT_FOUND));
        problem.setIsPublic(isPublic);
        onlineJudgeProblemRepository.save(problem);
    }
}
