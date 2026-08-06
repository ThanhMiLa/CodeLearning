package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.OjAdminSubmissionResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeSubmissionEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.springframework.data.domain.Page;

@Mapper(componentModel = "spring")
public interface OjSubmissionMapper {

    @Mapping(source = "user.displayName", target = "userDisplayName")
    @Mapping(source = "problem.title", target = "problemTitle")
    @Mapping(target = "language", expression = "java(getLanguageName(entity.getLanguageId()))")
    OjAdminSubmissionResponse toOjAdminSubmissionResponse(OnlineJudgeSubmissionEntity entity);

    default String getLanguageName(Integer languageId) {
        if (languageId == null) return "Unknown";
        return switch (languageId) {
            case 48, 49, 50 -> "C (GCC)";
            case 52, 53, 54 -> "C++ (GCC)";
            case 75 -> "C (Clang)";
            case 76 -> "C++ (Clang)";
            case 60 -> "Go";
            case 62 -> "Java";
            case 51 -> "C#";
            case 63 -> "JavaScript";
            case 74 -> "TypeScript";
            case 70, 71 -> "Python";
            default -> "Language (" + languageId + ")";
        };
    }

    default PageResponse<OjAdminSubmissionResponse> toPageResponse(Page<OnlineJudgeSubmissionEntity> page) {
        if (page == null) {
            return null;
        }
        return PageResponse.<OjAdminSubmissionResponse>builder()
                .page(page.getNumber())
                .size(page.getSize())
                .numberOfElements(page.getNumberOfElements())
                .totalElements(page.getTotalElements())
                .totalPages(page.getTotalPages())
                .first(page.isFirst())
                .last(page.isLast())
                .content(page.getContent().stream().map(this::toOjAdminSubmissionResponse).toList())
                .build();
    }
}
