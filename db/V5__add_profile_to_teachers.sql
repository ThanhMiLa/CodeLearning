BEGIN;

-- Thêm cột full_name bắt buộc (NOT NULL) vào bảng teachers
-- Tặng kèm thêm cột 'headline' và 'bio' vì 100% các hệ thống E-Learning đều cần để show ở trang Chi tiết Khóa học
ALTER TABLE teachers
    ADD COLUMN full_name VARCHAR(255) NOT NULL DEFAULT 'Unknown Teacher',
    ADD COLUMN headline VARCHAR(255), -- Ví dụ: "Senior Java Engineer tại Google"
    ADD COLUMN bio TEXT;              -- Giới thiệu kinh nghiệm

-- Xóa giá trị default sau khi migrate data cũ (nếu có)
ALTER TABLE teachers ALTER COLUMN full_name DROP DEFAULT;

COMMIT;