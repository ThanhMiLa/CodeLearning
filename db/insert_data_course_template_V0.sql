-- =========================
-- Roles
-- =========================
INSERT INTO roles (name)
VALUES
    ('USER'),
    ('TEACHER'),
    ('ADMIN')
    ON CONFLICT (name) DO NOTHING;


-- =========================
-- Permissions
-- =========================
INSERT INTO permissions (name)
VALUES
    ('AUTH_REGISTER'),
    ('AUTH_LOGIN'),
    ('AUTH_LOGOUT'),

    ('COURSE_VIEW_LIST'),
    ('COURSE_VIEW_DETAIL'),

    ('COURSE_CREATE'),
    ('COURSE_UPDATE'),
    ('COURSE_DELETE'),
    ('COURSE_MANAGE_STATUS'),

    ('CHAPTER_CREATE'),
    ('CHAPTER_UPDATE'),
    ('CHAPTER_DELETE'),

    ('LESSON_CREATE'),
    ('LESSON_UPDATE'),
    ('LESSON_DELETE'),

    ('TEACHER_ASSIGN_COURSE'),
    ('TEACHER_VIEW_ASSIGNED_COURSE'),

    ('USER_VIEW'),
    ('USER_CREATE'),
    ('USER_UPDATE'),
    ('USER_DELETE'),
    ('USER_LOCK'),
    ('USER_UNLOCK'),

    ('TEACHER_VIEW'),
    ('TEACHER_CREATE'),
    ('TEACHER_UPDATE'),
    ('TEACHER_DELETE'),

    ('PAYMENT_CREATE'),
    ('PAYMENT_VIEW_OWN'),
    ('ENROLLMENT_CREATE'),
    ('ENROLLMENT_VIEW_OWN'),

    ('COURSE_CONTENT_ACCESS'),
    ('LESSON_COMPLETE'),
    ('LEARNING_PROGRESS_VIEW_OWN'),

    ('STUDENT_PROGRESS_VIEW_ASSIGNED_COURSE'),
    ('USER_LEARNING_STATISTICS_VIEW_ALL'),

    ('QUIZ_VIEW'),
    ('QUIZ_SUBMIT'),
    ('QUIZ_RESULT_VIEW_OWN'),

    ('QUIZ_CREATE_ASSIGNED_COURSE'),
    ('QUIZ_UPDATE_ASSIGNED_COURSE'),
    ('QUIZ_DELETE_ASSIGNED_COURSE'),

    ('OJ_PROBLEM_VIEW'),
    ('OJ_SUBMISSION_CREATE_LESSON'),
    ('OJ_SUBMISSION_VIEW_OWN'),

    ('OJ_PROBLEM_CREATE_ASSIGNED_COURSE'),
    ('OJ_PROBLEM_UPDATE_ASSIGNED_COURSE'),
    ('OJ_PROBLEM_DELETE_ASSIGNED_COURSE'),
    ('OJ_TESTCASE_MANAGE_ASSIGNED_COURSE'),
    ('OJ_TAG_MANAGE'),

    ('FILE_ASSIGNMENT_VIEW'),
    ('FILE_SUBMISSION_CREATE'),
    ('FILE_SUBMISSION_VIEW_OWN'),

    ('FILE_ASSIGNMENT_CREATE_ASSIGNED_COURSE'),
    ('FILE_ASSIGNMENT_UPDATE_ASSIGNED_COURSE'),
    ('FILE_ASSIGNMENT_DELETE_ASSIGNED_COURSE'),
    ('FILE_SUBMISSION_VIEW_ASSIGNED_COURSE'),
    ('FILE_SUBMISSION_DOWNLOAD_ASSIGNED_COURSE'),
    ('FILE_SUBMISSION_GRADE_ASSIGNED_COURSE'),

    ('COMMENT_CREATE'),
    ('COMMENT_REPLY_OWN'),
    ('COMMENT_REPLY_ASSIGNED_COURSE'),
    ('COMMENT_VIEW'),

    ('CONTEST_VIEW_LIST'),
    ('CONTEST_JOIN'),
    ('CONTEST_PROBLEM_VIEW'),
    ('CONTEST_SUBMISSION_CREATE'),
    ('CONTEST_RANKING_VIEW'),

    ('CONTEST_CREATE'),
    ('CONTEST_UPDATE_OWN'),
    ('CONTEST_DELETE_OWN'),
    ('CONTEST_PROBLEM_ADD_OWN'),
    ('CONTEST_PROBLEM_REMOVE_OWN'),
    ('CONTEST_RANKING_VIEW_BY_PASSWORD'),
    ('CONTEST_SUBMISSION_VIEW_OWN'),

    ('CONTEST_VIEW_ALL'),
    ('CONTEST_UPDATE_ALL'),
    ('CONTEST_DELETE_ALL'),
    ('CONTEST_SUBMISSION_VIEW_ALL'),

    ('SYSTEM_STATISTICS_VIEW')
    ON CONFLICT (name) DO NOTHING;


-- =========================
-- USER permissions
-- =========================
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r
         JOIN permissions p ON p.name IN (
                                          'AUTH_REGISTER',
                                          'AUTH_LOGIN',
                                          'AUTH_LOGOUT',

                                          'COURSE_VIEW_LIST',
                                          'COURSE_VIEW_DETAIL',

                                          'PAYMENT_CREATE',
                                          'PAYMENT_VIEW_OWN',
                                          'ENROLLMENT_CREATE',
                                          'ENROLLMENT_VIEW_OWN',

                                          'COURSE_CONTENT_ACCESS',
                                          'LESSON_COMPLETE',
                                          'LEARNING_PROGRESS_VIEW_OWN',

                                          'QUIZ_VIEW',
                                          'QUIZ_SUBMIT',
                                          'QUIZ_RESULT_VIEW_OWN',

                                          'OJ_PROBLEM_VIEW',
                                          'OJ_SUBMISSION_CREATE_LESSON',
                                          'OJ_SUBMISSION_VIEW_OWN',

                                          'FILE_ASSIGNMENT_VIEW',
                                          'FILE_SUBMISSION_CREATE',
                                          'FILE_SUBMISSION_VIEW_OWN',

                                          'COMMENT_VIEW',
                                          'COMMENT_CREATE',
                                          'COMMENT_REPLY_OWN',

                                          'CONTEST_VIEW_LIST',
                                          'CONTEST_JOIN',
                                          'CONTEST_PROBLEM_VIEW',
                                          'CONTEST_SUBMISSION_CREATE',
                                          'CONTEST_RANKING_VIEW'
    )
WHERE r.name = 'USER'
    ON CONFLICT (role_id, permission_id) DO NOTHING;


-- =========================
-- TEACHER permissions
-- =========================
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r
         JOIN permissions p ON p.name IN (
                                          'AUTH_LOGIN',
                                          'AUTH_LOGOUT',

                                          'COURSE_VIEW_LIST',
                                          'COURSE_VIEW_DETAIL',
                                          'TEACHER_VIEW_ASSIGNED_COURSE',

                                          'STUDENT_PROGRESS_VIEW_ASSIGNED_COURSE',

                                          'QUIZ_VIEW',
                                          'QUIZ_CREATE_ASSIGNED_COURSE',
                                          'QUIZ_UPDATE_ASSIGNED_COURSE',
                                          'QUIZ_DELETE_ASSIGNED_COURSE',

                                          'OJ_PROBLEM_VIEW',
                                          'OJ_PROBLEM_CREATE_ASSIGNED_COURSE',
                                          'OJ_PROBLEM_UPDATE_ASSIGNED_COURSE',
                                          'OJ_PROBLEM_DELETE_ASSIGNED_COURSE',
                                          'OJ_TESTCASE_MANAGE_ASSIGNED_COURSE',
                                          'OJ_TAG_MANAGE',

                                          'FILE_ASSIGNMENT_VIEW',
                                          'FILE_ASSIGNMENT_CREATE_ASSIGNED_COURSE',
                                          'FILE_ASSIGNMENT_UPDATE_ASSIGNED_COURSE',
                                          'FILE_ASSIGNMENT_DELETE_ASSIGNED_COURSE',
                                          'FILE_SUBMISSION_VIEW_ASSIGNED_COURSE',
                                          'FILE_SUBMISSION_DOWNLOAD_ASSIGNED_COURSE',
                                          'FILE_SUBMISSION_GRADE_ASSIGNED_COURSE',

                                          'COMMENT_VIEW',
                                          'COMMENT_CREATE',
                                          'COMMENT_REPLY_ASSIGNED_COURSE',

                                          'CONTEST_VIEW_LIST',
                                          'CONTEST_CREATE',
                                          'CONTEST_UPDATE_OWN',
                                          'CONTEST_DELETE_OWN',
                                          'CONTEST_PROBLEM_ADD_OWN',
                                          'CONTEST_PROBLEM_REMOVE_OWN',
                                          'CONTEST_RANKING_VIEW_BY_PASSWORD',
                                          'CONTEST_SUBMISSION_VIEW_OWN'
    )
WHERE r.name = 'TEACHER'
    ON CONFLICT (role_id, permission_id) DO NOTHING;


-- =========================
-- ADMIN permissions
-- =========================
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r
         CROSS JOIN permissions p
WHERE r.name = 'ADMIN'
    ON CONFLICT (role_id, permission_id) DO NOTHING;