package com.thanhmila.codelearning.controller.admin;

import com.thanhmila.codelearning.dto.response.AdminUserResponse;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.service.admin.AdminUserService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.util.List;
import com.thanhmila.codelearning.dto.response.EmailTargetUserResponse;

@Slf4j
@RestController
@RequestMapping("/admin/users")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AdminUserController {

    AdminUserService adminUserService;

    @GetMapping
    @PreAuthorize("hasAuthority('USER_ADMIN_VIEW')")
    public ResponseEntity<ApiResponse<PageResponse<AdminUserResponse>>> getUsers(
            @RequestParam(name = "page", defaultValue = "0") int page,
            @RequestParam(name = "size", defaultValue = "20") int size,
            @RequestParam(name = "keyword", required = false) String keyword,
            @RequestParam(name = "sortBy", defaultValue = "createdAt") String sortBy,
            @RequestParam(name = "sortDir", defaultValue = "desc") String sortDir
    ) {
        Sort sort = sortDir.equalsIgnoreCase("asc")
                ? Sort.by(sortBy).ascending()
                : Sort.by(sortBy).descending();

        Pageable pageable = PageRequest.of(page, size, sort);
        PageResponse<AdminUserResponse> result = adminUserService.getUsersForAdmin(keyword, pageable);

        return ResponseEntity.ok(ApiResponse.<PageResponse<AdminUserResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get admin users list successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @GetMapping("/online")
    @PreAuthorize("hasAuthority('USER_ADMIN_VIEW')")
    public ResponseEntity<ApiResponse<PageResponse<AdminUserResponse>>> getOnlineUsers(
            @RequestParam(name = "page", defaultValue = "0") int page,
            @RequestParam(name = "size", defaultValue = "20") int size,
            @RequestParam(name = "sortBy", defaultValue = "createdAt") String sortBy,
            @RequestParam(name = "sortDir", defaultValue = "desc") String sortDir
    ) {
        Sort sort = sortDir.equalsIgnoreCase("asc")
                ? Sort.by(sortBy).ascending()
                : Sort.by(sortBy).descending();

        Pageable pageable = PageRequest.of(page, size, sort);
        PageResponse<AdminUserResponse> result = adminUserService.getOnlineUsers(pageable);

        return ResponseEntity.ok(ApiResponse.<PageResponse<AdminUserResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get online users successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }

    @GetMapping("/email-targets")
    @PreAuthorize("hasAuthority('USER_ADMIN_VIEW')")
    public ResponseEntity<ApiResponse<List<EmailTargetUserResponse>>> getEmailTargets(
            @RequestParam(name = "keyword", required = false) String keyword,
            @RequestParam(name = "role", required = false) String role
    ) {
        List<EmailTargetUserResponse> result = adminUserService.getEmailTargets(keyword, role);

        return ResponseEntity.ok(ApiResponse.<List<EmailTargetUserResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get email targets successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }
}
