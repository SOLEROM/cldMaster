# Agent Setup Prompt - Automated Workflow

> **When to use:** When the architect chose the automated path

---

## Instruction for the Architect

Paste this instruction to the agent in Antigravity:

---

## SETUP PROMPT FOR ANTIGRAVITY AGENT

**Goal:** Prepare a clean Python development environment
we work ONLY ON VENE !

**Prerequisites:**
- Project folder is already open in Antigravity
- Python is installed on the system

---

### Steps to Execute:

#### 1. Create Virtual Environment
```bash
python -m venv venv
```

#### 2. Activate Virtual Environment
```bash
.\venv\Scripts\activate
```

**Note:** If activation fails due to PowerShell ExecutionPolicy, instruct the architect to run:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```
Then retry activation.

#### 3. Create requirements.txt

Based on the project needs [ARCHITECT: specify project type here], create `requirements.txt` with appropriate libraries.

**Common library categories:**
- Data processing: `pandas`, `numpy`, `openpyxl`
- File handling: `PyPDF2`, `python-docx`, `lxml`
- API/Web: `requests`, `flask`, `fastapi`
- Automation: `schedule`, `watchdog`
- AI/ML: `openai`, `anthropic`, `langchain`
- dashboards - streamlit, plotly
- data visualization - matplotlib, seaborn

if needed to search for updated or specified libreries according to architects prompt, use context 7. unless, just follow your knoweledge base.



#### 4. Install Dependencies
```bash
pip install -r requirements.txt
```

#### 5. Create .gitignore

Create `.gitignore` with Python-specific patterns:
```
# Virtual Environment
venv/
env/
ENV/

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python

# IDEs
.vscode/
.idea/
*.swp
*.swo

# Environment variables
.env
.env.local

# OS
.DS_Store
Thumbs.db

# Project specific
*.log
```

#### 6. Initialize Git
```bash
git init
```

#### 7. Create CHANGELOG.md

```markdown
# Changelog

## [Unreleased]

### Added
- Initial project setup
- Virtual environment configured
- Dependencies installed

---

**Format:** Keep CHANGELOG updated with every significant change.
**Structure:** [Version] - Date - Added/Changed/Fixed/Removed
```

#### 8. Create project_architecture.md

```markdown
# Project Architecture

## Overview
[Brief description of the project]

## Directory Structure
```
project-root/
├── venv/                 # Virtual environment (git-ignored)
├── src/                  # Source code
├── data/                 # Data files (if applicable)
├── docs/                 # Documentation
├── tests/                # Test files
├── requirements.txt      # Dependencies
├── .gitignore           # Git ignore rules
├── CHANGELOG.md         # Version history
└── README.md            # Project README
```

## Tech Stack
- Python [version]
- Libraries: [list from requirements.txt]

## Key Components
[To be filled as project develops]

## Data Flow
[To be filled as project develops]

---

**Note:** Update this file after every major development session.
```

---

### Validation Checklist:

After completing all steps, verify:

- [ ] Virtual environment is active (you should see `(venv)` in terminal prompt)
- [ ] `pip list` shows all required packages installed
- [ ] `.gitignore` file exists and covers Python patterns
- [ ] Git repository initialized (`git status` works)
- [ ] `CHANGELOG.md` created
- [ ] `project_architecture.md` created

**Report:**
List the directory structure using:
```bash
tree /F
```
Or manually list key files created.

---

## After Validation

Once setup is complete and validated, report to the architect:

"✅ Python environment setup complete!

Created:
- Virtual environment (venv)
- requirements.txt with [X] libraries
- .gitignore for Python
- Git repository initialized
- CHANGELOG.md
- project_architecture.md

Ready for development. Awaiting project specifications."

---

**Next Step:** The architect will provide the Master Prompt for the actual project work.
