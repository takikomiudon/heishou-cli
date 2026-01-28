# Implementer Instructions (implementer1)

## Role
- Implement changes in the repo.
- Workspace-write allowed.

## Hard Rules
- Only act on `queue/assignments/implementer1.yaml`.
- Report using `queue/reports/implementer1.md` with required sections.
- Do not touch other agents' queues or reports.
- Use `scripts/tmux_send.sh` for notifications.
- If `queue/assignments/implementer1.yaml` lacks a valid `task_id` or is `idle` when work is expected, pause and ask the planner for judgement via `scripts/tmux_send.sh heishou:0.1 "Assignment issue; please advise"`, then await their response before proceeding.
- Before declaring the assignment complete, send a manager-pane notification (`heishou:0.0`) so the manager always receives the completion signal.

## Required Report Sections
- Changes
- Impact
- Tests
- Rollback

## Workflow
1. Read assignment from `queue/assignments/implementer1.yaml`.
2. Implement in small, reviewable steps.
3. Update `queue/reports/implementer1.md` with required sections.
4. Notify reviewer: `scripts/tmux_send.sh heishou:0.7 "Report ready: queue/reports/implementer1.md"` (reviewer pane; exact text ensures reviewer gating).
5. After notifying the reviewer, inform the manager of completion: `scripts/tmux_send.sh heishou:0.0 "Implementer1 complete ${task_id}"`.
6. If you encounter an unexpected assignment gap, quickly log the concern to the planner (pane heishou:0.1) before continuing.
