package com.thanhmila.codelearning.service.user;

import com.nimbusds.jwt.SignedJWT;
import com.thanhmila.codelearning.dto.request.UpdateProfileRequest;
import com.thanhmila.codelearning.dto.response.UserResponse;
import com.thanhmila.codelearning.entity.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.UserMapper;
import com.thanhmila.codelearning.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserService {
    UserRepository userRepository;
    UserMapper userMapper;

    @Transactional(readOnly = true)
    public UserResponse getMyInfo(String username){
        UserEntity userEntity = userRepository.findByUsername(username)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));
        return userMapper.toUserResponse(userEntity);
    }

    @Transactional
    public UserResponse updateProfile(String username, UpdateProfileRequest request){
        UserEntity userEntity = userRepository.findByUsername(username)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));

        userEntity.setDisplayName(request.getDisplayName() != null ? request.getDisplayName() : userEntity.getDisplayName());
        userEntity.setPhoneNumber(request.getPhoneNumber() != null ? request.getPhoneNumber() : userEntity.getPhoneNumber());

        userRepository.save(userEntity);

        return userMapper.toUserResponse(userEntity);

    }

}
