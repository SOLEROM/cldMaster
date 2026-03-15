# Documentation Initialization Guide

> **Purpose:** Preparing initial documentation for every Python project

---

## Why Documentation from the Start?

1. **Continuity** - In 2 weeks/month, easy to return to the project
2. **Quick onboarding** - The agent knows what happened in previous sessions
3. **Change tracking** - See how the project evolved
4. **Debugging** - Easy to find when a problem was introduced

---

## Two Mandatory Files

### 1. CHANGELOG.md
Track changes, additions, fixes

### 2. project_architecture.md
Project map - structure, technologies, processes

---

## Update Guidelines

### CHANGELOG.md
**When:** After every significant change

**What:** Additions, changes, fixes

**How:** Add under `[Unreleased]`, use categories: Added/Changed/Fixed/Removed

### project_architecture.md
**When:** 
- New module added
- Folder structure changed
- New library added
- Workflow modified

**What:** Everything that affects project understanding

**How:** Edit relevant sections, update date

---

## Integration with Workflow

### End of each work session:

1. **Agent updates:**
   - CHANGELOG.md with what was done
   - project_architecture.md if structural change

2. **Architect validates:**
   - Reads the updates
   - Ensures they're accurate
   - Approves commit to Git

3. **Next session:**
   - Agent reads the files
   - Understands the status
   - Continues from the right point

---

## Automation Prompt for Agent

```
Before starting work on this project:
1. Read CHANGELOG.md to understand recent changes
2. Read project_architecture.md to understand structure
3. Ask if anything is unclear

After completing work:
1. Update CHANGELOG.md under [Unreleased]:
   - List what was Added/Changed/Fixed/Removed
2. Update project_architecture.md if:
   - New modules created
   - Directory structure changed
   - New libraries added
   - Data flow modified
3. Commit both files with clear messages

This ensures continuity across sessions!
```

---

See template files in assets/:
- CHANGELOG-template.md
- project_architecture-template.md
