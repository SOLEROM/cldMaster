# Mirror Report Examples

## Example 1: On Track

```markdown
## 🪞 Mirror Report — 2026-01-15 14:30

### 📊 Progress Snapshot
- **Completed:** 7/12 tasks (58%)
- **In Progress:** Building user authentication endpoint
- **Pending:** 4 tasks (dashboard, export, tests, deploy config)
- **Blocked:** None

### ✅ What's Done
1. ✅ Project setup + venv
2. ✅ Database connection (Supabase)
3. ✅ User model
4. ✅ CRUD endpoints for users
5. ✅ Input validation (Pydantic)
6. ✅ Error handling middleware
7. ✅ Environment config (.env)

### 🔄 What's In Progress
- **Auth endpoint** — JWT login/register
  - Started: 30 min ago
  - Status: On track
  - Remaining: ~20 min

### ⏳ What's Next
1. Dashboard data endpoint
2. CSV export function
3. Pytest test suite

### 🚧 Blockers & Risks
- **Risk:** No tests yet — if something breaks in auth, we won't catch regressions
  - Mitigation: Tests are task #11, but consider a quick smoke test after auth

### 🧭 Plan Drift Check
- Drift: **None** — following plan exactly
```

## Example 2: Drifting

```markdown
## 🪞 Mirror Report — 2024-01-15 16:00

### 📊 Progress Snapshot
- **Completed:** 5/12 tasks (42%)
- **In Progress:** Debugging database connection (was supposed to be done)
- **Pending:** 6 tasks
- **Blocked:** 1 task (auth depends on working DB)

### ✅ What's Done
1. ✅ Project setup + venv
2. ✅ User model
3. ✅ CRUD endpoints (code written, not tested)
4. ✅ Input validation
5. ✅ Environment config

### 🔄 What's In Progress
- **Database connection** — Supabase keeps timing out
  - Started: 2 hours ago
  - Status: ⚠️ Struggling — 2 debug attempts so far
  - Remaining: Unknown

### 🚧 Blockers & Risks
- **Blocker:** DB connection unstable — everything downstream depends on it
  - Impact: Auth, dashboard, export all blocked
- **Risk:** 2/3 debug strikes used. One more failure → fresh session needed.

### 🧭 Plan Drift Check
- Original plan: DB connection was a 15-min task
- Actual: 2 hours and counting
- Drift: **Significant** — we're behind by ~1.5 hours
- Action needed: If Strike 3 hits, pause and reassess. Maybe switch to SQLite for local dev.
```
