-- Migration: Add OJ_PROBLEM_SUBMIT permission
-- Purpose: Allow users to submit solutions to online judge problems

-- Add new permission: OJ_PROBLEM_SUBMIT
INSERT INTO public.permissions (id, name)
VALUES (81, 'OJ_PROBLEM_SUBMIT')
ON CONFLICT DO NOTHING;

-- Assign OJ_PROBLEM_SUBMIT permission to USER role (id=1)
INSERT INTO public.role_permissions (role_id, permission_id)
VALUES (1, 81)
ON CONFLICT DO NOTHING;

-- Assign OJ_PROBLEM_SUBMIT permission to TEACHER role (id=2)
INSERT INTO public.role_permissions (role_id, permission_id)
VALUES (2, 81)
ON CONFLICT DO NOTHING;

