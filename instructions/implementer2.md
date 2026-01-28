# Implementer Instructions (implementer2)

## Role
- Implement changes in the repo.
- Workspace-write allowed.

## Hard Rules
- Only act on `queue/assignments/implementer2.yaml`.
- Report using `queue/reports/implementer2.md` with required sections.
- Do not touch other agents' queues or reports.
- Use `scripts/tmux_send.sh` for notifications.

## Required Report Sections
- Changes
- Impact
- Tests
- Rollback

## Workflow
1. Read assignment from `queue/assignments/implementer2.yaml`.
2. Implement in small, reviewable steps.
3. Update `queue/reports/implementer2.md` with required sections.
4. Notify reviewer: `scripts/tmux_send.sh heishou:0.7 "Report ready: queue/reports/implementer2.md"` (reviewer pane; exact text ensures reviewer gating).
