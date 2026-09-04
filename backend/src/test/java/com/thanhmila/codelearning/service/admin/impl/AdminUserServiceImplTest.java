package com.thanhmila.codelearning.service.admin.impl;

import com.thanhmila.codelearning.dto.response.AdminUserResponse;
import com.thanhmila.codelearning.dto.response.EmailTargetUserResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.auth.RoleEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.mapper.UserMapper;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;

import java.util.Collections;
import java.util.List;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("AdminUserServiceImpl Unit Tests")
class AdminUserServiceImplTest {

    @Mock UserRepository userRepository;
    @Mock UserMapper userMapper;
    @Mock RedisTemplate<String, Object> redisTemplate;
    @Mock HashOperations<String, Object, Object> hashOperations;

    @InjectMocks AdminUserServiceImpl adminUserService;

    @Nested
    @DisplayName("getUsersForAdmin Tests")
    class GetUsersForAdminTests {

        @Test
        @DisplayName("Search with keyword calls searchForAdmin")
        void shouldSearchWithKeyword_WhenKeywordProvided() {
            Pageable pageable = PageRequest.of(0, 10);
            UserEntity user = UserEntity.builder().id(1L).username("test").build();
            Page<UserEntity> userPage = new PageImpl<>(List.of(user));

            when(userRepository.searchForAdmin("alice", pageable)).thenReturn(userPage);
            when(userMapper.toAdminUserResponse(user)).thenReturn(AdminUserResponse.builder().id(1L).build());

            PageResponse<AdminUserResponse> result = adminUserService.getUsersForAdmin("alice", pageable);

            assertThat(result).isNotNull();
            assertThat(result.getContent()).hasSize(1);
            verify(userRepository).searchForAdmin("alice", pageable);
        }

        @Test
        @DisplayName("Search with empty keyword calls findAllForAdmin")
        void shouldFindAll_WhenKeywordEmptyOrNull() {
            Pageable pageable = PageRequest.of(0, 10);
            Page<UserEntity> userPage = Page.empty(pageable);

            when(userRepository.findAllForAdmin(pageable)).thenReturn(userPage);

            PageResponse<AdminUserResponse> result = adminUserService.getUsersForAdmin("", pageable);

            assertThat(result).isNotNull();
            verify(userRepository).findAllForAdmin(pageable);
        }
    }

    @Nested
    @DisplayName("getOnlineUsers Tests")
    class GetOnlineUsersTests {

        @Test
        @DisplayName("Returns empty page when Redis online users is empty")
        void shouldReturnEmptyPage_WhenRedisKeysEmpty() {
            Pageable pageable = PageRequest.of(0, 10);
            when(redisTemplate.opsForHash()).thenReturn(hashOperations);
            when(hashOperations.keys("active_users")).thenReturn(Collections.emptySet());

            PageResponse<AdminUserResponse> result = adminUserService.getOnlineUsers(pageable);

            assertThat(result.getContent()).isEmpty();
        }

        @Test
        @DisplayName("Returns empty page when online user IDs are malformed")
        void shouldReturnEmptyPage_WhenKeysCannotBeParsed() {
            Pageable pageable = PageRequest.of(0, 10);
            when(redisTemplate.opsForHash()).thenReturn(hashOperations);
            when(hashOperations.keys("active_users")).thenReturn(Set.of("not-a-number"));

            PageResponse<AdminUserResponse> result = adminUserService.getOnlineUsers(pageable);

            assertThat(result.getContent()).isEmpty();
        }

        @Test
        @DisplayName("Returns online users when valid IDs exist")
        void shouldReturnUsers_WhenValidOnlineIds() {
            Pageable pageable = PageRequest.of(0, 10);
            UserEntity user = UserEntity.builder().id(100L).build();
            Page<UserEntity> userPage = new PageImpl<>(List.of(user));

            when(redisTemplate.opsForHash()).thenReturn(hashOperations);
            when(hashOperations.keys("active_users")).thenReturn(Set.of("100"));
            when(userRepository.findOnlineUsersForAdmin(List.of(100L), pageable)).thenReturn(userPage);
            when(userMapper.toAdminUserResponse(user)).thenReturn(AdminUserResponse.builder().id(100L).build());

            PageResponse<AdminUserResponse> result = adminUserService.getOnlineUsers(pageable);

            assertThat(result.getContent()).hasSize(1);
        }
    }

    @Nested
    @DisplayName("getEmailTargets Tests")
    class GetEmailTargetsTests {

        @Test
        @DisplayName("Maps users to EmailTargetUserResponse correctly with displayName fallback")
        void shouldMapEmailTargetsCorrectly() {
            UserEntity userWithDisplay = UserEntity.builder()
                    .id(1L)
                    .username("u1")
                    .displayName("Alice")
                    .email("alice@mail.com")
                    .phoneNumber("123")
                    .roles(Set.of(RoleEntity.builder().name("TEACHER").build()))
                    .build();

            UserEntity userNoDisplay = UserEntity.builder()
                    .id(2L)
                    .username("u2")
                    .displayName(null)
                    .email("u2@mail.com")
                    .roles(Collections.emptySet())
                    .build();

            when(userRepository.searchEmailTargets("test", "ALL")).thenReturn(List.of(userWithDisplay, userNoDisplay));

            List<EmailTargetUserResponse> responses = adminUserService.getEmailTargets("test", "ALL");

            assertThat(responses).hasSize(2);
            assertThat(responses.get(0).getDisplayName()).isEqualTo("Alice");
            assertThat(responses.get(0).getRole()).isEqualTo("TEACHER");

            assertThat(responses.get(1).getDisplayName()).isEqualTo("u2");
            assertThat(responses.get(1).getRole()).isEqualTo("USER");
        }
    }
}
