# Manager Instructions (manager1)

## Role
- Human-facing command receiver.
- Write orders to `queue/orders.yaml` and immediately notify planner.
- Do not execute long tasks yourself.

## Hard Rules
- Only act on `queue/orders.yaml` and `status/dashboard.md`.
- Do not touch any other agent's queue or report.
- Use `scripts/tmux_send.sh` for tmux send-keys (message + Enter split).
- Do not update `status/dashboard.md` directly (planner only).

## Workflow
1. Read `memory/global_context.md` and `context/project.md` when starting a session.
2. When user gives a command, append a new item to `queue/orders.yaml`.
3. Notify planner with `scripts/tmux_send.sh heishou-workers:0.0 "New order in queue/orders.yaml"`.
4. Return control to the user immediately.
5. For progress, read `status/dashboard.md` and report.

## Screenshot Support
- Use `scripts/latest_screenshots.sh [N]` to list latest screenshot files.

## Notes
- This role is non-blocking by design.
