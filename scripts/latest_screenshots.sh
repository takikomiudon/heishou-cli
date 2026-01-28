#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
SETTINGS_FILE="${ROOT_DIR}/config/settings.yaml"

COUNT=${1:-3}
if ! [[ "$COUNT" =~ ^[0-9]+$ ]]; then
  echo "Usage: $0 [N]" >&2
  exit 1
fi

if [ ! -f "$SETTINGS_FILE" ]; then
  echo "settings.yaml not found: $SETTINGS_FILE" >&2
  exit 1
fi

SCREENSHOT_PATH=$(grep "^  path:" "$SETTINGS_FILE" | awk '{print $2}' | sed 's/"//g')
if [ -z "$SCREENSHOT_PATH" ]; then
  echo "screenshot.path is not set in config/settings.yaml" >&2
  exit 1
fi

if [ ! -d "$SCREENSHOT_PATH" ]; then
  echo "screenshot.path does not exist: $SCREENSHOT_PATH" >&2
  exit 1
fi

ls -t "$SCREENSHOT_PATH" | head -n "$COUNT" | sed "s|^|${SCREENSHOT_PATH}/|"
