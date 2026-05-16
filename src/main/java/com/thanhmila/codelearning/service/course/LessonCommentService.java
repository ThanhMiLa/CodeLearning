package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.repository.lesson.LessonCommentRepository;
import com.thanhmila.codelearning.repository.lesson.LessonRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thanhmila.codelearning.dto.request.LessonCommentRequest;
import com.thanhmila.codelearning.dto.response.LessonCommentResponse;
import com.thanhmila.codelearning.entity.lesson.LessonCommentEntity;
import com.thanhmila.codelearning.entity.lesson.LessonEntity;
import com.thanhmila.codelearning.entity.user.UserEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.repository.user.UserRepository;
import com.thanhmila.codelearning.repository.projection.RootLessonCommentProjection;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class LessonCommentService {
    
    LessonCommentRepository lessonCommentRepository;
    LessonRepository lessonRepository;
    UserRepository userRepository;
    
    public Page<LessonCommentResponse> getRootComments(Long lessonId, Pageable pageable){
        Page<RootLessonCommentProjection> rootCommentsProjection = lessonCommentRepository.findRootCommentsWithReplyCount(lessonId, pageable);
        return rootCommentsProjection.map(this::mapToRootLessonCommentResponse);
    }

    public Page<LessonCommentResponse> getReplies(Long commentId, Pageable pageable){
        Page<LessonCommentEntity> replies = lessonCommentRepository.findByParentCommentId(commentId, pageable);
        return replies.map(this::mapToLessonCommentResponse);
    }

    @Transactional
    public LessonCommentResponse createComment(Long lessonId, Long userId, LessonCommentRequest request){
        LessonEntity lesson = lessonRepository.findById(lessonId)
                .orElseThrow(() -> new AppException(ErrorCode.LESSON_NOT_FOUND));

        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));

        LessonCommentEntity actualParentComment = null;

        if(request.getParentCommentId() != null){
            LessonCommentEntity targetComment = lessonCommentRepository.findById(request.getParentCommentId())
                    .orElseThrow(() -> new AppException(ErrorCode.COMMENT_NOT_FOUND));

            if(!targetComment.getLesson().getId().equals(lessonId)){
                throw new AppException(ErrorCode.INVALID_COMMENT_LESSON);
            }

            if(targetComment.getParentComment() != null){
                actualParentComment = targetComment.getParentComment();
            } else {
                actualParentComment = targetComment;
            }
        }

        LessonCommentEntity lessonComment = LessonCommentEntity.builder()
                .lesson(lesson)
                .user(user)
                .content(request.getContent())
                .parentComment(actualParentComment)
                .build();
        
        lessonComment = lessonCommentRepository.save(lessonComment);
        return mapToLessonCommentResponse(lessonComment);
    }
    
    private LessonCommentResponse mapToLessonCommentResponse(LessonCommentEntity entity){
        return LessonCommentResponse.builder()
                .id(entity.getId())
                .userId(entity.getUser().getId())
                .displayName(entity.getUser().getDisplayName())
                .content(entity.getContent())
                .createdAt(entity.getCreatedAt().toInstant())
                .updatedAt(entity.getUpdatedAt().toInstant())
                .replyCount(null)
                .parentCommentId(entity.getParentComment() != null ? entity.getParentComment().getId() : null)
                .build();
    }

    private LessonCommentResponse mapToRootLessonCommentResponse(RootLessonCommentProjection projection){
        return LessonCommentResponse.builder()
                .id(projection.getId())
                .userId(projection.getUserId())
                .displayName(projection.getDisplayName())
                .content(projection.getContent())
                .createdAt(projection.getCreatedAt())
                .updatedAt(projection.getUpdatedAt())
                .replyCount(projection.getReplyCount())
                .build();
    }



}
