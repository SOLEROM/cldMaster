#!/bin/bash
# Focus AI — Claude Code Skills Bundle Installer
# Installs all 50 skills to ~/.claude/skills/

set -e

SKILLS_DIR="$(cd "$(dirname "$0")/skills" && pwd)"
TARGET="$HOME/.claude/skills"
COUNT=0
ERRORS=0

echo ""
echo "🎯 Focus AI — Claude Code Skills Installer"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Ensure target exists
mkdir -p "$TARGET"

# Walk: skills/<category>/<skill-name>/skill-*.md
for category_dir in "$SKILLS_DIR"/*/; do
  category=$(basename "$category_dir")
  for skill_dir in "$category_dir"*/; do
    skill_name=$(basename "$skill_dir")
    skill_file=$(ls "$skill_dir"skill-*.md 2>/dev/null | head -1)
    if [ -z "$skill_file" ]; then
      echo "  ⚠️  Skipped (no skill file): $skill_name"
      ((ERRORS++)) || true
      continue
    fi
    dest="$TARGET/$skill_name"
    mkdir -p "$dest"
    cp "$skill_file" "$dest/SKILL.md"
    echo "  ✅ /$skill_name"
    ((COUNT++)) || true
  done
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Installed $COUNT skills to $TARGET"
if [ "$ERRORS" -gt 0 ]; then
  echo "⚠️  $ERRORS errors — check output above"
fi
echo ""
echo "Test it: open a project folder, run 'claude', then type /code-review"
echo ""
