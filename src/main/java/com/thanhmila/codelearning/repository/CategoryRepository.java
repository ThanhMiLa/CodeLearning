package com.thanhmila.codelearning.repository;

import com.thanhmila.codelearning.entity.CategoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<CategoryEntity, Long> {
}
