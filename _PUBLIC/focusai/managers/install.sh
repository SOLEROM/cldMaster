#!/bin/bash
# Focus AI — Claude Code Manager Skills Bundle Installer (macOS / Linux)
SKILLS_DIR="$(cd "$(dirname "$0")/skills" && pwd)"
TARGET="$HOME/.claude/skills"
COUNT=0
ERRORS=0

echo ""
echo "=== Focus AI - Manager Skills Installer ==="
echo ""

mkdir -p "$TARGET"

for category_dir in "$SKILLS_DIR"/*/; do
  for skill_file in "$category_dir"skill-*.md; do
    [ -f "$skill_file" ] || continue
    skill_name=$(basename "$skill_file" .md | sed 's/^skill-//')
    dest="$TARGET/$skill_name"
    mkdir -p "$dest"
    cp "$skill_file" "$dest/SKILL.md"
    echo "  [OK] /$skill_name"
    COUNT=$((COUNT + 1))
  done
done

echo ""
echo "=================================================="
echo "Installed $COUNT skills to $TARGET"
[ "$ERRORS" -gt 0 ] && echo "$ERRORS errors — check output above"
echo ""
echo "Test: open any folder, run 'claude', type /strategic-plan"
echo ""
