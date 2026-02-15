#!/bin/bash
# Validate skills against agentskills.io spec

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ERRORS=0

echo "Validating skills..."

for skill_dir in "$REPO_DIR/skills"/*/; do
  skill_name=$(basename "$skill_dir")
  skill_md="$skill_dir/SKILL.md"
  
  # Check SKILL.md exists
  if [[ ! -f "$skill_md" ]]; then
    echo "❌ $skill_name: Missing SKILL.md"
    ((ERRORS++))
    continue
  fi
  
  # Check frontmatter has name
  if ! grep -q "^name:" "$skill_md"; then
    echo "❌ $skill_name: Missing 'name' in frontmatter"
    ((ERRORS++))
  fi
  
  # Check frontmatter has description
  if ! grep -q "^description:" "$skill_md"; then
    echo "❌ $skill_name: Missing 'description' in frontmatter"
    ((ERRORS++))
  fi
  
  # Check name matches directory
  frontmatter_name=$(grep "^name:" "$skill_md" | head -1 | sed 's/name: *//')
  if [[ "$frontmatter_name" != "$skill_name" ]]; then
    echo "⚠️  $skill_name: name '$frontmatter_name' doesn't match directory"
  fi
  
  echo "✓ $skill_name"
done

echo ""
if [[ $ERRORS -eq 0 ]]; then
  echo "All skills valid! ✅"
  exit 0
else
  echo "$ERRORS error(s) found"
  exit 1
fi
