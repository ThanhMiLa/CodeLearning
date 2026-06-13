package com.thanhmila.codelearning.configuration;

import com.thanhmila.codelearning.entity.auth.RoleEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.entity.enums.UserStatus;
import com.thanhmila.codelearning.repository.auth.RoleRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.Set;

@Slf4j
@Configuration
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Profile("dev")
public class ApplicationInitConfig {

    PasswordEncoder passwordEncoder;

    @Bean
    ApplicationRunner applicationRunner(
            UserRepository userRepository,
            RoleRepository roleRepository
    ) {
        log.info("Init application for dev environment...");

        return args -> {
            RoleEntity adminRole = roleRepository.findByName("ADMIN");
            if (adminRole == null) {
                adminRole = RoleEntity.builder()
                        .name("ADMIN")
                        .build();
                adminRole = roleRepository.save(adminRole);
                log.info("Created default ADMIN role.");
            }

            RoleEntity userRole = roleRepository.findByName("USER");
            if (userRole == null) {
                userRole = RoleEntity.builder()
                        .name("USER")
                        .build();
                roleRepository.save(userRole);
                log.info("Created default USER role.");
            }

            RoleEntity teacherRole = roleRepository.findByName("TEACHER");
            if (teacherRole == null) {
                teacherRole = RoleEntity.builder()
                        .name("TEACHER")
                        .build();
                roleRepository.save(teacherRole);
                log.info("Created default TEACHER role.");
            }

            if (userRepository.findByUsername("admin").isEmpty()) {
                UserEntity adminUser = UserEntity.builder()
                        .username("admin")
                        .passwordHash(passwordEncoder.encode("admin"))
                        .displayName("admin")
                        .email("admin@gmail.com")
                        .status(UserStatus.ACTIVE)
                        .phoneNumber("9999999999")
                        .roles(Set.of(adminRole))
                        .build();

                userRepository.save(adminUser);

                log.warn("Dev admin user has been created. Please change the default password if needed.");
            }
        };
    }
}
