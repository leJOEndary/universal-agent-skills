#!/bin/bash
# Sync skills to Manus
# Note: Manus uses the same SKILL.md format - just point Manus to this repo or upload skills via UI

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "Manus uses the Agent Skills standard natively."
echo ""
echo "Options:"
echo "  1. Point Manus to this GitHub repo directly"
echo "  2. Upload skill folders via Manus web UI"
echo "  3. Use /YourSkillName in Manus to invoke"
echo ""
echo "Skills available in $REPO_DIR/skills:"
ls -1 "$REPO_DIR/skills"
