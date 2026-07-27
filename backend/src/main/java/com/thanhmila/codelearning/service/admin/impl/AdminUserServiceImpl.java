package com.thanhmila.codelearning.service.admin.impl;

import com.thanhmila.codelearning.dto.response.AdminUserResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.auth.RoleEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.repository.user.UserRepository;
import com.thanhmila.codelearning.service.admin.AdminUserService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AdminUserServiceImpl implements AdminUserService {

    UserRepository userRepository;

    @Override
    @Transactional(readOnly = true)
    public PageResponse<AdminUserResponse> getUsersForAdmin(String keyword, Pageable pageable) {
        Page<UserEntity> userPage;
        if (keyword != null && !keyword.trim().isEmpty()) {
            userPage = userRepository.searchForAdmin(keyword.trim(), pageable);
        } else {
            userPage = userRepository.findAllForAdmin(pageable);
        }

        Page<AdminUserResponse> responsePage = userPage.map(user -> {
            BigDecimal walletBalance = (user.getWallet() != null && user.getWallet().getBalance() != null)
                    ? user.getWallet().getBalance()
                    : BigDecimal.ZERO;

            return AdminUserResponse.builder()
                    .id(user.getId())
                    .displayName(user.getDisplayName())
                    .username(user.getUsername())
                    .email(user.getEmail())
                    .phoneNumber(user.getPhoneNumber())
                    .balance(walletBalance)
                    .status(user.getStatus() != null ? user.getStatus().name() : null)
                    .roles(user.getRoles() != null
                            ? user.getRoles().stream().map(RoleEntity::getName).collect(Collectors.toSet())
                            : Collections.emptySet())
                    .createdAt(user.getCreatedAt())
                    .build();
        });

        return PageResponse.from(responsePage);
    }
}
