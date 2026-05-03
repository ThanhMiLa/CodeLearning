ALTER TABLE lessons
    ADD COLUMN has_quiz BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN has_assignment BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN has_online_judge BOOLEAN NOT NULL DEFAULT false;