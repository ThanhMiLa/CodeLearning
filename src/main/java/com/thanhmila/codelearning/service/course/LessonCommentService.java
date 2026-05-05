package com.thanhmila.codelearning.service.course;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.thanhmila.codelearning.dto.response.LessonCommentResponse;
import com.thanhmila.codelearning.entity.course.LessonCommentEntity;
import com.thanhmila.codelearning.repository.LessonCommentRepository;
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
    
    public Page<LessonCommentResponse> getRootComments(Long lessonId, Pageable pageable){
        Page<RootLessonCommentProjection> rootCommentsProjection = lessonCommentRepository.findRootCommentsWithReplyCount(lessonId, pageable);
        return rootCommentsProjection.map(this::mapToRootLessonCommentResponse);
    }

    public Page<LessonCommentResponse> getReplies(Long commentId, Pageable pageable){
        Page<LessonCommentEntity> replies = lessonCommentRepository.findByParentCommentId(commentId, pageable);
        return replies.map(this::mapToLessonCommentResponse);
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
