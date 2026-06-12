package com.thanhmila.codelearning.service.course;

import com.thanhmila.codelearning.dto.request.LessonCreationRequest;
import com.thanhmila.codelearning.dto.request.LessonReorderRequest;
import com.thanhmila.codelearning.dto.request.LessonUpdateRequest;
import com.thanhmila.codelearning.dto.response.LessonCompletionResponse;
import com.thanhmila.codelearning.dto.response.LessonDetailResponse;
import com.thanhmila.codelearning.entity.course.ChapterEntity;
import com.thanhmila.codelearning.entity.course.CourseEntity;
import com.thanhmila.codelearning.entity.lesson.LessonEntity;
import com.thanhmila.codelearning.entity.enums.EnrollmentStatus;
import com.thanhmila.codelearning.entity.progress.LessonProgressEntity;
import com.thanhmila.codelearning.exception.AppException;
import com.thanhmila.codelearning.exception.ErrorCode;
import com.thanhmila.codelearning.mapper.LessonMapper;
import com.thanhmila.codelearning.repository.course.ChapterRepository;
import com.thanhmila.codelearning.repository.course.CourseRepository;
import com.thanhmila.codelearning.repository.course.EnrollmentRepository;
import com.thanhmila.codelearning.repository.lesson.LessonRepository;
import com.thanhmila.codelearning.repository.progress.CompletedLessonCountRepository;
import com.thanhmila.codelearning.repository.progress.LessonProgressRepository;
import com.thanhmila.codelearning.repository.user.UserRepository;
import com.thanhmila.codelearning.service.cloudinary.CloudinaryService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class LessonService {
    LessonRepository lessonRepository;
    LessonMapper lessonMapper;
    EnrollmentRepository enrollmentRepository;
    LessonProgressRepository lessonProgressRepository;
    UserRepository userRepository;
    CompletedLessonCountRepository completedLessonCountRepository;
    ChapterRepository chapterRepository;
    CourseRepository courseRepository;
    CloudinaryService cloudinaryService;

    public LessonDetailResponse getLessonDetail(Long lessonId, Long userId){
        LessonEntity lessonEntity = lessonRepository.findDetailWithCourseById(lessonId)
                .orElseThrow(() -> new AppException(ErrorCode.LESSON_NOT_FOUND));

        if(lessonEntity.getTrial()){
            return lessonMapper.toLessonDetailResponse(lessonEntity);
        }

        if(userId == null){
            throw new AppException(ErrorCode.UNAUTHENTICATED);
        }

        Long courseId = lessonEntity.getChapter().getCourse().getId();
        boolean enrolled = enrollmentRepository.existsByUserIdAndCourseIdAndStatusIn(userId, courseId, List.of(EnrollmentStatus.ACTIVE, EnrollmentStatus.COMPLETED));

        if(!enrolled){
            throw new AppException(ErrorCode.ACCESS_DENIED_COURSE);
        }

        return lessonMapper.toLessonDetailResponse(lessonEntity);
    }

    @Transactional
    public LessonCompletionResponse completedLesson(Long lessonId, Long userId){
       
        Boolean isCompleted = lessonProgressRepository.existsByLessonIdAndUserId(lessonId, userId);

        if(isCompleted){
            throw new AppException(ErrorCode.LESSON_ALREADY_COMPLETED);
        }

        CourseEntity courseEntity = lessonRepository.findCourseByLessonId(lessonId)
                .orElseThrow(() -> new AppException(ErrorCode.COURSE_NOT_FOUND));

        Long courseId = courseEntity.getId();
        Integer totalLessons = courseEntity.getTotalLessons();

        LessonProgressEntity lessonProgress = LessonProgressEntity.builder()
                .lesson(lessonRepository.getReferenceById(lessonId))
                .user(userRepository.getReferenceById(userId))
                .course(courseEntity)
                .build();
        lessonProgressRepository.save(lessonProgress);

        Integer newCountCompletedLesson = completedLessonCountRepository.incrementAndGetCount(userId, courseId);

        boolean isCourseCompleted = newCountCompletedLesson >= totalLessons;
        if(isCourseCompleted){
            enrollmentRepository.updateStatusByUserIdAndCourseId(userId, courseId, EnrollmentStatus.COMPLETED);
        }

        return LessonCompletionResponse.builder()
                .lessonId(lessonId)
                .courseId(courseId)
                .completedLessonsCount(newCountCompletedLesson)
                .totalLessons(totalLessons)
                .isCourseCompleted(isCourseCompleted)
                .build();   
        
    }

    @Transactional
    public LessonDetailResponse createLesson(Long chapterId, LessonCreationRequest request) {
        ChapterEntity chapter = chapterRepository.findById(chapterId)
                .orElseThrow(() -> new AppException(ErrorCode.CHAPTER_NOT_FOUND));

        LessonEntity lesson = lessonMapper.toLessonEntity(request);
        lesson.setChapter(chapter);

        int maxOrder = lessonRepository.findMaxOrderIndexByChapterId(chapterId);
        lesson.setOrderIndex(maxOrder + 1);

        if (request.getVideoFile() != null && !request.getVideoFile().isEmpty()) {
            try {
                var cloudinaryResponse = cloudinaryService.uploadFile(request.getVideoFile(), "lessons/videos");
                lesson.setVideoUrl(cloudinaryResponse.getSecureUrl());
                lesson.setVideoPublicId(cloudinaryResponse.getPublicId());
            } catch (IOException e) {
                log.error("Failed to upload video to Cloudinary: {}", e.getMessage());
                throw new AppException(ErrorCode.CLOUDINARY_UPLOAD_FAILED);
            }
        }

        LessonEntity savedLesson = lessonRepository.save(lesson);

        CourseEntity course = chapter.getCourse();
        if (course != null) {
            course.setTotalLessons(course.getTotalLessons() + 1);
            if (savedLesson.getVideoUrl() != null) {
                course.setTotalVideos(course.getTotalVideos() + 1);
            }
            courseRepository.save(course);
        }

        return lessonMapper.toLessonDetailResponse(savedLesson);
    }

    @Transactional
    public LessonDetailResponse updateLesson(Long lessonId, LessonUpdateRequest request) {
        LessonEntity lesson = lessonRepository.findById(lessonId)
                .orElseThrow(() -> new AppException(ErrorCode.LESSON_NOT_FOUND));

        String oldVideoPublicId = lesson.getVideoPublicId();
        String oldVideoUrl = lesson.getVideoUrl();

        lessonMapper.updateLessonEntityFromRequest(request, lesson);

        if (request.getVideoFile() != null && !request.getVideoFile().isEmpty()) {
            if (oldVideoPublicId != null) {
                cloudinaryService.deleteFile(oldVideoPublicId);
            }
            try {
                var cloudinaryResponse = cloudinaryService.uploadFile(request.getVideoFile(), "lessons/videos");
                lesson.setVideoUrl(cloudinaryResponse.getSecureUrl());
                lesson.setVideoPublicId(cloudinaryResponse.getPublicId());
            } catch (IOException e) {
                log.error("Failed to upload video to Cloudinary: {}", e.getMessage());
                throw new AppException(ErrorCode.CLOUDINARY_UPLOAD_FAILED);
            }
        } else {
            lesson.setVideoUrl(oldVideoUrl);
            lesson.setVideoPublicId(oldVideoPublicId);
        }

        LessonEntity savedLesson = lessonRepository.save(lesson);

        CourseEntity course = lesson.getChapter().getCourse();
        if (course != null) {
            boolean hadVideo = oldVideoUrl != null;
            boolean hasVideo = savedLesson.getVideoUrl() != null;
            if (!hadVideo && hasVideo) {
                course.setTotalVideos(course.getTotalVideos() + 1);
                courseRepository.save(course);
            } else if (hadVideo && !hasVideo) {
                course.setTotalVideos(Math.max(0, course.getTotalVideos() - 1));
                courseRepository.save(course);
            }
        }

        return lessonMapper.toLessonDetailResponse(savedLesson);
    }

    @Transactional
    public void deleteLesson(Long lessonId) {
        LessonEntity lesson = lessonRepository.findById(lessonId)
                .orElseThrow(() -> new AppException(ErrorCode.LESSON_NOT_FOUND));

        if (lesson.getVideoPublicId() != null) {
            cloudinaryService.deleteFile(lesson.getVideoPublicId());
        }

        CourseEntity course = lesson.getChapter().getCourse();

        lessonRepository.delete(lesson);

        if (course != null) {
            course.setTotalLessons(Math.max(0, course.getTotalLessons() - 1));
            if (lesson.getVideoUrl() != null) {
                course.setTotalVideos(Math.max(0, course.getTotalVideos() - 1));
            }
            courseRepository.save(course);
        }
    }

    @Transactional
    public void reorderLessons(Long chapterId, List<LessonReorderRequest> requests) {
        if (!chapterRepository.existsById(chapterId)) {
            throw new AppException(ErrorCode.CHAPTER_NOT_FOUND);
        }

        List<LessonEntity> lessons = lessonRepository.findByChapterId(chapterId);
        Map<Long, LessonEntity> lessonMap = lessons.stream()
                .collect(Collectors.toMap(LessonEntity::getId, l -> l));

        for (LessonEntity lesson : lessons) {
            lesson.setOrderIndex(lesson.getId().intValue() + 1000);
        }
        lessonRepository.saveAllAndFlush(lessons);

        for (LessonReorderRequest req : requests) {
            LessonEntity lesson = lessonMap.get(req.getId());
            if (lesson != null) {
                lesson.setOrderIndex(req.getOrderIndex());
            }
        }
        lessonRepository.saveAll(lessons);
    }
}
