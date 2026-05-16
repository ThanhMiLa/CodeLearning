package com.thanhmila.codelearning.service.auth;

import com.nimbusds.jose.*;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import com.thanhmila.codelearning.dto.request.AuthenticationRequest;
import com.thanhmila.codelearning.dto.request.IntrospectRequest;
import com.thanhmila.codelearning.dto.request.RegisterRequest;
import com.thanhmila.codelearning.dto.response.AuthenticationResponse;
import com.thanhmila.codelearning.dto.response.IntrospectResponse;
import com.thanhmila.codelearning.entity.auth.InvalidatedTokenEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.entity.enums.UserStatus;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.UserMapper;
import com.thanhmila.codelearning.repository.auth.InvalidatedTokenRepository;
import com.thanhmila.codelearning.repository.auth.RoleRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.text.ParseException;
import java.time.Instant;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@SuppressWarnings("all")
public class AuthenticationService {

    UserRepository userRepository;
    PasswordEncoder passwordEncoder;
    RoleRepository roleRepository;
    InvalidatedTokenRepository invalidatedTokenRepository;

    UserMapper userMapper;

    @NonFinal
    @Value("${jwt.signer-key}")
    String SIGNER_KEY;

    @NonFinal
    @Value("${jwt.valid-duration}")
    long VALID_DURATION;

    @NonFinal
    @Value("${jwt.refreshable-duration}")
    long REFRESHABLE_DURATION;

    @Transactional(readOnly = true)
    public AuthenticationResponse login(AuthenticationRequest request){
        UserEntity userEntity = userRepository.findByUsername(request.getUsername())
                .orElseThrow(() -> new AppException(ErrorCode.INVALID_USERNAME_OR_PASSWORD));

        boolean authenticated = passwordEncoder.matches(request.getPassword(), userEntity.getPasswordHash());

        if(!authenticated){
            throw new AppException(ErrorCode.INVALID_USERNAME_OR_PASSWORD);
        }

        if(userEntity.getStatus().equals(UserStatus.LOCKED)){
            throw new AppException(ErrorCode.ACCOUNT_LOCKED);
        }else if(userEntity.getStatus().equals(UserStatus.DISABLED)){
            throw new AppException(ErrorCode.ACCOUNT_DISABLED);
        }

        String accessToken = generateToken(userEntity, false);
        String refreshToken = generateToken(userEntity, true);

        AuthenticationResponse authenticationResponse = userMapper.toAuthenticationResponse(userEntity);
        authenticationResponse.setAccessToken(accessToken);
        authenticationResponse.setRefreshToken(refreshToken);

        return authenticationResponse;
    }

    @Transactional
    public AuthenticationResponse register(RegisterRequest registerRequest){
        if(userRepository.existsByUsername(registerRequest.getUsername())){
            throw new AppException(ErrorCode.USERNAME_ALREADY_EXISTS);
        }

        if(!Objects.equals(registerRequest.getPassword(), registerRequest.getConfirmPassword())){
            throw new AppException(ErrorCode.PASSWORD_NOT_MATCH);
        }

        if(userRepository.existsByEmail(registerRequest.getEmail())){
            throw new AppException(ErrorCode.EMAIL_ALREADY_EXISTS);
        }

        UserEntity userEntity = userMapper.toUserEntity(registerRequest);
        userEntity.setPasswordHash(passwordEncoder.encode(registerRequest.getPassword()));
        userEntity.setRoles(Set.of(roleRepository.findByName("USER")));

        userEntity = userRepository.save(userEntity);

        AuthenticationRequest authenticationRequest = AuthenticationRequest
                .builder()
                .username(registerRequest.getUsername())
                .password(registerRequest.getPassword())
                .build();

        return login(authenticationRequest);

    }

    @Transactional
    public void logout(String accessToken, String refreshToken){
        if(accessToken != null && !accessToken.isBlank()){
            processTokenInvalidation(accessToken, "ACCESS");
        }

        if(refreshToken != null && !refreshToken.isBlank()){
            processTokenInvalidation(refreshToken, "REFRESH");
        }
    }

    @Transactional
    public AuthenticationResponse refresh(String token) throws ParseException, JOSEException {
        SignedJWT signedJWT = verifyToken(token, true);

        String jti = signedJWT.getJWTClaimsSet().getJWTID();
        Date expiryTime = signedJWT.getJWTClaimsSet().getExpirationTime();

        OffsetDateTime expireOSDT = expiryTime.toInstant()
                .atOffset(ZoneOffset.UTC);

        InvalidatedTokenEntity invalidatedTokenEntity = InvalidatedTokenEntity
                .builder()
                .tokenJti(jti)
                .expiryTime(expireOSDT)
                .build();
        invalidatedTokenRepository.save(invalidatedTokenEntity);

        String username = signedJWT.getJWTClaimsSet().getSubject();
        UserEntity userEntity = userRepository.findByUsername(username)
                .orElseThrow(() -> new AppException(ErrorCode.INVALID_USERNAME_OR_PASSWORD));

        validateUserStatus(userEntity);
        String accessToken = generateToken(userEntity, false);
        String refreshToken = generateToken(userEntity, true);

        AuthenticationResponse authenticationResponse = userMapper.toAuthenticationResponse(userEntity);
        authenticationResponse.setAccessToken(accessToken);
        authenticationResponse.setRefreshToken(refreshToken);

        return authenticationResponse;

    }

    @Transactional(readOnly = true)
    public IntrospectResponse introspect(IntrospectRequest request)  {
        String token = request.getToken();
        boolean isValid = true;

        try{
            SignedJWT signedJWT = verifyToken(token, false);
        }catch (Exception exception){
            isValid = false;
        }

        return IntrospectResponse.builder().valid(isValid).build();
    }

    private SignedJWT verifyToken(String token, boolean isRefresh) throws JOSEException, ParseException {
        if(Objects.isNull(token) || token.isBlank()){
            throw new AppException(ErrorCode.UNAUTHENTICATED);
        }

        JWSVerifier jwsVerifier = new MACVerifier(SIGNER_KEY.getBytes());

        SignedJWT signedJWT = SignedJWT.parse(token);

        Date expiryTime = signedJWT.getJWTClaimsSet().getExpirationTime();
        boolean verified = signedJWT.verify(jwsVerifier);

        if(!verified) throw new AppException(ErrorCode.UNAUTHENTICATED);
        else if (expiryTime.before(new Date())) throw new AppException(ErrorCode.EXPIRED_TOKEN);

        if(invalidatedTokenRepository.existsByTokenJti(signedJWT.getJWTClaimsSet().getJWTID())){
            throw new AppException(ErrorCode.UNAUTHENTICATED);
        }

        String expectedType = isRefresh ? "REFRESH" : "ACCESS";
        Object type = signedJWT.getJWTClaimsSet().getClaim("type");
        if(Objects.isNull(type) || !expectedType.equals(type)){
            throw new AppException(ErrorCode.INVALID_TOKEN);
        }

        return signedJWT;

    }

    private void processTokenInvalidation(String token, String type){
        try{
            SignedJWT signedJWT = SignedJWT.parse(token);

            String jti = signedJWT.getJWTClaimsSet().getJWTID();
            Date expireDate = signedJWT.getJWTClaimsSet().getExpirationTime();

            OffsetDateTime expireOSDT = expireDate.toInstant()
                    .atOffset(ZoneOffset.UTC);

            InvalidatedTokenEntity invalidatedTokenEntity = InvalidatedTokenEntity
                    .builder()
                    .tokenJti(jti)
                    .expiryTime(expireOSDT)
                    .build();

            invalidatedTokenRepository.save(invalidatedTokenEntity);

        }catch (Exception e){
            log.warn("Invalid {} format, skipping blacklist: {}", type, e.getMessage());
        }
    }

    private String generateToken(UserEntity userEntity, boolean isRefresh) {
        JWSHeader header = new JWSHeader(JWSAlgorithm.HS512);

        JWTClaimsSet jwtClaimsSet = new JWTClaimsSet.Builder()
                .subject(userEntity.getUsername())
                .issuer("codelearning.thanhmila.com")
                .issueTime(new Date())
                .expirationTime(new Date(
                        Instant.now().plus(isRefresh ? REFRESHABLE_DURATION : VALID_DURATION, ChronoUnit.SECONDS).toEpochMilli()))
                .jwtID(UUID.randomUUID().toString())
                .claim("scope", buildScope(userEntity))
                .claim("type", isRefresh ? "REFRESH" : "ACCESS")
                .claim("userId", userEntity.getId())
                .build();

        Payload payload = new Payload(jwtClaimsSet.toJSONObject());

        JWSObject jwsObject = new JWSObject(header, payload);

        try {
            jwsObject.sign(new MACSigner(SIGNER_KEY.getBytes()));
            return jwsObject.serialize();
        } catch (JOSEException e) {
            log.error("Cannot create token!");
            throw new RuntimeException(e);
        }
    }

    private String buildScope(UserEntity userEntity) {
        StringJoiner stringJoiner = new StringJoiner(" ");
        if (!CollectionUtils.isEmpty(userEntity.getRoles())) {
            userEntity.getRoles().forEach(role -> {
                stringJoiner.add("ROLE_" + role.getName());
                if (!role.getPermissions().isEmpty()) {
                    role.getPermissions().forEach(permission -> stringJoiner.add(permission.getName()));
                }
            });
        }
        return stringJoiner.toString();
    }

    private void validateUserStatus(UserEntity userEntity) {
        if (userEntity.getStatus().equals(UserStatus.LOCKED)) {
            throw new AppException(ErrorCode.ACCOUNT_LOCKED);
        }

        if (userEntity.getStatus().equals(UserStatus.DISABLED)) {
            throw new AppException(ErrorCode.ACCOUNT_DISABLED);
        }
    }

}
