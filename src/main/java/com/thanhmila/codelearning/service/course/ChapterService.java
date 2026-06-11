package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.request.ChapterCreationRequest;
import com.thanhmila.codelearning.dto.request.ChapterReorderRequest;
import com.thanhmila.codelearning.dto.request.ChapterUpdateRequest;
import com.thanhmila.codelearning.dto.response.ChapterResponse;
import com.thanhmila.codelearning.entity.course.ChapterEntity;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.ChapterMapper;
import com.thanhmila.codelearning.repository.course.ChapterRepository;
import com.thanhmila.codelearning.repository.course.CourseRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ChapterService {

    ChapterRepository chapterRepository;
    CourseRepository courseRepository;
    ChapterMapper chapterMapper;

    @Transactional
    public ChapterResponse createChapter(Long courseId, ChapterCreationRequest request) {
        CourseEntity course = courseRepository.findById(courseId)
                .orElseThrow(() -> new AppException(ErrorCode.COURSE_NOT_FOUND));

        ChapterEntity chapter = chapterMapper.toChapterEntity(request);
        chapter.setCourse(course);

        int maxOrder = chapterRepository.findMaxOrderIndexByCourseId(courseId);
        chapter.setOrderIndex(maxOrder + 1);

        ChapterEntity savedChapter = chapterRepository.save(chapter);
        return chapterMapper.toChapterResponse(savedChapter);
    }

    @Transactional
    public ChapterResponse updateChapterTitle(Long chapterId, ChapterUpdateRequest request) {
        ChapterEntity chapter = chapterRepository.findById(chapterId)
                .orElseThrow(() -> new AppException(ErrorCode.CHAPTER_NOT_FOUND));

        chapter.setTitle(request.getTitle());

        ChapterEntity savedChapter = chapterRepository.save(chapter);
        return chapterMapper.toChapterResponse(savedChapter);
    }

    @Transactional
    public void deleteChapter(Long chapterId) {
        ChapterEntity chapter = chapterRepository.findById(chapterId)
                .orElseThrow(() -> new AppException(ErrorCode.CHAPTER_NOT_FOUND));

        chapterRepository.delete(chapter);
    }

    @Transactional
    public void reorderChapters(Long courseId, List<ChapterReorderRequest> requests) {
        if (!courseRepository.existsById(courseId)) {
            throw new AppException(ErrorCode.COURSE_NOT_FOUND);
        }

        List<ChapterEntity> chapters = chapterRepository.findByCourseId(courseId);
        Map<Long, ChapterEntity> chapterMap = chapters.stream()
                .collect(Collectors.toMap(ChapterEntity::getId, c -> c));

        // 1. Set all orderIndex values temporarily to their unique ID to satisfy both CHECK (>0) and UNIQUE constraints
        for (ChapterEntity chapter : chapters) {
            chapter.setOrderIndex(chapter.getId().intValue());
        }
        chapterRepository.saveAllAndFlush(chapters);

        // 2. Set new positive orderIndex values from requests
        for (ChapterReorderRequest req : requests) {
            ChapterEntity chapter = chapterMap.get(req.getId());
            if (chapter != null) {
                chapter.setOrderIndex(req.getOrderIndex());
            }
        }
        chapterRepository.saveAll(chapters);
    }
}
