#!/bin/bash
set -e

log() {
  echo "[heishou] $1"
}

if command -v apt-get >/dev/null 2>&1; then
  log "Installing tmux"
  sudo apt-get update
  sudo apt-get install -y tmux
elif command -v brew >/dev/null 2>&1; then
  log "tmux already available via Homebrew, install if needed"
  brew list tmux >/dev/null 2>&1 || brew install tmux
else
  log "tmux not installed. Install via your package manager."
fi

if ! command -v node >/dev/null 2>&1; then
  log "Node.js not found. Please install Node.js 20+ (nvm recommended)."
fi

log "Installing Codex CLI"
if command -v npm >/dev/null 2>&1; then
  npm i -g @openai/codex
else
  log "npm not found. Install Node.js to get npm."
fi

log "Setup complete"
