package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.request.LessonCommentRequest;
import com.thanhmila.codelearning.dto.response.LessonCommentResponse;
import com.thanhmila.codelearning.entity.lesson.LessonCommentEntity;
import com.thanhmila.codelearning.entity.lesson.LessonEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.lesson.LessonCommentRepository;
import com.thanhmila.codelearning.repository.lesson.LessonRepository;
import com.thanhmila.codelearning.repository.projection.RootLessonCommentProjection;
import com.thanhmila.codelearning.repository.user.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import java.time.Instant;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@DisplayName("LessonCommentService Unit Tests")
class LessonCommentServiceTest {

    @Mock
    private LessonCommentRepository lessonCommentRepository;

    @Mock
    private LessonRepository lessonRepository;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private LessonCommentService lessonCommentService;

    @Test
    @DisplayName("getRootComments: Lấy danh sách bình luận gốc có reply count thành công")
    void getRootComments_ReturnsPage() {
        Pageable pageable = PageRequest.of(0, 10);
        RootLessonCommentProjection projection = mock(RootLessonCommentProjection.class);
        when(projection.getId()).thenReturn(100L);
        when(projection.getUserId()).thenReturn(1L);
        when(projection.getDisplayName()).thenReturn("John Doe");
        when(projection.getContent()).thenReturn("Great lesson!");
        when(projection.getCreatedAt()).thenReturn(Instant.now());
        when(projection.getUpdatedAt()).thenReturn(Instant.now());
        when(projection.getReplyCount()).thenReturn(3L);

        when(lessonCommentRepository.findRootCommentsWithReplyCount(10L, pageable))
                .thenReturn(new PageImpl<>(List.of(projection), pageable, 1));

        Page<LessonCommentResponse> result = lessonCommentService.getRootComments(10L, pageable);

        assertThat(result).hasSize(1);
        assertThat(result.getContent().get(0).getContent()).isEqualTo("Great lesson!");
        assertThat(result.getContent().get(0).getReplyCount()).isEqualTo(3L);
    }

    @Test
    @DisplayName("getReplies: Lấy danh sách câu trả lời của bình luận thành công")
    void getReplies_ReturnsPage() {
        Pageable pageable = PageRequest.of(0, 10);
        UserEntity user = UserEntity.builder().id(2L).displayName("Jane").build();
        LessonCommentEntity reply = LessonCommentEntity.builder()
                .id(200L)
                .user(user)
                .content("I agree")
                .createdAt(OffsetDateTime.now())
                .updatedAt(OffsetDateTime.now())
                .build();

        when(lessonCommentRepository.findByParentCommentId(100L, pageable))
                .thenReturn(new PageImpl<>(List.of(reply), pageable, 1));

        Page<LessonCommentResponse> result = lessonCommentService.getReplies(100L, pageable);

        assertThat(result).hasSize(1);
        assertThat(result.getContent().get(0).getContent()).isEqualTo("I agree");
        assertThat(result.getContent().get(0).getDisplayName()).isEqualTo("Jane");
    }

    @Test
    @DisplayName("createComment: Lesson không tồn tại ném AppException(LESSON_NOT_FOUND)")
    void createComment_LessonNotFound_ThrowsException() {
        when(lessonRepository.findById(10L)).thenReturn(Optional.empty());

        LessonCommentRequest request = new LessonCommentRequest();
        request.setContent("Hello");

        assertThatThrownBy(() -> lessonCommentService.createComment(10L, 1L, request))
                .isInstanceOf(AppException.class)
                .matches(e -> ((AppException) e).getErrorCode() == ErrorCode.LESSON_NOT_FOUND);
    }

    @Test
    @DisplayName("createComment: User không tồn tại ném AppException(USER_NOT_FOUND)")
    void createComment_UserNotFound_ThrowsException() {
        LessonEntity lesson = LessonEntity.builder().id(10L).build();
        when(lessonRepository.findById(10L)).thenReturn(Optional.of(lesson));
        when(userRepository.findById(1L)).thenReturn(Optional.empty());

        LessonCommentRequest request = new LessonCommentRequest();
        request.setContent("Hello");

        assertThatThrownBy(() -> lessonCommentService.createComment(10L, 1L, request))
                .isInstanceOf(AppException.class)
                .matches(e -> ((AppException) e).getErrorCode() == ErrorCode.USER_NOT_FOUND);
    }

    @Test
    @DisplayName("createComment: Tạo bình luận gốc thành công")
    void createComment_RootComment_Success() {
        LessonEntity lesson = LessonEntity.builder().id(10L).build();
        UserEntity user = UserEntity.builder().id(1L).displayName("John").build();

        when(lessonRepository.findById(10L)).thenReturn(Optional.of(lesson));
        when(userRepository.findById(1L)).thenReturn(Optional.of(user));

        LessonCommentEntity saved = LessonCommentEntity.builder()
                .id(100L)
                .lesson(lesson)
                .user(user)
                .content("Root comment")
                .createdAt(OffsetDateTime.now())
                .updatedAt(OffsetDateTime.now())
                .build();

        when(lessonCommentRepository.save(any(LessonCommentEntity.class))).thenReturn(saved);

        LessonCommentRequest request = new LessonCommentRequest();
        request.setContent("Root comment");

        LessonCommentResponse response = lessonCommentService.createComment(10L, 1L, request);

        assertThat(response.getId()).isEqualTo(100L);
        assertThat(response.getContent()).isEqualTo("Root comment");
        assertThat(response.getParentCommentId()).isNull();
    }

    @Test
    @DisplayName("createComment: Parent comment không tìm thấy ném AppException(COMMENT_NOT_FOUND)")
    void createComment_ParentNotFound_ThrowsException() {
        LessonEntity lesson = LessonEntity.builder().id(10L).build();
        UserEntity user = UserEntity.builder().id(1L).displayName("John").build();

        when(lessonRepository.findById(10L)).thenReturn(Optional.of(lesson));
        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(lessonCommentRepository.findById(999L)).thenReturn(Optional.empty());

        LessonCommentRequest request = new LessonCommentRequest();
        request.setContent("Reply");
        request.setParentCommentId(999L);

        assertThatThrownBy(() -> lessonCommentService.createComment(10L, 1L, request))
                .isInstanceOf(AppException.class)
                .matches(e -> ((AppException) e).getErrorCode() == ErrorCode.COMMENT_NOT_FOUND);
    }

    @Test
    @DisplayName("createComment: Parent comment thuộc bài học khác ném AppException(INVALID_COMMENT_LESSON)")
    void createComment_ParentDifferentLesson_ThrowsException() {
        LessonEntity lesson = LessonEntity.builder().id(10L).build();
        LessonEntity otherLesson = LessonEntity.builder().id(20L).build();
        UserEntity user = UserEntity.builder().id(1L).displayName("John").build();
        LessonCommentEntity targetComment = LessonCommentEntity.builder().id(100L).lesson(otherLesson).build();

        when(lessonRepository.findById(10L)).thenReturn(Optional.of(lesson));
        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(lessonCommentRepository.findById(100L)).thenReturn(Optional.of(targetComment));

        LessonCommentRequest request = new LessonCommentRequest();
        request.setContent("Reply");
        request.setParentCommentId(100L);

        assertThatThrownBy(() -> lessonCommentService.createComment(10L, 1L, request))
                .isInstanceOf(AppException.class)
                .matches(e -> ((AppException) e).getErrorCode() == ErrorCode.INVALID_COMMENT_LESSON);
    }

    @Test
    @DisplayName("createComment: Reply vào sub-comment sẽ làm phẳng (flatten) về root comment")
    void createComment_ReplyToSubComment_FlattensToRootComment() {
        LessonEntity lesson = LessonEntity.builder().id(10L).build();
        UserEntity user = UserEntity.builder().id(1L).displayName("John").build();

        LessonCommentEntity rootComment = LessonCommentEntity.builder().id(50L).lesson(lesson).build();
        LessonCommentEntity subComment = LessonCommentEntity.builder().id(51L).lesson(lesson).parentComment(rootComment).build();

        when(lessonRepository.findById(10L)).thenReturn(Optional.of(lesson));
        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(lessonCommentRepository.findById(51L)).thenReturn(Optional.of(subComment));

        LessonCommentEntity saved = LessonCommentEntity.builder()
                .id(52L)
                .lesson(lesson)
                .user(user)
                .content("Reply to reply")
                .parentComment(rootComment)
                .createdAt(OffsetDateTime.now())
                .updatedAt(OffsetDateTime.now())
                .build();

        when(lessonCommentRepository.save(any(LessonCommentEntity.class))).thenReturn(saved);

        LessonCommentRequest request = new LessonCommentRequest();
        request.setContent("Reply to reply");
        request.setParentCommentId(51L);

        LessonCommentResponse response = lessonCommentService.createComment(10L, 1L, request);

        ArgumentCaptor<LessonCommentEntity> captor = ArgumentCaptor.forClass(LessonCommentEntity.class);
        verify(lessonCommentRepository).save(captor.capture());

        assertThat(captor.getValue().getParentComment().getId()).isEqualTo(50L);
        assertThat(response.getParentCommentId()).isEqualTo(50L);
    }
}
