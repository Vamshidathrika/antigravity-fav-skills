#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <path-to-skill-directory>"
  exit 1
fi

SKILL_PATH="$1"

if command -v skills-ref >/dev/null 2>&1; then
  skills-ref validate "$SKILL_PATH"
else
  echo "skills-ref command not found in PATH. Install via: uv tool install --force 'git+https://github.com/agentskills/agentskills.git#subdirectory=skills-ref'"
  exit 1
fi
