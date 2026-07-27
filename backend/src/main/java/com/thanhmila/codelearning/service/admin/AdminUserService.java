package com.thanhmila.codelearning.service.admin;

import com.thanhmila.codelearning.dto.response.AdminUserResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import org.springframework.data.domain.Pageable;

public interface AdminUserService {
    PageResponse<AdminUserResponse> getUsersForAdmin(String keyword, Pageable pageable);
}
