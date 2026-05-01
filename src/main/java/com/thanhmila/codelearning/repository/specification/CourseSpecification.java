package com.thanhmila.codelearning.repository.specification;

import com.thanhmila.codelearning.entity.CategoryEntity;
import com.thanhmila.codelearning.entity.CourseEntity;
import com.thanhmila.codelearning.entity.TeacherCourseAssignmentEntity;
import com.thanhmila.codelearning.entity.TeacherEntity;
import com.thanhmila.codelearning.entity.enums.CourseStatus;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;
import org.springframework.data.jpa.domain.Specification;

import java.math.BigDecimal;
import java.util.List;

public class CourseSpecification {

    public static Specification<CourseEntity> isStatusActive() {
        return (root, query, cb) -> cb.equal(root.get("status"), CourseStatus.ACTIVE);
    }

    public static Specification<CourseEntity> hasKeyword(String keyword) {
        return (root, query, cb) -> {
            if (keyword == null || keyword.isBlank()) return null;
            String pattern = "%" + keyword.toLowerCase() + "%";
            return cb.or(
                    cb.like(cb.lower(root.get("title")), pattern),
                    cb.like(cb.lower(root.get("shortDescription")), pattern)
            );
        };
    }

    public static Specification<CourseEntity> hasCategories(List<Long> categoryIds) {
        return (root, query, cb) -> {
            if (categoryIds == null || categoryIds.isEmpty()) return null;

            Join<CourseEntity, CategoryEntity> categoryJoin = root.join("categories", JoinType.INNER);

            query.distinct(true);

            return categoryJoin.get("id").in(categoryIds);
        };
    }

    public static Specification<CourseEntity> hasPriceBetween(BigDecimal minPrice, BigDecimal maxPrice) {
        return (root, query, cb) -> {
            if (minPrice == null && maxPrice == null) return null;
            if (minPrice != null && maxPrice != null) return cb.between(root.get("price"), minPrice, maxPrice);
            if (minPrice != null) return cb.greaterThanOrEqualTo(root.get("price"), minPrice);
            return cb.lessThanOrEqualTo(root.get("price"), maxPrice);
        };
    }

    public static Specification<CourseEntity> hasRatingBetween(Double minRating, Double maxRating) {
        return (root, query, cb) -> {
            if (minRating == null && maxRating == null) return null;
            if (minRating != null && maxRating != null) return cb.between(root.get("averageRating"), minRating, maxRating);
            if (minRating != null) return cb.greaterThanOrEqualTo(root.get("averageRating"), minRating);
            return cb.lessThanOrEqualTo(root.get("averageRating"), maxRating);
        };
    }

    public static Specification<CourseEntity> hasTeacherName(String teacherName){
        return ((root, query, cb) ->{
            if(teacherName == null || teacherName.isBlank())    return null;

            String pattern = "%" + teacherName.toLowerCase() + "%";

            Join<CourseEntity, TeacherCourseAssignmentEntity> teacherCourseAssignmentJoin = root.join("teacherAssignments", JoinType.INNER);
            Join<TeacherCourseAssignmentEntity, TeacherEntity> teacherJoin = teacherCourseAssignmentJoin.join("teacher", JoinType.INNER);

            query.distinct(true);

            return cb.like(cb.lower(teacherJoin.get("fullName")), pattern);
        });
    }
}

