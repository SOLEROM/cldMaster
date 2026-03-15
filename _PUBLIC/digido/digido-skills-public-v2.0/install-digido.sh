#!/bin/bash
# install-digido.sh — Global DiGido Skills Installer for Mac/Linux
# Connects your digido-skills to Antigravity + Claude Code globally
#
# Usage:
#   bash install-digido.sh              Install (connect skills globally)
#   bash install-digido.sh --uninstall  Remove global connections

# ============================================================================
# Colors
# ============================================================================
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
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
# Uninstall Mode
# ============================================================================

if [ "$1" = "--uninstall" ]; then
    echo ""
    echo -e "${CYAN}Removing DiGido global connections...${NC}"
    echo ""

    targets=(
        "$USER_HOME/.gemini/antigravity/skills:Antigravity Skills"
        "$USER_HOME/.gemini/antigravity/global_workflows:Antigravity Workflows"
        "$USER_HOME/.claude/skills:Claude Code Skills"
        "$USER_HOME/.claude/commands:Claude Code Commands"
    )

    for entry in "${targets[@]}"; do
        link="${entry%%:*}"
        name="${entry##*:}"
        if [ -L "$link" ]; then
            rm "$link"
            echo -e "  ${GREEN}Removed: $name${NC}"
        else
            echo -e "  ${YELLOW}Not found: $name - skipping${NC}"
        fi
    done

    echo ""
    echo -e "${GREEN}DiGido uninstalled. The skills source folder was NOT deleted.${NC}"
    echo ""
    exit 0
fi

# ============================================================================
# Install Mode
# ============================================================================

echo ""
echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  DiGido Skills — Global Installer${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""
echo -e "  ${GRAY}Source: $DIGIDO_HOME${NC}"
echo ""

# Validate source
if [ ! -d "$DIGIDO_HOME/.agent/skills" ]; then
    echo -e "${RED}ERROR: DiGido skills not found at: $DIGIDO_HOME${NC}"
    echo -e "${YELLOW}Make sure you run this script from the digido-skills folder.${NC}"
    echo ""
    exit 1
fi

# Define targets: link|source|name|parent_dirs
success_count=0
total_count=4

install_link() {
    local link="$1"
    local source="$2"
    local name="$3"
    shift 3
    local parent_dirs=("$@")

    # Create parent directories
    for dir in "${parent_dirs[@]}"; do
        if [ -n "$dir" ] && [ ! -d "$dir" ]; then
            mkdir -p "$dir"
        fi
    done

    # Handle existing symlink
    if [ -L "$link" ]; then
        rm "$link"
    elif [ -e "$link" ]; then
        # Folder exists and is not a symlink — ask user before copying
        if [ ! -d "$source" ]; then
            echo -e "  ${YELLOW}SKIP: Source not found for $name${NC}"
            echo -e "        ${GRAY}Expected: $source${NC}"
            echo ""
            return 1
        fi
        echo -e "  ${YELLOW}NOTICE: $link${NC}"
        echo -e "         ${YELLOW}already exists as a regular folder.${NC}"
        echo ""
        echo -e "  ${WHITE}We will copy new files into it (without overwriting existing ones).${NC}"
        echo -e "  ${WHITE}To update existing files later, run: bash update-digido.sh${NC}"
        echo ""
        read -p "  Proceed with copy for $name? (Y/N) " answer
        if [[ ! "$answer" =~ ^[Yy] ]]; then
            echo -e "  ${YELLOW}Skipped: $name${NC}"
            echo ""
            return 1
        fi
        local copied=0
        local skipped=0
        for file in "$source"/*; do
            [ -f "$file" ] || continue
            local basename="$(basename "$file")"
            if [ ! -e "$link/$basename" ]; then
                cp "$file" "$link/$basename"
                copied=$((copied + 1))
            else
                skipped=$((skipped + 1))
            fi
        done
        echo -e "  ${CYAN}COPY: $name${NC}"
        echo -e "        ${GRAY}New files added: $copied | Already existed (not overwritten): $skipped${NC}"
        echo -e "        ${GREEN}All files are now available.${NC}"
        echo -e "        ${YELLOW}To update existing files, run: bash update-digido.sh${NC}"
        success_count=$((success_count + 1))
        echo ""
        return 0
    fi

    # Verify source exists
    if [ ! -d "$source" ]; then
        echo -e "  ${YELLOW}SKIP: Source not found for $name${NC}"
        echo -e "        ${GRAY}Expected: $source${NC}"
        return 1
    fi

    # Create symlink
    if ln -s "$source" "$link" 2>/dev/null; then
        echo -e "  ${GREEN}OK: $name${NC}"
        echo -e "      ${GRAY}$link${NC}"
        echo -e "      ${GRAY}-> $source${NC}"
        success_count=$((success_count + 1))
    else
        echo -e "  ${RED}FAIL: $name${NC}"
        return 1
    fi
    echo ""
}

# Install Antigravity Skills
install_link \
    "$USER_HOME/.gemini/antigravity/skills" \
    "$DIGIDO_HOME/.agent/skills" \
    "Antigravity Skills" \
    "$USER_HOME/.gemini" "$USER_HOME/.gemini/antigravity"

# Install Antigravity Workflows
install_link \
    "$USER_HOME/.gemini/antigravity/global_workflows" \
    "$DIGIDO_HOME/.agent/workflows" \
    "Antigravity Workflows" \
    "$USER_HOME/.gemini" "$USER_HOME/.gemini/antigravity"

# Install Claude Code Skills
install_link \
    "$USER_HOME/.claude/skills" \
    "$DIGIDO_HOME/.agent/skills" \
    "Claude Code Skills" \
    "$USER_HOME/.claude"

# Install Claude Code Commands
install_link \
    "$USER_HOME/.claude/commands" \
    "$DIGIDO_HOME/.agent/workflows" \
    "Claude Code Commands" \
    "$USER_HOME/.claude"

# Summary
echo -e "${CYAN}========================================${NC}"
if [ "$success_count" -eq "$total_count" ]; then
    echo -e "  ${GREEN}Installation complete! ($success_count/$total_count)${NC}"
    echo ""
    echo -e "  ${WHITE}Next step:${NC}"
    echo -e "  ${WHITE}Open any project and tell the agent:${NC}"
    echo -e "  ${CYAN}\"What skills do you have?\"${NC}"
elif [ "$success_count" -gt 0 ]; then
    echo -e "  ${YELLOW}Partial installation ($success_count/$total_count)${NC}"
    echo -e "  ${YELLOW}Review warnings above.${NC}"
else
    echo -e "  ${RED}Installation failed (0/$total_count)${NC}"
    echo -e "  ${RED}Check the errors above.${NC}"
fi
echo -e "${CYAN}========================================${NC}"
echo ""
