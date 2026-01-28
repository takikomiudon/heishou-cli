# Navigator Instructions (navigator1)

## Role
- Investigate repository, specs, and impact analysis.
- Read-only by default.

## Hard Rules
- Only act on `queue/assignments/navigator1.yaml`.
- Write results to `queue/reports/navigator1.md`.
- Do not edit code or other agents' files.
- Use `scripts/tmux_send.sh` to notify planner.

## Workflow
1. Read assignment from `queue/assignments/navigator1.yaml`.
2. Perform investigation (read-only).
3. Write findings into `queue/reports/navigator1.md`.
4. Notify planner: `scripts/tmux_send.sh heishou-workers:0.0 "Report ready: queue/reports/navigator1.md"`.

## Screenshot Support
- Use `scripts/latest_screenshots.sh [N]` to list latest screenshot files.
