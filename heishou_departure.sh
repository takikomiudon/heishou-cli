#!/bin/bash
# heishou daily startup
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

SETUP_ONLY=false

while [[ $# -gt 0 ]]; do
  case $1 in
    -s|--setup-only)
      SETUP_ONLY=true
      shift
      ;;
    -h|--help)
      echo "Usage: ./heishou_departure.sh [-s|--setup-only]"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

log() {
  echo "[heishou] $1"
}

TMUX_SEND="${SCRIPT_DIR}/scripts/tmux_send.sh"
CODEX_ROOT="${SCRIPT_DIR}/.codex"
if [ ! -d "$CODEX_ROOT" ]; then
  CODEX_ROOT="${SCRIPT_DIR}/codex_home"
fi

# Use a workspace-local tmux socket so agents in sandbox can access it.
TMUX_SOCKET_DIR="${SCRIPT_DIR}/.tmux"
mkdir -p "$TMUX_SOCKET_DIR"
export TMUX_TMPDIR="$TMUX_SOCKET_DIR"

# Kill existing sessions
log "Cleaning old tmux sessions"
tmux kill-session -t heishou 2>/dev/null || true
tmux kill-session -t heishou-workers 2>/dev/null || true

# Reset queues
log "Resetting queues"
cat > ./queue/orders.yaml << 'ORDERS'
queue: []
ORDERS

for role in navigator1 navigator2 implementer1 implementer2 implementer3 implementer4 reviewer tester; do
  cat > "./queue/assignments/${role}.yaml" << EOF_ASSIGN
agent: ${role}
task_id: null
description: null
target_path: null
status: idle
created_at: ""
EOF_ASSIGN
 done

for role in navigator1 navigator2 reviewer tester; do
  cat > "./queue/reports/${role}.md" << EOF_REPORT
# Report

- Agent: ${role}
- Task ID: 
- Status: idle
- Timestamp: 

## Summary

## Details

## Blockers

## Next

EOF_REPORT
 done

for role in implementer1 implementer2 implementer3 implementer4; do
  cat > "./queue/reports/${role}.md" << EOF_IMPL
# Implementer Report

- Agent: ${role}
- Task ID: 
- Status: idle
- Timestamp: 

## Changes

## Impact

## Tests

## Rollback

## Notes

EOF_IMPL
 done

# Initialize dashboard
log "Initializing dashboard"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M")
cat > ./status/dashboard.md << EOF_DASH
# Dashboard

Last Updated: ${TIMESTAMP}

## In Progress
| Agent | Task | Status | Next |
|------|------|--------|------|

## Blocked
| Agent | Task | Blocker | Next |
|------|------|---------|------|

## Done
| Agent | Task | Result | When |
|------|------|--------|------|

## Questions / Approvals
- None
EOF_DASH

# Create workers session (3x3 grid)
log "Creating heishou-workers session"
tmux new-session -d -s heishou-workers -n agents

tmux split-window -h -t "heishou-workers:0"
tmux split-window -h -t "heishou-workers:0"

tmux select-pane -t "heishou-workers:0.0"
tmux split-window -v
tmux split-window -v

tmux select-pane -t "heishou-workers:0.3"
tmux split-window -v
tmux split-window -v

tmux select-pane -t "heishou-workers:0.6"
tmux split-window -v
tmux split-window -v

PANE_TITLES=("planner1" "navigator1" "navigator2" "implementer1" "implementer2" "implementer3" "implementer4" "reviewer" "tester")

for i in {0..8}; do
  tmux select-pane -t "heishou-workers:0.$i" -T "${PANE_TITLES[$i]}"
  "$TMUX_SEND" "heishou-workers:0.$i" "cd ${SCRIPT_DIR} && clear"
 done

# Create manager session
log "Creating heishou session"
tmux new-session -d -s heishou -n manager
"$TMUX_SEND" "heishou:0.0" "cd ${SCRIPT_DIR} && clear"

# Launch codex unless setup-only
if [ "$SETUP_ONLY" = false ]; then
  log "Launching Codex CLI"

  "$TMUX_SEND" "heishou:0.0" "CODEX_HOME=${CODEX_ROOT}/manager codex --sandbox read-only --ask-for-approval on-request"

  "$TMUX_SEND" "heishou-workers:0.0" "CODEX_HOME=${CODEX_ROOT}/planner codex --sandbox workspace-write --ask-for-approval on-request"
  "$TMUX_SEND" "heishou-workers:0.1" "CODEX_HOME=${CODEX_ROOT}/navigator1 codex --sandbox read-only --ask-for-approval on-request"
  "$TMUX_SEND" "heishou-workers:0.2" "CODEX_HOME=${CODEX_ROOT}/navigator2 codex --sandbox read-only --ask-for-approval on-request"
  "$TMUX_SEND" "heishou-workers:0.3" "CODEX_HOME=${CODEX_ROOT}/implementer1 codex --sandbox workspace-write --ask-for-approval on-request"
  "$TMUX_SEND" "heishou-workers:0.4" "CODEX_HOME=${CODEX_ROOT}/implementer2 codex --sandbox workspace-write --ask-for-approval on-request"
  "$TMUX_SEND" "heishou-workers:0.5" "gemini --sandbox --approval-mode default"
  "$TMUX_SEND" "heishou-workers:0.6" "CODEX_HOME=${CODEX_ROOT}/implementer4 gemini --sandbox --approval-mode default"
  "$TMUX_SEND" "heishou-workers:0.7" "CODEX_HOME=${CODEX_ROOT}/reviewer codex --sandbox read-only --ask-for-approval on-request"
  "$TMUX_SEND" "heishou-workers:0.8" "CODEX_HOME=${CODEX_ROOT}/tester codex --sandbox workspace-write --ask-for-approval on-request"

  sleep 1
  "$TMUX_SEND" "heishou:0.0" "Read instructions/manager.md, declare readiness, then wait for orders."
  "$TMUX_SEND" "heishou-workers:0.0" "Read instructions/planner.md, declare readiness, then wait for orders."
  "$TMUX_SEND" "heishou-workers:0.1" "Read instructions/navigator1.md, declare readiness, then wait for assignments."
  "$TMUX_SEND" "heishou-workers:0.2" "Read instructions/navigator2.md, declare readiness, then wait for assignments."
  "$TMUX_SEND" "heishou-workers:0.3" "Read instructions/implementer1.md, declare readiness, then wait for assignments."
  "$TMUX_SEND" "heishou-workers:0.4" "Read instructions/implementer2.md, declare readiness, then wait for assignments."
  "$TMUX_SEND" "heishou-workers:0.5" "Read instructions/implementer3.md, declare readiness, then wait for assignments."
  "$TMUX_SEND" "heishou-workers:0.6" "Read instructions/implementer4.md, declare readiness, then wait for assignments."
  "$TMUX_SEND" "heishou-workers:0.7" "Read instructions/reviewer.md, declare readiness, then wait for assignments."
  "$TMUX_SEND" "heishou-workers:0.8" "Read instructions/tester.md, declare readiness, then wait for assignments."
fi

log "Done"
