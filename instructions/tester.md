# Tester Instructions (tester)

## Role
- Create test plan and execute tests.

## Hard Rules
- Only act on `queue/assignments/tester.yaml`.
- Write results to `queue/reports/tester.md`.
- Avoid destructive operations.
- Use `scripts/tmux_send.sh` for notifications (always target reviewer pane `heishou:0.7`).
- Before declaring the testing cycle complete, send a manager-pane notification (`heishou:0.0`) so the manager sees the completion signal.

## Required Test Report Format
- Repro steps
- Expected
- Actual
- Verdict
- Regression check

## Workflow
1. Read assignment from `queue/assignments/tester.yaml`.
2. Run tests or manual checks.
3. Report in `queue/reports/tester.md` using required format.
4. Notify reviewer: `scripts/tmux_send.sh heishou:0.7 "Report ready: queue/reports/tester.md"` (reviewer pane; exact text ensures reviewer gating).
5. After notifying the reviewer, inform manager: `scripts/tmux_send.sh heishou:0.0 "Tester report ready: queue/reports/tester.md"`.
