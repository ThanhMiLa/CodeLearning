-- Migration: add contest_id to online_judge_problems
-- Adds a nullable FK to contests and enforces that contest_id must be present when problem_scope = 'CONTEST'.

ALTER TABLE online_judge_problems
    ADD COLUMN contest_id bigint;

ALTER TABLE online_judge_problems
    ADD CONSTRAINT fk_online_judge_problems_contest
        FOREIGN KEY (contest_id)
        REFERENCES contests (id)
        ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_online_judge_problems_contest_id
    ON online_judge_problems (contest_id);

-- Ensure contest_id is provided when problem_scope = 'CONTEST'
ALTER TABLE online_judge_problems
    ADD CONSTRAINT chk_online_judge_problems_scope_contest
    CHECK (
        (problem_scope = 'CONTEST'::problem_scope AND contest_id IS NOT NULL)
        OR (problem_scope != 'CONTEST'::problem_scope)
    );

