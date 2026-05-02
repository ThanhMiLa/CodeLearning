package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.CourseEntity;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CourseRepository extends JpaRepository<CourseEntity, Long>, JpaSpecificationExecutor<CourseEntity> {
    @EntityGraph(attributePaths = {"categories", "teacherAssignments", "teacherAssignments.teacher"})
    @Query( "SELECT c " +
            "FROM CourseEntity c " +
            "WHERE c.id = :courseId " +
                   "AND c.status = 'ACTIVE'")
    Optional<CourseEntity> findCourseDetailById(@Param("courseId") Long courseId);
}
