package com.thanhmila.codelearning.repository.course;

import com.thanhmila.codelearning.entity.course.TeacherCourseAssignmentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface TeacherCourseAssignmentRepository extends JpaRepository<TeacherCourseAssignmentEntity, Long> {

    @Query("SELECT CASE WHEN COUNT(tca) > 0 THEN TRUE ELSE FALSE END " +
           "FROM TeacherCourseAssignmentEntity tca " +
           "JOIN tca.course c " +
           "JOIN c.chapters ch " +
           "JOIN ch.lessons l " +
           "WHERE tca.teacher.id = :teacherId AND l.id = :lessonId")
    boolean existsByTeacherIdAndLessonId(Long teacherId, Long lessonId);
    
}
