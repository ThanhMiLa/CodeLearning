-- =========================================================
-- 1. THÊM CÁC DANH MỤC PHÙ HỢP VỚI KHÓA HỌC HIỆN TẠI
-- =========================================================
INSERT INTO categories (name, slug, description) VALUES
                                                     ('Java', 'java', 'Các khóa học về ngôn ngữ lập trình Java và hệ sinh thái Spring Boot'),
                                                     ('Backend Development', 'backend', 'Lập trình API, xử lý logic máy chủ, bảo mật và kiến trúc hệ thống'),
                                                     ('Frontend Development', 'frontend', 'Phát triển giao diện người dùng với các framework hiện đại như React'),
                                                     ('Fullstack Development', 'fullstack', 'Kỹ năng phát triển ứng dụng toàn diện từ Frontend đến Backend'),
                                                     ('Database & SQL', 'database', 'Thiết kế cơ sở dữ liệu quan hệ, viết câu lệnh SQL và tối ưu hóa PostgreSQL'),
                                                     ('Data Structures & Algorithms', 'dsa', 'Cấu trúc dữ liệu và giải thuật, luyện thi thuật toán Online Judge'),
                                                     ('DevOps & Deployment', 'devops', 'Triển khai dự án, đóng gói ứng dụng với Docker và quản trị hệ thống');

-- =========================================================
-- 2. THÊM DỮ LIỆU BẢNG TRUNG GIAN (COURSE_CATEGORY_MAPPINGS)
-- Ghi chú: Giả định 5 khóa học bạn vừa insert có ID từ 1 đến 5
-- =========================================================

-- ID = 1: Java Backend Development with Spring Boot
-- Thuộc tính: Java (1), Backend (2)
INSERT INTO course_category_mappings (course_id, category_id) VALUES
                                                                  (1, 1),
                                                                  (1, 2);

-- ID = 2: Data Structures and Algorithms for Coding Interviews
-- Thuộc tính: Java (1), DSA (6) (Vì trong mô tả có nhắc đến Java Online Judge)
INSERT INTO course_category_mappings (course_id, category_id) VALUES
                                                                  (2, 1),
                                                                  (2, 6);

-- ID = 3: Fullstack Web Development with React and Spring Boot
-- Thuộc tính: Java (1), Backend (2), Frontend (3), Fullstack (4)
INSERT INTO course_category_mappings (course_id, category_id) VALUES
                                                                  (3, 1),
                                                                  (3, 2),
                                                                  (3, 3),
                                                                  (3, 4);

-- ID = 4: SQL and PostgreSQL for Backend Developers
-- Thuộc tính: Backend (2), Database (5)
INSERT INTO course_category_mappings (course_id, category_id) VALUES
                                                                  (4, 2),
                                                                  (4, 5);

-- ID = 5: Docker and Deployment for Spring Boot Applications
-- Thuộc tính: Java (1), Backend (2), DevOps (7)
INSERT INTO course_category_mappings (course_id, category_id) VALUES
                                                                  (5, 1),
                                                                  (5, 2),
                                                                  (5, 7);