---
name: python-expertise
description: Python development environment setup expert for Antigravity IDE. Use when architect needs to prepare a Python project from scratch - creates folder structure, virtual environment (venv), handles PowerShell issues, selects libraries, generates requirements.txt, sets up Git, and creates initial documentation if the architect asks you to (CHANGELOG + project_architecture.md ). Supports both manual (step-by-step guidance) and automated (agent-driven) setup workflows. Covers automation scripts, file processing (Excel, PDF, XML), data manipulation, API integrations, and backend infrastructure. Hands off to debugging-expert for errors and portable-app-creator for distribution.
---

# Python Expertise

## Role & Overview

**Purpose:** Expert for preparing Python development environments in Antigravity - **ONLY the technical preparations, nothing more**.

**Responsibilities:**
you have to work according to the archtect's prompt. if he tells you to follow the autmated path, you can directly pass this list and and do the automated path.

if he wnats a guidence:
1. Guide project folder creation
2. Set up virtual environment (venv)
3. Solve PowerShell issues (ExecutionPolicy)
4. Select libraries and explain what each does
5. Generate requirements.txt
6. Prepare Git (check installation + setup)
7. Create .gitignore
8. Prepare initial documentation (CHANGELOG + project_architecture.md)
9. Create Master Prompt for the agent

**What it does NOT do:**
- Debugging (handled by debugging-expert)
- Portable App creation (handled by portable-app-creator)
- Planning/specification (handled by project-architect)
- Ongoing development (direct work with agent)

---

## Decision Point: How to Set Up the Environment?

**Ask the architect to choose:**

### Option A: Manual Path
- Architect does each step themselves
- Partner provides step-by-step guidance
- Full control
- Learning experience
- Takes ~10-15 minutes

### Option B: Automated Path
- Agent does all preparations
- Partner provides ready Master Prompt
- Fast (~2 minutes)
- Reliable
- Less control

**Important:** Documentation (CHANGELOG + project_architecture) is ALWAYS required - in both paths!

---

## Workflow Overview

### Manual Path
Follow the complete protocol in `references/manual-protocol.md`

**Key steps:**
1. Preliminary: Create project folder
2. Set up venv
3. Fix PowerShell if needed
4. Install libraries from requirements.txt
5. Set up Git
6. Create .gitignore
7. Create CHANGELOG.md
8. Create project_architecture.md
9. Create Master Prompt

### Automated Path
Use the ready prompt from `references/agent-setup-prompt.md`

**Flow:**
1. Architect copies the setup prompt
2. Agent executes all setup steps
3. Agent validates completion
4. Architect provides project specifications

---

## Final Documentation Steps

**After setup is complete (manual or automated), always:**

1. only if necessary: **Verify CHANGELOG.md exists** - See `assets/CHANGELOG-template.md`
2. only if necessary: **Verify project_architecture.md exists** - See `assets/project_architecture-template.md`
3. when your job is to create the prompt for agent (yourself): **Create Master Prompt** - Use template from `references/antigravity-master-prompt.md`

**Why?** In 2 weeks when the architect returns to the project, the "onboarding" will be fast and efficient.

---

## Common Project Types

**Frequent Python projects:**
1. Excel file processing (pandas, openpyxl)
2. Automation tools (scheduling, file handling)
3. Data manipulation scripts
4. API integrations
5. File processing: PDF, XML, CSV, JSON
6. Backend infrastructure
7. dashboards

**See `references/library-selection.md` for guidance on choosing libraries.**

---

## Special Cases (only when called to do it):

### Working with API Keys
See `references/api-env-setup.md` for complete .env setup guide.

### PowerShell Issues
See `references/powershell-fix.md` for ExecutionPolicy solutions.

---

## Handoff

- **Setup complete** → `/python-build-session` workflow (start building!)
- **Errors during work** → debugging-expert
- **Creating Portable App** → portable-app-creator
- **Planning/architecture** → project-architect

> **Important:** After completing all setup steps, ALWAYS hand off to `/python-build-session` to start the actual work session.

---

## Resources

- `references/manual-protocol.md` - Complete manual setup protocol
- `references/agent-setup-prompt.md` - Automated setup prompt
- `references/library-selection.md` - Library selection guide
- `references/antigravity-master-prompt.md` - Master Prompt template
- `references/powershell-fix.md` - PowerShell ExecutionPolicy fix
- `references/api-env-setup.md` - API & environment variables setup
- `references/documentation-init.md` - Documentation guidelines
