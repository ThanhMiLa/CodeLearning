package com.thanhmila.codelearning.service;

import com.thanhmila.codelearning.entity.UserEntity;
import com.thanhmila.codelearning.mapper.UserMapper;
import com.thanhmila.codelearning.repository.InvalidatedTokenRepository;
import com.thanhmila.codelearning.repository.RefreshTokenRepository;
import com.thanhmila.codelearning.repository.RoleRepository;
import com.thanhmila.codelearning.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.StringJoiner;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AuthenticationService {

    UserRepository userRepository;
    PasswordEncoder passwordEncoder;
    RoleRepository roleRepository;
    InvalidatedTokenRepository invalidatedTokenRepository;
    RefreshTokenRepository refreshTokenRepository;
    UserMapper userMapper;

    @NonFinal
    @Value("${jwt.signerKey}")
    String SIGNER_KEY;

    @NonFinal
    @Value("${jwt.valid-duration}")
    long VALID_DURATION;

    @NonFinal
    @Value("${jwt.refreshable-duration}")
    long REFRESHABLE_DURATION;

}
