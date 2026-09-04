package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.OjAdminSubmissionResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeSubmissionEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mapstruct.factory.Mappers;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("OjSubmissionMapper Unit Tests")
class OjSubmissionMapperTest {

    private final OjSubmissionMapper submissionMapper = Mappers.getMapper(OjSubmissionMapper.class);

    @Test
    @DisplayName("getLanguageName: Phân giải đúng tên các ngôn ngữ lập trình")
    void getLanguageName_ResolvesCorrectly() {
        assertThat(submissionMapper.getLanguageName(null)).isEqualTo("Unknown");
        assertThat(submissionMapper.getLanguageName(48)).isEqualTo("C (GCC)");
        assertThat(submissionMapper.getLanguageName(52)).isEqualTo("C++ (GCC)");
        assertThat(submissionMapper.getLanguageName(75)).isEqualTo("C (Clang)");
        assertThat(submissionMapper.getLanguageName(76)).isEqualTo("C++ (Clang)");
        assertThat(submissionMapper.getLanguageName(60)).isEqualTo("Go");
        assertThat(submissionMapper.getLanguageName(62)).isEqualTo("Java");
        assertThat(submissionMapper.getLanguageName(51)).isEqualTo("C#");
        assertThat(submissionMapper.getLanguageName(63)).isEqualTo("JavaScript");
        assertThat(submissionMapper.getLanguageName(74)).isEqualTo("TypeScript");
        assertThat(submissionMapper.getLanguageName(71)).isEqualTo("Python");
        assertThat(submissionMapper.getLanguageName(999)).isEqualTo("Language (999)");
    }

    @Test
    @DisplayName("toOjAdminSubmissionResponse: Ánh xạ SubmissionEntity với tên user, bài toán và ngôn ngữ")
    void toOjAdminSubmissionResponse_MapsCorrectly() {
        UserEntity user = UserEntity.builder().id(1L).displayName("Thanh").build();
        OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder().id(10L).title("Fibonacci").build();

        OnlineJudgeSubmissionEntity submission = OnlineJudgeSubmissionEntity.builder()
                .id(100L)
                .user(user)
                .problem(problem)
                .languageId(62) // Java
                .build();

        OjAdminSubmissionResponse response = submissionMapper.toOjAdminSubmissionResponse(submission);

        assertThat(response).isNotNull();
        assertThat(response.getUserDisplayName()).isEqualTo("Thanh");
        assertThat(response.getProblemTitle()).isEqualTo("Fibonacci");
        assertThat(response.getLanguage()).isEqualTo("Java");
    }

    @Test
    @DisplayName("toPageResponse: Ánh xạ Spring Data Page sang PageResponse")
    void toPageResponse_MapsCorrectly() {
        UserEntity user = UserEntity.builder().displayName("User 1").build();
        OnlineJudgeProblemEntity problem = OnlineJudgeProblemEntity.builder().title("P1").build();
        OnlineJudgeSubmissionEntity submission = OnlineJudgeSubmissionEntity.builder()
                .id(1L)
                .user(user)
                .problem(problem)
                .languageId(71) // Python
                .build();

        Page<OnlineJudgeSubmissionEntity> page = new PageImpl<>(List.of(submission), PageRequest.of(0, 10), 1);

        PageResponse<OjAdminSubmissionResponse> pageResponse = submissionMapper.toPageResponse(page);

        assertThat(pageResponse).isNotNull();
        assertThat(pageResponse.getPage()).isEqualTo(0);
        assertThat(pageResponse.getSize()).isEqualTo(10);
        assertThat(pageResponse.getTotalElements()).isEqualTo(1);
        assertThat(pageResponse.getContent()).hasSize(1);
        assertThat(pageResponse.getContent().get(0).getLanguage()).isEqualTo("Python");

        assertThat(submissionMapper.toPageResponse(null)).isNull();
    }
}
