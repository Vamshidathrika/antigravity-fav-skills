#!/usr/bin/env bash
set -euo pipefail

echo "============================================="
echo " Installing Antigravity Favorite Skills"
echo "============================================="

TARGET_DIR="$HOME/.gemini/config/skills"

echo "Creating target skills directory: $TARGET_DIR"
mkdir -p "$TARGET_DIR"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/skills"

if [ ! -d "$SKILLS_DIR" ]; then
  echo "Error: skills directory not found at $SKILLS_DIR"
  exit 1
fi

COUNT=$(ls -1 "$SKILLS_DIR" | wc -l | tr -d ' ')
echo "Installing $COUNT favorite skills to $TARGET_DIR..."

cp -R "$SKILLS_DIR"/* "$TARGET_DIR"/

echo ""
echo "Installation complete!"
echo "Successfully installed $COUNT skills to $TARGET_DIR"
echo "Antigravity will automatically index and load these skills on-demand."
