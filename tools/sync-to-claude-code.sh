#!/bin/bash
# Sync skills to Claude Code
# Claude Code can use this repo as a plugin marketplace

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "Claude Code Plugin Marketplace Setup"
echo ""
echo "Option 1: Register repo as marketplace (in Claude Code):"
echo "  /plugin marketplace add youssefelhady/universal-agent-skills"
echo ""
echo "Option 2: Install specific skill:"
echo "  /plugin install <skill-name>@universal-agent-skills"
echo ""
echo "Option 3: Copy to local .agents/skills:"

CLAUDE_CODE_SKILLS="${CLAUDE_CODE_SKILLS:-$HOME/.agents/skills}"
mkdir -p "$CLAUDE_CODE_SKILLS"

for skill_dir in "$REPO_DIR/skills"/*/; do
  skill_name=$(basename "$skill_dir")
  echo "  → $skill_name"
  cp -r "$skill_dir" "$CLAUDE_CODE_SKILLS/"
done

echo ""
echo "✓ Skills copied to $CLAUDE_CODE_SKILLS"
