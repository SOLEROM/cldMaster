#!/bin/bash
# update-digido.sh — Update DiGido Skills & Workflows (Mac/Linux)
# Copies files from source INTO existing folders, OVERWRITING existing files.
# Use this after install-digido.sh when folders were copied (not symlinks).
#
# Usage:
#   bash update-digido.sh

# ============================================================================
# Colors
# ============================================================================
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
WHITE='\033[1;37m'
NC='\033[0m'

# ============================================================================
# Configuration
# ============================================================================

DIGIDO_HOME="$(cd "$(dirname "$0")" && pwd)"
USER_HOME="$HOME"

# ============================================================================
# Update
# ============================================================================

echo ""
echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  DiGido Skills — Update${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""
echo -e "  ${WHITE}This will overwrite all DiGido files that have the same name${NC}"
echo -e "  ${WHITE}in the target folders with the latest versions from source.${NC}"
echo -e "  ${WHITE}Your own custom files (different names) will NOT be touched.${NC}"
echo ""
read -p "  Proceed? (Y/N) " answer
if [[ ! "$answer" =~ ^[Yy] ]]; then
    echo ""
    echo -e "  ${YELLOW}Update cancelled.${NC}"
    echo ""
    exit 0
fi
echo ""

updated_total=0

update_target() {
    local dest="$1"
    local source="$2"
    local name="$3"

    # Skip if destination doesn't exist
    if [ ! -d "$dest" ]; then
        echo -e "  ${YELLOW}SKIP: $name - destination not found${NC}"
        echo -e "        ${GRAY}Run bash install-digido.sh first.${NC}"
        echo ""
        return
    fi

    # Skip symlinks — they auto-update
    if [ -L "$dest" ]; then
        echo -e "  ${GREEN}OK: $name - symlink (auto-updates, nothing to do)${NC}"
        echo ""
        return
    fi

    # Skip if source doesn't exist
    if [ ! -d "$source" ]; then
        echo -e "  ${YELLOW}SKIP: $name - source not found${NC}"
        echo ""
        return
    fi

    # Copy files, overwriting existing ones from source
    local updated=0
    local added=0
    for file in "$source"/*; do
        [ -f "$file" ] || continue
        local basename="$(basename "$file")"
        if [ -e "$dest/$basename" ]; then
            updated=$((updated + 1))
        else
            added=$((added + 1))
        fi
        cp "$file" "$dest/$basename"
    done
    echo -e "  ${GREEN}UPDATED: $name${NC}"
    echo -e "           ${GRAY}Files overwritten: $updated | New files added: $added${NC}"
    updated_total=$((updated_total + updated + added))
    echo ""
}

update_target "$USER_HOME/.gemini/antigravity/skills"           "$DIGIDO_HOME/.agent/skills"    "Antigravity Skills"
update_target "$USER_HOME/.gemini/antigravity/global_workflows" "$DIGIDO_HOME/.agent/workflows" "Antigravity Workflows"
update_target "$USER_HOME/.claude/skills"                       "$DIGIDO_HOME/.agent/skills"    "Claude Code Skills"
update_target "$USER_HOME/.claude/commands"                     "$DIGIDO_HOME/.agent/workflows" "Claude Code Commands"

# Summary
echo -e "${CYAN}========================================${NC}"
if [ "$updated_total" -gt 0 ]; then
    echo -e "  ${GREEN}Update complete! ($updated_total files processed)${NC}"
else
    echo -e "  ${YELLOW}Nothing to update.${NC}"
fi
echo -e "${CYAN}========================================${NC}"
echo ""
