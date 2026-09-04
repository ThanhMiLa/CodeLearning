package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.request.CreateOjProblemRequest;
import com.thanhmila.codelearning.dto.response.OjAdminProblemResponse;
import com.thanhmila.codelearning.dto.response.TeacherResponse;
import com.thanhmila.codelearning.entity.enums.ProblemScope;
import com.thanhmila.codelearning.entity.oj.OnlineJudgeProblemEntity;
import com.thanhmila.codelearning.entity.user.TeacherEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mapstruct.factory.Mappers;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("OjProblemMapper Unit Tests")
class OjProblemMapperTest {

    private final OjProblemMapper ojProblemMapper = Mappers.getMapper(OjProblemMapper.class);

    @Test
    @DisplayName("toEntity: Ánh xạ CreateOjProblemRequest với các giá trị mặc định")
    void toEntity_SetsDefaults() {
        CreateOjProblemRequest request = CreateOjProblemRequest.builder()
                .title("Two Sum")
                .description("Find two numbers")
                .build();

        OnlineJudgeProblemEntity entity = ojProblemMapper.toEntity(request);

        assertThat(entity).isNotNull();
        assertThat(entity.getTitle()).isEqualTo("Two Sum");
        assertThat(entity.getIsActive()).isFalse();
        assertThat(entity.getIsPublic()).isFalse();
        assertThat(entity.getTotalTestCase()).isEqualTo(0);
        assertThat(entity.getTotalSubmissions()).isEqualTo(0);
        assertThat(entity.getTotalAccepted()).isEqualTo(0);
        assertThat(entity.getTimeLimitMs()).isEqualTo(2000);
        assertThat(entity.getMemoryLimitKb()).isEqualTo(262144);
        assertThat(entity.getScore()).isEqualByComparingTo("100.0");
    }

    @Test
    @DisplayName("toOjAdminProblemResponse: Ánh xạ problemScope sang scope")
    void toOjAdminProblemResponse_MapsCorrectly() {
        OnlineJudgeProblemEntity entity = OnlineJudgeProblemEntity.builder()
                .id(50L)
                .title("Binary Search")
                .problemScope(ProblemScope.PRACTICE)
                .build();

        OjAdminProblemResponse response = ojProblemMapper.toOjAdminProblemResponse(entity);

        assertThat(response).isNotNull();
        assertThat(response.getId()).isEqualTo(50L);
        assertThat(response.getTitle()).isEqualTo("Binary Search");
        assertThat(response.getScope()).isEqualTo(ProblemScope.PRACTICE);
    }

    @Test
    @DisplayName("toTeacherResponse: Ánh xạ TeacherEntity sang TeacherResponse")
    void toTeacherResponse_MapsCorrectly() {
        TeacherEntity teacher = TeacherEntity.builder().id(7L).fullName("Prof. Alan Turing").build();

        TeacherResponse response = ojProblemMapper.toTeacherResponse(teacher);

        assertThat(response).isNotNull();
        assertThat(response.getId()).isEqualTo(7L);
        assertThat(response.getFullName()).isEqualTo("Prof. Alan Turing");
    }
}
