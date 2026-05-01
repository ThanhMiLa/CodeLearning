BEGIN;

-- =========================================================
-- PAYMENTS
-- =========================================================

INSERT INTO payments (
    user_id,
    course_id,
    amount,
    payment_method,
    transaction_code,
    payment_status,
    paid_at
)
VALUES
    (2, 1, 499000.00, 'MOMO', 'PAY-U2-C1-20260430-001', 'SUCCESS', now() - interval '10 days'),
    (2, 2, 399000.00, 'VNPAY', 'PAY-U2-C2-20260430-002', 'SUCCESS', now() - interval '8 days'),
    (2, 3, 699000.00, 'BANK_TRANSFER', 'PAY-U2-C3-20260430-003', 'SUCCESS', now() - interval '5 days'),

    (5, 2, 399000.00, 'MOMO', 'PAY-U5-C2-20260430-004', 'SUCCESS', now() - interval '12 days'),
    (5, 4, 299000.00, 'VNPAY', 'PAY-U5-C4-20260430-005', 'SUCCESS', now() - interval '7 days'),
    (5, 5, 349000.00, 'BANK_TRANSFER', 'PAY-U5-C5-20260430-006', 'SUCCESS', now() - interval '3 days');

-- =========================================================
-- ENROLLMENTS
-- =========================================================

INSERT INTO enrollments (
    user_id,
    course_id,
    payment_id,
    enrolled_at,
    status
)
VALUES
    (
        2,
        1,
        (SELECT id FROM payments WHERE transaction_code = 'PAY-U2-C1-20260430-001'),
        now() - interval '10 days',
        'ACTIVE'
    ),
    (
        2,
        2,
        (SELECT id FROM payments WHERE transaction_code = 'PAY-U2-C2-20260430-002'),
        now() - interval '8 days',
        'ACTIVE'
    ),
    (
        2,
        3,
        (SELECT id FROM payments WHERE transaction_code = 'PAY-U2-C3-20260430-003'),
        now() - interval '5 days',
        'ACTIVE'
    ),
    (
        5,
        2,
        (SELECT id FROM payments WHERE transaction_code = 'PAY-U5-C2-20260430-004'),
        now() - interval '12 days',
        'COMPLETED'
    ),
    (
        5,
        4,
        (SELECT id FROM payments WHERE transaction_code = 'PAY-U5-C4-20260430-005'),
        now() - interval '7 days',
        'ACTIVE'
    ),
    (
        5,
        5,
        (SELECT id FROM payments WHERE transaction_code = 'PAY-U5-C5-20260430-006'),
        now() - interval '3 days',
        'ACTIVE'
    );

-- =========================================================
-- COURSE REVIEWS
-- =========================================================

INSERT INTO course_reviews (
    course_id,
    user_id,
    content,
    rating,
    created_at,
    updated_at
)
VALUES
    (
        1,
        2,
        'Khóa học Spring Boot rất thực tế, phần security và cấu trúc project giải thích rõ ràng. Phù hợp để làm project backend đưa vào CV.',
        5,
        now() - interval '2 days',
        now() - interval '2 days'
    ),
    (
        2,
        2,
        'Nội dung thuật toán được chia theo chủ đề dễ học, bài tập online judge giúp luyện tư duy tốt.',
        4,
        now() - interval '3 days',
        now() - interval '3 days'
    ),
    (
        2,
        5,
        'Khóa DSA có nhiều ví dụ thực hành, phù hợp cho người chuẩn bị phỏng vấn fresher/intern.',
        5,
        now() - interval '4 days',
        now() - interval '4 days'
    ),
    (
        4,
        5,
        'Phần SQL và PostgreSQL khá hữu ích, đặc biệt là constraint, index và thiết kế database quan hệ.',
        5,
        now() - interval '1 day',
        now() - interval '1 day'
    ),
    (
        5,
        5,
        'Khóa Docker giúp hiểu cách cấu hình môi trường chạy backend với PostgreSQL và Redis rõ ràng hơn.',
        4,
        now() - interval '1 day',
        now() - interval '1 day'
    );

COMMIT;