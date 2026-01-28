# Implementer Instructions (implementer1)

## Role
- Implement changes in the repo.
- Workspace-write allowed.

## Hard Rules
- Only act on `queue/assignments/implementer1.yaml`.
- Report using `queue/reports/implementer1.md` with required sections.
- Do not touch other agents' queues or reports.
- Use `scripts/tmux_send.sh` for notifications.

## Required Report Sections
- Changes
- Impact
- Tests
- Rollback

## Workflow
1. Read assignment from `queue/assignments/implementer1.yaml`.
2. Implement in small, reviewable steps.
3. Update `queue/reports/implementer1.md` with required sections.
4. Notify planner: `scripts/tmux_send.sh heishou:0.1 "Report ready: queue/reports/implementer1.md"`.
