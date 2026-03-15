# קטלוג Skills — מידע מלא לפי קטגוריה

> נוצר אוטומטית על ידי `build-catalog.py` — 32 skills, 30 workflows
> לעדכון: `python scripts/build-catalog.py`

## תכנון ואסטרטגיה
| Skill | מה עושה |
|-------|---------|
| **architect-mirror** | Reflects project status throughout the build — what's done, what's in progress, what's blocked, and whether the project is drifting from the plan. Updates ARCHITECTURE.md and STATE.md. The user's "where are we?" answer. |
| **executor** | Executes digido plans with atomic commits, deviation handling, checkpoint protocols, and state management |
| **plan-checker** | Validates plans before execution to catch issues early |
| **Planner** | Creates executable phase plans with task breakdown, dependency analysis, and goal-backward verification |
| **python-executor** | Executes Python project tasks with Deviation Rules (4 levels), Need-to-Know context loading, checkpoint protocols, venv management, and state tracking. The engine that turns plans into working code. |
| **user-explainer** | Reflects to the user — in Hebrew, in plain language — what is happening, why, what's next, and if there's risk. Activated before and after every significant action. The user doesn't read code — they read your explanations. |

## ביצוע
| Skill | מה עושה |
|-------|---------|
| **blueprint-writer** | Creates structured blueprint prompts for code agents. Takes logic, insights, or investigation conclusions and produces a formatted technical brief (Goal, Stack, File Structure, Step-by-step Logic, Safety, Changelog) that the architect can hand off to a code agent for execution. |
| **debug-logger** | Smart logging implementation for Python code. Embeds structured, emoji-coded log messages throughout code during development — entry/exit points, API calls, retries, errors. Ensures every function tells its story. |
| **mcp-builder** | Guide for creating high-quality MCP (Model Context Protocol) servers that enable LLMs to interact with external services through well-designed tools. Use when building MCP servers to integrate external APIs or services, whether in Python (FastMCP) or Node/TypeScript (MCP SDK). |
| **skill-advisor** | Technical partner guide for non-technical users of the digido system. Use when a user needs help deciding which digido skills, workflows, or slash commands to use for their project. Activated when users ask things like "what should I do?", "how do I start?", "which command?", "I want to build X", or seem unsure about the right digido workflow for their situation. |
| **streamlit-updated-versions** | Comprehensive guide for using the latest Streamlit features and best practices. Use when working with Streamlit applications and need information about modern features like st.fragment, st.dialog, st.navigation, st.connection, st.cache_data, st.cache_resource, or when upgrading from older Streamlit versions. Also use when building new Streamlit apps to ensure best practices are followed. |
| **verifier** | Validates implemented work against spec requirements with empirical evidence |

## אימות ובדיקות
| Skill | מה עושה |
|-------|---------|
| **empirical-validation** | Requires proof before marking work complete — no "trust me, it works |
| **python-debugger** | Systematic Python debugging with hypothesis testing, 3-Strike Rule, Circular Detection, and persistent state tracking. Classifies Python errors by type, investigates root causes, and knows when to stop. |
| **python-validator** | Proves that Python code works — don't say it, show it. Runs pytest, smoke tests, import checks, and output comparison. If there are no tests, creates them. Never marks a task complete without empirical evidence. |

## דיבוג ותיקון
| Skill | מה עושה |
|-------|---------|
| **advice-diagnose** | Advisory and diagnostic partner for the architect. Provides analysis, advice, and diagnosis without writing code or files. Reads files and uses tools as needed to give informed, professional guidance. |
| **debugger** | Systematic debugging with persistent state and fresh context advantages |
| **error-handling** | Critical error handling protocol. Ensures systematic investigation before any fix — understanding the full picture, checking affected files, and avoiding breaking other parts of the project. Guides the architect through a safe, step-by-step error resolution process. |
| **ongoing-project** | Protocol for working on existing projects. Refreshes context from status files and project structure, investigates affected files step-by-step, and ensures a clear picture before making changes. Minimizes errors by systematic investigation before action. |
| **python-professional-setup** | Python development environment setup expert for Antigravity IDE. Use when architect needs to prepare a Python project from scratch - creates folder structure, virtual environment (venv), handles PowerShell issues, selects libraries, generates requirements.txt, sets up Git, and creates initial documentation if the architect asks you to (CHANGELOG + project_architecture.md ). Supports both manual (step-by-step guidance) and automated (agent-driven) setup workflows. Covers automation scripts, file processing (Excel, PDF, XML), data manipulation, API integrations, and backend infrastructure. Hands off to debugging-expert for errors and portable-app-creator for distribution. |

## מיפוי וניתוח
| Skill | מה עושה |
|-------|---------|
| **codebase-mapper** | Analyzes existing codebases to understand structure, patterns, and technical debt |
| **new-project** | Guides the architect through starting a new project — creates specifications using the specifications skill, recommends the right workflows via skill-advisor, and sets up the project foundation. |
| **python-codebase-mapper** | Scans and maps Python projects — structure, dependencies, imports, class hierarchy, project type, virtual environment, and configuration. Produces ARCHITECTURE.md and STACK.md. Works on existing projects and new ones. |

## כלים מיוחדים
| Skill | מה עושה |
|-------|---------|
| **context7-integration** | Decision rules for when to look up external documentation and when not to. Prevents unnecessary context pollution from doc lookups, while ensuring the agent doesn't guess when real docs are needed. Uses Context7 MCP for library resolution and doc queries. |
| **digimate-brand-html-files** | Creates beautifully designed, Digimate-branded HTML files for quotations, lesson summaries, protocols, and other formal documents. Use when the user requests to "create a quotation," "summarize a lesson as HTML," or "generate a branded document" in the Digimate style. |
| **firebase-app-deployment-protocol** | Step-by-step protocol for deploying React/Vite applications to a NEW Firebase project. Use this skill when the user wants to: (1) Connect an existing React/Vite app to Firebase Firestore, (2) Deploy an app to Firebase Hosting, (3) Migrate from LocalStorage to Firestore, (4) Set up a new Firebase project from scratch. This is a GUIDED PROTOCOL - the agent walks the user through each step, waits for user actions in Firebase Console, then completes the code changes. |
| **html-presentation-creator** | Creates beautiful, designed HTML presentations for non-technical users based on content and color preferences. |
| **rag-worker** | Cloud-Native RAG system using Google Gemini Flash 1.5 via the modern google-genai SDK. Ingests documents into local Qdrant Vector DB but performs embedding and generation in the cloud. |
| **youtube-meta** | מתודולוגיה וזרימת עבודה ליצירת מטא-דאטה אופטימלי ליוטיוב (כותרות, תיאורים, תגיות) המותאמת לאלגוריתמים של 2026. השתמש ב-skill זה כאשר המשתמש מבקש ליצור כותרות, תיאור, או אסטרטגיה לסרטון יוטיוב. |

## תקשורת ותחזוקה
| Skill | מה עושה |
|-------|---------|
| **context-health-monitor** | Monitors context complexity and triggers state dumps before quality degrades |
| **skill-creator** | Guide for creating effective skills. This skill should be used when users want to create a new skill (or update an existing skill) that extends Claude's capabilities with specialized knowledge, workflows, or tool integrations. |

## הרחבת המערכת
| Skill | מה עושה |
|-------|---------|
| **specifications** | Creates clear, professional specifications for projects and tasks. For new projects, runs a full specification process with deep research and vision clarification. For ongoing projects, breaks down tasks into milestones, tasks, and phases. Produces spec.md files as the project's source of truth. |

## פקודות (Slash Commands / Workflows)
| פקודה | מה עושה |
|-------|---------|
| `/add-phase <phase-name>` | Add a new phase to the end of the roadmap |
| `/add-todo <description> [--priority high|medium|low]` | Capture a todo item for later |
| `/audit-milestone [milestone-name]` | Audit a milestone for quality and completeness |
| `/check-todos [--all] [--priority high|medium|low]` | List all pending todo items |
| `/complete-milestone` | Mark current milestone as complete and archive |
| `/debug [description of issue]` | Systematic debugging with persistent state |
| `/discuss-phase <phase-number>` | Discuss a phase before planning (clarify scope and approach) |
| `/error-diagnose` | אבחון שגיאה - ניתוח בעיה ויצירת תכנית תיקון |
| `/error-fix-phase` | תיקון פאזה בודדת מתוך תכנית תיקון שגיאה |
| `/execute <phase-number> [--gaps-only]` | The Engineer — Execute a specific phase with focused context |
| `/help` | Show all available digido commands |
| `/insert-phase <position> <phase-name>` | Insert a phase between existing phases (renumbers subsequent) |
| `/list-phase-assumptions <phase-number>` | List assumptions made during phase planning |
| `/map` | The Architect — Analyze codebase and update ARCHITECTURE.md and STACK.md |
| `/new-milestone <milestone-name>` | Create a new milestone with phases |
| `/new-project` | Initialize a new project with deep context gathering |
| `/pause` | Context hygiene — dump state for clean session handoff |
| `/plan-milestone-gaps` | Create plans to address gaps found in milestone audit |
| `/plan [phase] [--research] [--skip-research] [--gaps]` | The Strategist — Decompose requirements into executable phases in ROADMAP.md |
| `/progress` | Show current position in roadmap and next steps |
| `/python-build-session [project path or 'continue' to resume]` | Full Python build session — from opening to saving state. Orchestrates all skills in sequence. |
| `/python-session-handoff [reason: 'end of session' | 'context full' | 'switching agent' | 'blocked']` | Clean handoff between sessions or agents — saves complete state for seamless continuation. |
| `/python-verify-and-fix [error description or 'check last failure']` | Controlled fix loop — debug, fix, verify. Maximum 3 rounds. Stops on circular detection. |
| `/remove-phase <phase-number>` | Remove a phase from the roadmap (with safety checks) |
| `/research-phase <phase-number> [--level 1|2|3]` | Deep technical research for a phase |
| `/resume` | Restore context from previous session |
| `/verify <phase-number>` | The Auditor — Validate work against spec with empirical evidence |
| `/web-search` | Search the web for information to inform decisions |
| `/whats-new` | Show recent digido changes and new features |
| `/youtube-meta` | create a youtube video perfect meta data |
