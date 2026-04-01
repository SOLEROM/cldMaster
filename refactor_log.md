# refactor_log.md

## Run: 2026-03-31 (incremental — README update)

### README Updates
- Root `README.md` fully rewritten: all 25 active folders now linked, organized into 5 sections (Getting Started, Configuration, Customization, Execution & Modes, Advanced)
- Removed stale plain-text "advanced features include" block
- Fixed residual stale link `./tips/repetiveErrors.md` (no longer present)

---

## Run: 2026-03-31

### Renames
- `tockenOptimization/` → `token_optimization/` (typo + camelCase fix)
- `paralle/` → `parallel/` (typo fix)
- `hooks/howtoGuide/` → `hooks/how_to_guide/` (camelCase fix)
- `rules/reademe.md` → `rules/README.md` (typo fix)
- `config/config-exmaple.md` → `config/config_example.md` (typo fix)
- `modes/plan_exmaple.md` → `modes/plan_example.md` (typo fix)
- `tips/repetiveErrors.md` → `tips/repetitive_errors.md` (typo + camelCase fix)

### Moves
- `configs/customCmds.md` → `config/custom_cmds.md` (merge configs/ into config/)
- `configs/permissions.md` → `config/permissions.md` (merge configs/ into config/)
- `configs/` removed (empty after merge)
- `keyboard.md` (root) → `cli/keyboard.md` (belongs with CLI docs)
- `usage.md` (root) → `cli/usage.md` (belongs with CLI docs)

### READMEs Created
- `actions/README.md`
- `cli/README.md`
- `config/README.md`
- `install/README.md`
- `modes/README.md`
- `tasks/README.md`

### README Updates (root README.md)
- Fixed broken link: `./modes/planMode.md` → `./modes/plan.md`
- Updated link: `./configs/customCmds.md` → `./config/custom_cmds.md`
- Updated link: `./configs/permissions.md` → `./config/permissions.md`

### Placeholders Marked
- `struct.md` at root — added TBD marker (3-line placeholder)

### Non-Markdown Files (preserved in place)
- `image.png` (root)
- `actions/image-3.png`
- `hooks/image-1.png` through `image-7.png`, `image.png`
- `hooks/how_to_guide/*.py`, `*.sh`
- `modes/image-1.png`, `modes/image.png`
- `media/assist1.png`
- `mcp/image-2.png`
- `sdk/image-4.png`
- `plugins/image.png`

### Ignored Folders (per .kmIgnoreFolderList)
- `lab1/`
- `lab2_hooks/`
- `_PUBLIC/`

### Skipped (non-KB)
- `media/` — 0% markdown files

### New Files Created
- `logicTree.md` (root)
- `refactor_log.md` (root)
