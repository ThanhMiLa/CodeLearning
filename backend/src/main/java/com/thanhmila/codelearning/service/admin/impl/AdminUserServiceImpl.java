package com.thanhmila.codelearning.service.admin.impl;

import com.thanhmila.codelearning.dto.response.AdminUserResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.mapper.UserMapper;
import com.thanhmila.codelearning.repository.user.UserRepository;
import com.thanhmila.codelearning.service.admin.AdminUserService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AdminUserServiceImpl implements AdminUserService {

    UserRepository userRepository;
    UserMapper userMapper;
    RedisTemplate<String, Object> redisTemplate;
    
    static  String ONLINE_USERS_KEY = "active_users";

    @Override
    @Transactional(readOnly = true)
    public PageResponse<AdminUserResponse> getUsersForAdmin(String keyword, Pageable pageable) {
        Page<UserEntity> userPage;
        if (keyword != null && !keyword.trim().isEmpty()) {
            userPage = userRepository.searchForAdmin(keyword.trim(), pageable);
        } else {
            userPage = userRepository.findAllForAdmin(pageable);
        }

        Page<AdminUserResponse> responsePage = userPage.map(userMapper::toAdminUserResponse);

        return PageResponse.from(responsePage);
    }

    @Override
    @Transactional(readOnly = true)
    public PageResponse<AdminUserResponse> getOnlineUsers(Pageable pageable) {
        Set<Object> onlineUserIdsObj = redisTemplate.opsForHash().keys(ONLINE_USERS_KEY);
        
        if (onlineUserIdsObj == null || onlineUserIdsObj.isEmpty()) {
            return PageResponse.from(Page.empty(pageable));
        }

        List<Long> onlineUserIds = onlineUserIdsObj.stream()
                .map(this::parseUserIdSafely)
                .filter(java.util.Objects::nonNull)
                .collect(Collectors.toList());

        if (onlineUserIds.isEmpty()) {
            return PageResponse.from(Page.empty(pageable));
        }

        Page<UserEntity> userPage = userRepository.findOnlineUsersForAdmin(onlineUserIds, pageable);
        
        Page<AdminUserResponse> responsePage = userPage.map(userMapper::toAdminUserResponse);
        
        return PageResponse.from(responsePage);
    }

    private Long parseUserIdSafely(Object idObj) {
        try {
            return Long.valueOf(idObj.toString());
        } catch (NumberFormatException e) {
            return null; // Bỏ qua các key cũ bị lưu sai định dạng
        }
    }
}
