package com.thanhmila.codelearning.controller.course;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thanhmila.codelearning.dto.request.ChapterCreationRequest;
import com.thanhmila.codelearning.dto.request.ChapterReorderRequest;
import com.thanhmila.codelearning.dto.request.ChapterUpdateRequest;
import com.thanhmila.codelearning.dto.response.ChapterResponse;
import com.thanhmila.codelearning.security.UserRateLimitInterceptor;
import com.thanhmila.codelearning.service.auth.RateLimitService;
import com.thanhmila.codelearning.service.course.ChapterService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(ChapterController.class)
@AutoConfigureMockMvc(addFilters = false)
@ActiveProfiles("test")
@DisplayName("ChapterController WebMvc Slice Tests")
class ChapterControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockitoBean
    private ChapterService chapterService;

    @MockitoBean
    private RateLimitService rateLimitService;

    @MockitoBean
    private UserRateLimitInterceptor userRateLimitInterceptor;

    @BeforeEach
    void setUp() throws Exception {
        when(userRateLimitInterceptor.preHandle(any(), any(), any())).thenReturn(true);
    }

    @Test
    @DisplayName("POST /courses/{courseId}/chapters: Tạo chương mới thành công")
    void createChapter_Success_ReturnsHttp200() throws Exception {
        ChapterCreationRequest request = ChapterCreationRequest.builder()
                .title("Chương 1: Giới thiệu")
                .build();

        ChapterResponse response = ChapterResponse.builder()
                .id(1L)
                .title("Chương 1: Giới thiệu")
                .orderIndex(1)
                .build();

        when(chapterService.createChapter(eq(10L), any(ChapterCreationRequest.class))).thenReturn(response);

        mockMvc.perform(post("/courses/{courseId}/chapters", 10L)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.id").value(1))
                .andExpect(jsonPath("$.result.title").value("Chương 1: Giới thiệu"));
    }

    @Test
    @DisplayName("PUT /chapters/{chapterId}: Cập nhật tiêu đề chương thành công")
    void updateChapterTitle_Success_ReturnsHttp200() throws Exception {
        ChapterUpdateRequest request = ChapterUpdateRequest.builder()
                .title("Chương 1: Cập nhật mới")
                .build();

        ChapterResponse response = ChapterResponse.builder()
                .id(1L)
                .title("Chương 1: Cập nhật mới")
                .build();

        when(chapterService.updateChapterTitle(eq(1L), any(ChapterUpdateRequest.class))).thenReturn(response);

        mockMvc.perform(put("/chapters/{chapterId}", 1L)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.result.title").value("Chương 1: Cập nhật mới"));
    }

    @Test
    @DisplayName("DELETE /chapters/{chapterId}: Xóa chương thành công")
    void deleteChapter_Success_ReturnsHttp200() throws Exception {
        mockMvc.perform(delete("/chapters/{chapterId}", 1L))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Delete chapter successfully"));

        verify(chapterService).deleteChapter(1L);
    }

    @Test
    @DisplayName("PUT /courses/{courseId}/chapters/reorder: Sắp xếp thứ tự các chương thành công")
    void reorderChapters_Success_ReturnsHttp200() throws Exception {
        List<ChapterReorderRequest> requests = List.of(
                ChapterReorderRequest.builder().id(1L).orderIndex(2).build(),
                ChapterReorderRequest.builder().id(2L).orderIndex(1).build()
        );

        mockMvc.perform(put("/courses/{courseId}/chapters/reorder", 10L)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(requests)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.code").value(1000))
                .andExpect(jsonPath("$.message").value("Reorder chapters successfully"));

        verify(chapterService).reorderChapters(eq(10L), any());
    }
}
