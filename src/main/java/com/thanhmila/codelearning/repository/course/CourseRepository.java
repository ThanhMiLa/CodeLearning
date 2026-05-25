package com.thanhmila.codelearning.repository.course;

import com.thanhmila.codelearning.entity.course.CourseEntity;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.Modifying;
import java.util.List;
import java.util.Optional;

@Repository
public interface CourseRepository extends JpaRepository<CourseEntity, Long>, JpaSpecificationExecutor<CourseEntity> {
    @EntityGraph(attributePaths = {"categories", "teacherAssignments", "teacherAssignments.teacher"})
    @Query( "SELECT c " +
            "FROM CourseEntity c " +
            "WHERE c.id = :courseId " +
                   "AND c.status = 'ACTIVE'")
    Optional<CourseEntity> findCourseDetailById(@Param("courseId") Long courseId);

    @Modifying
    @Query("UPDATE CourseEntity c SET c.totalEnrolled = c.totalEnrolled + 1 WHERE c.id = :courseId")
    void incrementTotalEnrolled(@Param("courseId") Long courseId);

    @Modifying
    @Query("UPDATE CourseEntity c SET c.totalEnrolled = c.totalEnrolled + 1 WHERE c.id IN :courseIds")
    void incrementTotalEnrolledForCourses(@Param("courseIds") List<Long> courseIds);
}

