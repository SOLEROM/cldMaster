# Master Prompt Template for Antigravity Agent

> **When to use:** After Setup is complete, when starting actual project work

---

## Master Prompt Template

```
ANTIGRAVITY AGENT - PROJECT DEVELOPMENT PROMPT

==================================================
PROJECT OVERVIEW
==================================================

Goal: [What the project needs to do - one clear sentence]

Context: [Background - why needed, what problem being solved]

==================================================
TECH STACK
==================================================

Python Version: [e.g., 3.11+]

Libraries:
- [library-name]: [version] - [what it does specifically in this project]
- [library-name]: [version] - [what it does specifically in this project]
...

==================================================
FILE STRUCTURE
==================================================

```
project-root/
├── src/
│   ├── main.py           # [description]
│   ├── module_a.py       # [description]
│   └── module_b.py       # [description]
├── data/                 # [if relevant]
├── tests/                # [if relevant]
└── [other files]
```

Files to create/edit:
1. [file-path] - [purpose]
2. [file-path] - [purpose]
...

==================================================
STEP-BY-STEP LOGIC
==================================================

Phase 1: [first step]
- Step 1.1: [action]
- Step 1.2: [action]
- Expected output: [what should be received]

Phase 2: [second step]
- Step 2.1: [action]
- Step 2.2: [action]
- Expected output: [what should be received]

[Continue for all phases...]

==================================================
SAFETY & BEST PRACTICES
==================================================

Environment Variables:
- Create .env file for: [API keys, secrets, etc.]
- Never commit .env (already in .gitignore)

Error Handling:
- Use try-except blocks for [specific cases]
- Log errors to [log file or console]

Code Quality:
- Follow PEP 8 style guide
- Add docstrings to functions
- Use type hints where appropriate

==================================================
LOGGING & DOCUMENTATION
==================================================

Update on Every Significant Change:
1. CHANGELOG.md - document what was added/changed/fixed
2. project_architecture.md - update if structure changes

Create development log:
- File: `dev_log.md`
- Track: decisions made, bugs encountered, solutions found
- Purpose: Makes debugging and continuity easier

==================================================
TESTING & VALIDATION
==================================================

Test Cases:
1. [Test scenario 1] - Expected: [result]
2. [Test scenario 2] - Expected: [result]
...

Validation Steps:
- [ ] Code runs without errors
- [ ] Output matches expected results
- [ ] Edge cases handled
- [ ] Documentation updated

==================================================
NEXT STEPS AFTER COMPLETION
==================================================

1. Run full test suite
2. Update CHANGELOG.md
3. Update project_architecture.md
4. Report completion with:
   - What was built
   - Any challenges encountered
   - Suggested next steps

==================================================
```

---

## Usage Notes

1. **Adapt to project** - This is a template, fill in specific details
2. **Be clear** - The more detailed the prompt, the better the result
3. **Update as needed** - If something changes along the way, update the prompt
4. **Maintain structure** - The agent is used to this format

---

See full example in specification file (lines 800-939).
