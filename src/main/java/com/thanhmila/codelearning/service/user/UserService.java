package com.thanhmila.codelearning.service.user;

import com.thanhmila.codelearning.dto.request.ChangePasswordRequest;
import com.thanhmila.codelearning.dto.request.UpdateProfileRequest;
import com.thanhmila.codelearning.dto.response.UserResponse;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.UserMapper;
import com.thanhmila.codelearning.repository.user.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.OffsetDateTime;
import java.util.Objects;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserService {
    UserRepository userRepository;
    UserMapper userMapper;
    PasswordEncoder passwordEncoder;

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
        userEntity.setUpdatedAt(OffsetDateTime.now());
        userRepository.save(userEntity);

        return userMapper.toUserResponse(userEntity);

    }

    @Transactional
    public void changePassword(String username, ChangePasswordRequest changePasswordRequest){
        UserEntity userEntity = userRepository.findByUsername(username)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));

        userEntity.validateStatus();

        if(!passwordEncoder.matches(changePasswordRequest.getOldPassword(), userEntity.getPasswordHash())){
            throw new AppException(ErrorCode.OLD_PASSWORD_NOT_MATCH);
        }

        if(!Objects.equals(changePasswordRequest.getNewPassword(), changePasswordRequest.getConfirmNewPassword())){
            throw new AppException(ErrorCode.PASSWORD_NOT_MATCH);
        }

        if (passwordEncoder.matches(changePasswordRequest.getNewPassword(), userEntity.getPasswordHash())) {
            throw new AppException(ErrorCode.NEW_PASSWORD_SAME_AS_OLD_PASSWORD);
        }

        userEntity.setPasswordHash(passwordEncoder.encode(changePasswordRequest.getNewPassword()));
        userEntity.setUpdatedAt(OffsetDateTime.now());
        userRepository.save(userEntity);

    }    

    

}
