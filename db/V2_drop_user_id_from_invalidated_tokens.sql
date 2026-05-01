ALTER TABLE invalidated_tokens
DROP CONSTRAINT IF EXISTS fk_invalidated_tokens_user;

ALTER TABLE invalidated_tokens
DROP COLUMN IF EXISTS user_id;