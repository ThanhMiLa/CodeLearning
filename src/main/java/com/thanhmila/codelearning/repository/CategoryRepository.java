package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.course.CategoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface CategoryRepository extends JpaRepository<CategoryEntity, Long> {
}
