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

tmux send-keys -t "$TARGET" -l "$MESSAGE"
sleep "$DELAY"
tmux send-keys -t "$TARGET" C-m
