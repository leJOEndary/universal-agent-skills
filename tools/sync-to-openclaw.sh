#!/bin/bash
# Sync skills from this repo to OpenClaw workspace

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OPENCLAW_SKILLS="${OPENCLAW_SKILLS:-$HOME/.openclaw/workspace/skills}"

echo "Syncing skills from $REPO_DIR/skills to $OPENCLAW_SKILLS"

mkdir -p "$OPENCLAW_SKILLS"

for skill_dir in "$REPO_DIR/skills"/*/; do
  skill_name=$(basename "$skill_dir")
  echo "  → $skill_name"
  cp -r "$skill_dir" "$OPENCLAW_SKILLS/"
done

echo "✓ Done. Restart OpenClaw gateway to pick up changes."
