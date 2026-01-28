#!/bin/bash
# Enforce two-step tmux send-keys: message then Enter.
set -e

if [ $# -lt 2 ]; then
  echo "Usage: $0 <target> <message>" >&2
  exit 1
fi

TARGET="$1"
shift
MESSAGE="$*"

# Optional delay to allow the target app to be ready (e.g., Codex TUI)
DELAY="${TMUX_SEND_DELAY:-0.15}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
SOCKET_DIR="${ROOT_DIR}/.tmux"
SOCKET_PATH="${SOCKET_DIR}/tmux-$(id -u)/default"

TMUX_CMD=(tmux)
if [ -S "$SOCKET_PATH" ]; then
  TMUX_CMD=(tmux -S "$SOCKET_PATH")
fi

"${TMUX_CMD[@]}" send-keys -t "$TARGET" -l "$MESSAGE"
sleep "$DELAY"
"${TMUX_CMD[@]}" send-keys -t "$TARGET" C-m
