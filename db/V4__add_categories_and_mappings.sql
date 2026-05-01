-- =========================================================
-- V3__add_categories_and_mappings.sql
-- Thêm hệ thống Danh mục (Lĩnh vực) cho Khóa học (Many-to-Many)
-- =========================================================

BEGIN;

-- 1. Tạo bảng Danh mục (Lĩnh vực)
-- Chúng ta thêm cột 'slug' để sau này bạn làm URL thân thiện (vd: /courses/backend-java)
CREATE TABLE IF NOT EXISTS categories (
                                          id BIGSERIAL PRIMARY KEY,
                                          name VARCHAR(100) NOT NULL UNIQUE,
                                          slug VARCHAR(120) NOT NULL UNIQUE,
                                          description TEXT,
                                          created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
                                          updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2. Tạo bảng trung gian để thể hiện mối quan hệ Many-to-Many
CREATE TABLE IF NOT EXISTS course_category_mappings (
                                                        course_id BIGINT NOT NULL,
                                                        category_id BIGINT NOT NULL,
                                                        PRIMARY KEY (course_id, category_id),

                                                        CONSTRAINT fk_course_category_course
                                                            FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
                                                        CONSTRAINT fk_course_category_category
                                                            FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

-- 3. Đánh Index để tối ưu tốc độ truy vấn khi filter theo Category
CREATE INDEX IF NOT EXISTS idx_course_category_mapping_category_id
    ON course_category_mappings(category_id);

-- 4. Thêm Trigger tự động cập nhật updated_at cho bảng categories
DROP TRIGGER IF EXISTS trg_categories_set_updated_at ON categories;
CREATE TRIGGER trg_categories_set_updated_at
    BEFORE UPDATE ON categories
    FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

COMMIT;