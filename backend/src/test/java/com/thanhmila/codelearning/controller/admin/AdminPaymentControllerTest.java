package com.thanhmila.codelearning.controller.admin;

import com.thanhmila.codelearning.dto.response.AdminPaymentTransactionResponse;
import com.thanhmila.codelearning.dto.response.PageResponse;
import com.thanhmila.codelearning.entity.enums.PaymentTransactionType;
import com.thanhmila.codelearning.entity.enums.TransactionStatus;
import com.thanhmila.codelearning.security.UserRateLimitInterceptor;
import com.thanhmila.codelearning.service.admin.AdminPaymentService;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.data.domain.Pageable;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.math.BigDecimal;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(AdminPaymentController.class)
@AutoConfigureMockMvc(addFilters = false)
@ActiveProfiles("test")
@DisplayName("AdminPaymentController WebMvc Slice Tests")
class AdminPaymentControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private AdminPaymentService adminPaymentService;

    @MockitoBean
    private RateLimitService rateLimitService;

    @MockitoBean
    private UserRateLimitInterceptor userRateLimitInterceptor;

    @BeforeEach
    void setUp() throws Exception {
        when(userRateLimitInterceptor.preHandle(any(), any(), any())).thenReturn(true);
    }

    @Test
    @DisplayName("GET /admin/payment-transactions: Lấy danh sách giao dịch phân trang thành công")
    void getPaymentTransactions_Success_ReturnsHttp200() throws Exception {
        AdminPaymentTransactionResponse tx = AdminPaymentTransactionResponse.builder()
                .id(1L)
                .transactionCode("TX123456")
                .amount(new BigDecimal("100000"))
                .status(TransactionStatus.SUCCESS)
                .type(PaymentTransactionType.DEPOSIT)
                .build();

        PageResponse<AdminPaymentTransactionResponse> pageResponse = PageResponse.<AdminPaymentTransactionResponse>builder()
                .page(0)
                .size(20)
                .totalElements(1L)
                .totalPages(1)
                .content(List.of(tx))
                .build();

        when(adminPaymentService.getPaymentTransactionsForAdmin(
                eq(null), eq(null), eq(null), any(Pageable.class))).thenReturn(pageResponse);

        mockMvc.perform(get("/admin/payment-transactions")
                        .param("page", "0")
                        .param("size", "20")
                        .param("sortDir", "desc"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.content[0].transactionCode").value("TX123456"));
    }

    @Test
    @DisplayName("GET /admin/payment-transactions: Tìm kiếm với bộ lọc và sắp xếp asc thành công")
    void getPaymentTransactions_FilteredAndSortAsc_ReturnsHttp200() throws Exception {
        PageResponse<AdminPaymentTransactionResponse> pageResponse = PageResponse.<AdminPaymentTransactionResponse>builder()
                .page(0)
                .size(10)
                .totalElements(0L)
                .totalPages(0)
                .content(List.of())
                .build();

        when(adminPaymentService.getPaymentTransactionsForAdmin(
                eq("TX123"), eq(TransactionStatus.SUCCESS), eq(PaymentTransactionType.DEPOSIT), any(Pageable.class)))
                .thenReturn(pageResponse);

        mockMvc.perform(get("/admin/payment-transactions")
                        .param("keyword", "TX123")
                        .param("status", "SUCCESS")
                        .param("type", "DEPOSIT")
                        .param("sortDir", "asc"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000));
    }
}
