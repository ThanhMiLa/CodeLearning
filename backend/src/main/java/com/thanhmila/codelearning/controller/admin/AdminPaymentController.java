package com.thanhmila.codelearning.controller.admin;

import com.thanhmila.codelearning.dto.response.AdminPaymentTransactionResponse;
import com.thanhmila.codelearning.dto.response.ApiResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.enums.PaymentTransactionType;
import com.thanhmila.codelearning.entity.enums.TransactionStatus;
import com.thanhmila.codelearning.service.admin.AdminPaymentService;
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

@Slf4j
@RestController
@RequestMapping("/admin/payment-transactions")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AdminPaymentController {

    AdminPaymentService adminPaymentService;

    @GetMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<PageResponse<AdminPaymentTransactionResponse>>> getPaymentTransactions(
            @RequestParam(name = "page", defaultValue = "0") int page,
            @RequestParam(name = "size", defaultValue = "20") int size,
            @RequestParam(name = "keyword", required = false) String keyword,
            @RequestParam(name = "status", required = false) TransactionStatus status,
            @RequestParam(name = "type", required = false) PaymentTransactionType type,
            @RequestParam(name = "sortBy", defaultValue = "createdAt") String sortBy,
            @RequestParam(name = "sortDir", defaultValue = "desc") String sortDir
    ) {
        Sort sort = sortDir.equalsIgnoreCase("asc")
                ? Sort.by(sortBy).ascending()
                : Sort.by(sortBy).descending();

        Pageable pageable = PageRequest.of(page, size, sort);
        PageResponse<AdminPaymentTransactionResponse> result = adminPaymentService.getPaymentTransactionsForAdmin(
                keyword, status, type, pageable);

        return ResponseEntity.ok(ApiResponse.<PageResponse<AdminPaymentTransactionResponse>>builder()
                .status(200)
                .code(1000)
                .message("Get admin payment transactions list successfully")
                .result(result)
                .timestamp(Instant.now().toString())
                .build());
    }
}
