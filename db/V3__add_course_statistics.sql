-- =========================================================
-- V3__add_course_statistics.sql
-- Thêm các cột thống kê phi chuẩn hóa cho bảng courses
-- =========================================================

BEGIN;

-- 1. Thêm 3 cột mới vào bảng courses với giá trị mặc định là 0
ALTER TABLE courses
    ADD COLUMN average_rating NUMERIC(3,2) NOT NULL DEFAULT 0.00,
    ADD COLUMN total_reviews INT NOT NULL DEFAULT 0,
    ADD COLUMN total_enrolled INT NOT NULL DEFAULT 0;

-- 2. ĐÁNH CHỈ MỤC (INDEX) CHO CÁC CỘT NÀY
-- Rất quan trọng: Vì bạn dùng các cột này để làm tiêu chí search (JPA Specifications)
-- và sắp xếp mặc định (Sort by total_enrolled DESC), nên bắt buộc phải có Index để truy vấn nhanh.
CREATE INDEX IF NOT EXISTS idx_courses_average_rating
    ON courses(average_rating DESC);

CREATE INDEX IF NOT EXISTS idx_courses_total_enrolled
    ON courses(total_enrolled DESC);

-- 3. DATA MIGRATION (Khôi phục dữ liệu)
-- Nếu database hiện tại của bạn đã có sẵn data (có user đã mua, đã review),
-- bạn cần chạy lệnh này 1 lần duy nhất để tính toán lại số liệu thật đắp vào 3 cột vừa tạo.
UPDATE courses c
SET
    average_rating = COALESCE((
                                  SELECT ROUND(AVG(rating)::numeric, 2)
                                  FROM course_reviews cr
                                  WHERE cr.course_id = c.id
                              ), 0.00),
    total_reviews = (
        SELECT COUNT(id)
        FROM course_reviews cr
        WHERE cr.course_id = c.id
    ),
    total_enrolled = (
        SELECT COUNT(id)
        FROM enrollments e
        WHERE e.course_id = c.id
    );

COMMIT;