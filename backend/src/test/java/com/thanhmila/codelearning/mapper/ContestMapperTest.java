package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.ContestResponse;
import com.thanhmila.codelearning.entity.contest.ContestEntity;
import com.thanhmila.codelearning.entity.user.TeacherEntity;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mapstruct.factory.Mappers;

import static org.assertj.core.api.Assertions.assertThat;

@DisplayName("ContestMapper Unit Tests")
class ContestMapperTest {

    private final ContestMapper contestMapper = Mappers.getMapper(ContestMapper.class);

    @Test
    @DisplayName("toContestResponse: Có mật khẩu thì isProtected = true")
    void toContestResponse_WithPasswordHash_IsProtectedTrue() {
        TeacherEntity teacher = TeacherEntity.builder().id(1L).fullName("Teacher Alice").build();
        ContestEntity contest = ContestEntity.builder()
                .id(10L)
                .title("Weekly Contest 1")
                .passwordHash("hashed_secret")
                .createdByTeacher(teacher)
                .build();

        ContestResponse response = contestMapper.toContestResponse(contest);

        assertThat(response).isNotNull();
        assertThat(response.getId()).isEqualTo(10L);
        assertThat(response.getTitle()).isEqualTo("Weekly Contest 1");
        assertThat(response.isProtected()).isTrue();
        assertThat(response.getTeacherName()).isEqualTo("Teacher Alice");
    }

    @Test
    @DisplayName("toContestResponse: Không có mật khẩu thì isProtected = false")
    void toContestResponse_WithoutPasswordHash_IsProtectedFalse() {
        ContestEntity contest = ContestEntity.builder()
                .id(11L)
                .title("Open Contest")
                .passwordHash(null)
                .build();

        ContestResponse response = contestMapper.toContestResponse(contest);

        assertThat(response).isNotNull();
        assertThat(response.isProtected()).isFalse();
        assertThat(response.getTeacherName()).isNull();
    }
}
