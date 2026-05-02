ALTER TABLE courses
    ADD COLUMN total_lessons INTEGER DEFAULT 0 NOT NULL,
    ADD COLUMN total_quizzes INTEGER DEFAULT 0 NOT NULL,
    ADD COLUMN total_assignments INTEGER DEFAULT 0 NOT NULL,
    ADD COLUMN total_online_judge_problems INTEGER DEFAULT 0 NOT NULL,
    ADD COLUMN total_videos INTEGER DEFAULT 0 NOT NULL;
    ALTER TABLE courses ADD COLUMN estimated_duration_hours INTEGER DEFAULT 0;
