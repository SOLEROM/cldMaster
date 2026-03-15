---
name: investor-pitch
description: Create a complete investor pitch deck with structure, messaging, and content. Auto-load when user asks to build a pitch deck, prepare for investor meetings, or create a fundraising presentation.
argument-hint: "[company name, stage (seed/A/B), amount raising, business model, key traction metrics]"
---

# Investor Pitch Deck Builder

בונה פיץ' שמשקיעים ישמעו — לא slide deck שנראה כמו Business Plan. מבוסס על המבנה שעובד בפועל, עם Storytelling שמניע לפגישה הבאה.

## What to Provide
- שם החברה, מה היא עושה (במשפט אחד)
- סבב גיוס: Seed / Pre-A / A / B
- כמה מגייסים ולמה (use of funds)
- מדדי Traction עיקריים: ARR/MRR, לקוחות, צמיחה, churn
- שוק: גודל SAM, מגמות
- צוות מייסדים + רקע
- מה ה-Unfair Advantage שלכם
- כל VC / קהל ספציפי שיש לך בראש

## How Claude Works Through This
1. **גיבוש ה-Hook** — מנסח את פתיחת ה-deck: בעיה שמשקיע לא יכול להתעלם ממה
2. **בניית 12-15 Slides** — מבנה קלאסי שעובד: Problem / Solution / Market / Product / Traction / Business Model / GTM / Team / Financials / Ask
3. **ניסוח Action Titles** — כל slide title הוא Insight, לא תיאור (לא "שוק" — אלא "שוק של $4B גדל 40% בשנה")
4. **חיזוק נתוני Traction** — מוודא שהנתונים מוצגים בצורה שמספרת סיפור, לא רשימה
5. **הכנה לשאלות קשות** — מכין תשובות ל-10 השאלות שכל משקיע ישאל

## Output Format

**Investor Pitch Blueprint — [חברה] — [סבב]**

```
THE ONE-LINER
"[מה החברה עושה — למי — ולמה עכשיו]"

DECK STRUCTURE (15 slides)

SLIDE 1 — COVER
Company name | One-liner | Logo | Raise amount

SLIDE 2 — PROBLEM (הבעיה שאף אחד לא פותר טוב)
Action Title: "[...]"
Hook: [תיאור הבעיה בצורה שהמשקיע ירגיש]
Data: [גודל הבעיה בכסף / זמן / כאב]

SLIDE 3 — SOLUTION
Action Title: "[...]"
Demo/Screenshot if possible
Why now: [למה הפתרון הזה אפשרי היום ולא לפני 3 שנים]

SLIDE 4 — MARKET
TAM: $[X]B | SAM: $[X]M | SOM (שנה 3): $[X]M
מגמה: [מה גורם לשוק לצמוח]

SLIDE 5 — PRODUCT
[מה עושה המוצר | Screenshots | Differentiators]

SLIDE 6 — TRACTION (הslide שהמשקיע הכי רוצה לראות)
Action Title: "[מה הנתון הכי מרשים]"
[גרף צמיחה | ARR | NPS | לוגואים של לקוחות]

SLIDE 7 — BUSINESS MODEL
[איך מרוויחים | Unit Economics | LTV:CAC]

SLIDE 8 — GO-TO-MARKET
[כיצד מגיעים לצמיחה הבאה]

SLIDE 9 — COMPETITION
[Positioning Matrix — למה אנחנו שונים]

SLIDE 10 — TEAM
[מייסדים + למה הם | Advisors]

SLIDE 11 — FINANCIALS (3-year projection)
[Revenue | EBITDA | Burn | Runway]

SLIDE 12 — THE ASK
גייסים: $[X]M | Valuation: $[X]M
Use of Funds: [טבלה]
Milestones ב-18 חודשים: [...]

HARD QUESTIONS & PREPARED ANSWERS
1. "למה עכשיו?" → [...]
2. "מה אם [מתחרה גדול] יעשה את זה?" → [...]
3. "מה ה-Moat שלכם?" → [...]
...
```

**Quick Prompts**
- "Build a Seed pitch deck for our AI compliance SaaS — we have $40K MRR, 12 paying customers, raising $1.5M"
- "I have a Series A meeting next week, help me structure a 15-minute pitch for a $5M raise"
- "Create the story arc for our pitch — we're a marketplace for freelance engineers in the MENA region"
