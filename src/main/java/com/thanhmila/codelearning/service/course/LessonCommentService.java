package com.thanhmila.codelearning.service.course;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.thanhmila.codelearning.dto.response.RootLessonCommentResponse;
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
    
    public Page<RootLessonCommentResponse> getRootComments(Long lessonId, Pageable pageable){
        Page<RootLessonCommentProjection> rootCommentsProjection = lessonCommentRepository.findRootCommentsWithReplyCount(lessonId, pageable);
        return rootCommentsProjection.map(this::mapToRootLessonCommentResponse);
    }

    public RootLessonCommentResponse mapToRootLessonCommentResponse(RootLessonCommentProjection projection){
        return RootLessonCommentResponse.builder()
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
