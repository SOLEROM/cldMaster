---
name: product-roadmap
description: Create a prioritized product roadmap with clear rationale and delivery milestones. Auto-load when user asks to build a product roadmap, prioritize features, or plan product development.
argument-hint: "[product name, stage, team size, list of features/requests/ideas, strategic goals]"
---

# Product Roadmap Builder

הופך רשימת פיצ'רים, בקשות לקוחות, ורצונות של כולם — לרודמאפ שניתן לבצע, שיש לו סיפור, ושהצוות יאמין בו.

## What to Provide
- שם המוצר ושלב (MVP / growth / maturity)
- גודל צוות הפיתוח וה-velocity המשוערת
- רשימת הפיצ'רים / בקשות / רעיונות — כמה שיותר, לא מסודרים זה בסדר
- יעדים אסטרטגיים של החברה (מה המוצר צריך להשיג)
- אופק הרודמאפ: 3 חודשים / 6 חודשים / שנה
- constraints ידועים: תאריכי יעד קשים, תלויות טכנולוגיות

## How Claude Works Through This
1. **קטגוריזציה** — ממיין פיצ'רים ל: Must-have / Should-have / Nice-to-have / Not-now
2. **Framework עדיפות** — מדרג לפי RICE (Reach × Impact × Confidence ÷ Effort) או ICE Score
3. **קיבוץ לתמות** — מארגן פיצ'רים לתמות או Epics שיש להם story קוהרנטי
4. **תכנון רבעוני** — מחלק את העבודה לשלבים עם מיילסטונים ו-Go-Live dates
5. **תקשורת הרודמאפ** — מנסח את ה-Narrative: למה הסדר הזה, ומה הלקוח ירגיש בכל שלב

## Output Format

**Product Roadmap — [מוצר] — [תקופה]**

```
STRATEGIC OBJECTIVES (מה הרודמאפ אמור להשיג)
1. [יעד עסקי 1]
2. [יעד עסקי 2]

PRIORITIZATION SCORES
[טבלה: פיצ'ר | Reach | Impact | Confidence | Effort | RICE Score | עדיפות]

NOW (חודשים 1-3)
Theme: "[שם תמה — מה הלקוח ירגיש]"
  Epic 1: [...]
    - פיצ'ר A — [מה ולמה עכשיו]
    - פיצ'ר B
  Epic 2: [...]

NEXT (חודשים 4-6)
Theme: "[...]"
  Epic 3: ...

LATER (חודשים 7-12)
Theme: "[...]"
  [רשימה ברמה גבוהה — לא מפורטת, כי זה ישתנה]

NOT NOW (מה נדחה ולמה)
[פיצ'ר → סיבה לדחייה → מתי יוערך מחדש]

DELIVERY MILESTONES
[תאריך | מיילסטון | מה הלקוח יכול לעשות]

OPEN QUESTIONS
[שאלות שצריך לפתור לפני שמתחילים NEXT]
```

**Quick Prompts**
- "Help me build a 6-month roadmap — I have 3 developers and 40 feature requests from customers"
- "Prioritize these 20 features for our mobile app: [list them] — goal is to reduce churn"
- "Build a roadmap for our MVP launch in 90 days, we have a small team of 2 devs"
