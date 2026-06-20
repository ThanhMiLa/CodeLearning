package com.thanhmila.codelearning.configuration;

import com.thanhmila.codelearning.entity.auth.RoleEntity;
import com.thanhmila.codelearning.entity.auth.PermissionEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.entity.user.TeacherEntity;
import com.thanhmila.codelearning.entity.enums.UserStatus;
import com.thanhmila.codelearning.entity.enums.TeacherStatus;
import com.thanhmila.codelearning.repository.auth.RoleRepository;
import com.thanhmila.codelearning.repository.auth.PermissionRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import com.thanhmila.codelearning.repository.user.TeacherRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;

@Slf4j
@Configuration
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Profile("dev")
public class ApplicationInitConfig implements ApplicationRunner {

    PasswordEncoder passwordEncoder;
    UserRepository userRepository;
    RoleRepository roleRepository;
    PermissionRepository permissionRepository;
    TeacherRepository teacherRepository;

    @Override
    @Transactional
    public void run(ApplicationArguments args) throws Exception {
        log.info("Init application for dev environment...");

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

        // Initialize OJ_PROBLEM_ADMIN permission
        PermissionEntity ojProblemAdminPermission = permissionRepository.findByName("OJ_PROBLEM_ADMIN")
                .orElseGet(() -> {
                    PermissionEntity perm = PermissionEntity.builder()
                            .name("OJ_PROBLEM_ADMIN")
                            .build();
                    perm = permissionRepository.save(perm);
                    log.info("Created OJ_PROBLEM_ADMIN permission.");
                    return perm;
                });

        // Assign permission to ADMIN role if not present
        if (adminRole.getPermissions() == null) {
            adminRole.setPermissions(new java.util.HashSet<>());
        }
        if (!adminRole.getPermissions().contains(ojProblemAdminPermission)) {
            adminRole.getPermissions().add(ojProblemAdminPermission);
            roleRepository.save(adminRole);
            log.info("Assigned OJ_PROBLEM_ADMIN permission to ADMIN role.");
        }

        UserEntity adminUserObj = null;
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

            adminUserObj = userRepository.save(adminUser);
            log.warn("Dev admin user has been created. Please change the default password if needed.");
        } else {
            adminUserObj = userRepository.findByUsername("admin").get();
        }

        // Initialize teacher record for admin user if not present
        if (adminUserObj != null && teacherRepository.findIdByUserId(adminUserObj.getId()) == null) {
            TeacherEntity adminTeacher = TeacherEntity.builder()
                    .user(adminUserObj)
                    .status(TeacherStatus.ACTIVE)
                    .fullName("Admin Teacher")
                    .build();
            teacherRepository.save(adminTeacher);
            log.info("Created teacher profile for admin user.");
        }
    }
}
