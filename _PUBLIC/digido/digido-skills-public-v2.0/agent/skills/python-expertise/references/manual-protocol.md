# Python Environment Setup - Manual Protocol

> **When to use:** When the architect chose the manual path

---

## Preliminary Step - Instructions for the Architect

**Most important!** Click 'Open Folder' to create a new folder in the appropriate location, which will serve as the project folder.

*(This assumes starting from scratch. If there's already a running project and help is needed, no new project folder is required).*

---

## Step 1: Setting Up Virtual Environment

When working with tools like Python, preparations are required:
- Virtual environment
- Library installation
- .gitignore file preparation

**The architect does this manually. Not the agent.** To ensure accuracy.

### 1.1 Creating the Virtual Environment

**Installation command:**
```bash
python -m venv venv
```

**Command to enter the virtual environment:**
```bash
.\venv\Scripts\activate
```

### 1.2 Solving PowerShell Issues (if needed)

Sometimes the virtual environment doesn't work without a PowerShell command.

**If needed**, instruct the architect to run PowerShell with this command:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

###

 1.3 Confirming the Environment is Active

**⚠️ CRITICAL:** Only after you've confirmed with the architect that the virtual environment is **active**, proceed to the library installation step.

**Request confirmation:**  
"Confirm that you see the virtual environment is active (should see `(venv)` at the beginning of the line) before moving to the installation step!"

---

## Step 2: Installing Libraries

### 2.1 Creating requirements.txt

Provide the architect with content to paste into a ready `requirements.txt` file with all the libraries that need to be installed.

**Instruct them:**
1. Create the `requirements.txt` file
2. Add all required libraries
3. Install the libraries using the installation command

### 2.2 Installing the Libraries

**Note:** You can give the agent the instruction to install the libraries (if it has permissions, this will make it easier for the architect), otherwise, instruct the architect how to install them.

**Always through requirements.txt.**

Your (and the agent's) role is to guide proper installation.

---

## Step 3: Setting Up Backups (Git)

The architect is new to coding, so explain how to do this with Source Control.

### 3.1 Checking Git Installation

**⚠️ Important:** Ask the architect if Git is installed before you start giving Git instructions.

If not installed:
- Direct them to: https://git-scm.com/install/windows
- Instruct how to install the extension so it's available in Antigravity
- **Reminder:** After installation, they need to connect to this tool. You are responsible for instructing them.

### 3.2 Initializing Git

After the tool is ready, remind them every time to do this action to avoid losing valuable information:

```bash
git init
```

---

## Step 4: Creating .gitignore

Create a `.gitignore` file tailored for Python (see `assets/.gitignore-template`).

---

## Step 5: Preparing Initial Documentation

### 5.1 CHANGELOG.md

Create an empty CHANGELOG.md file, ready for updates (see `assets/CHANGELOG-template.md`).

### 5.2 project_architecture.md

Create a project_architecture.md file with initial structure (see `assets/project_architecture-template.md`).

**Importance:** In two weeks when the architect enters the project and activates the agent, the "onboarding" will be quick and efficient.

---

## Step 6: Planning (The Blueprint)

**Only after you confirm with the architect that the environment is ready for work, only after the preparations, move to the next step!**

**Don't rush ahead. Step by step.**  
Finish one step and only then move forward.

After selecting the stack, a "Master Prompt" must be generated for the AI agent.

The prompt should be in **technical English** and use a defined structure:

### Master Prompt Structure:

```
Goal: What are we building?
Tech Stack: Libraries and specific versions.
File Structure: Which files to create/edit.
Step-by-Step Logic: Pseudocode or detailed instructions.
Safety: Instructions regarding .env and .gitignore files.
Logging: Create an md file for error logging and activity tracking to simplify the development process.
```

*(See `references/antigravity-master-prompt.md` for detailed template)*

---

## ✅ Summary - Moving to the Next Step

After completing all steps:
1. ✅ Folder initialized
2. ✅ venv active
3. ✅ Libraries installed
4. ✅ Git ready
5. ✅ .gitignore exists
6. ✅ CHANGELOG + project_architecture ready
7. ✅ Master Prompt created

**Now you can start working with the agent!**

---

## 🔄 Handoff

- **Errors during work** → debugging-expert
- **Creating Portable App** → portable-app-creator
