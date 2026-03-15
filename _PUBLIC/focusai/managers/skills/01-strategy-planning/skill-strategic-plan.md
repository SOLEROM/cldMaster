---
name: strategic-plan
description: Build a complete annual or quarterly strategic plan. Auto-load when user asks to create a strategic plan, write a company strategy, or plan for the year/quarter.
argument-hint: "[company/team name, time horizon, current situation, top priorities or challenges]"
---

# Strategic Plan Builder

הופך מידע עסקי גולמי לתכנית אסטרטגית מובנית — עם יעדים, יוזמות, מדדים ולוח זמנים ריאלי.

## What to Provide
- שם החברה / הצוות והתעשייה
- אופק הזמן (שנתי / רבעוני)
- מצב נוכחי: מה עובד, מה לא, איפה אתה עכשיו
- אתגרים מרכזיים שאתה מתמודד איתם
- משאבים זמינים: תקציב, צוות, מגבלות ידועות
- שאיפות / כיוון שאתה רוצה ללכת אליו

## How Claude Works Through This
1. **ניתוח מצב** — מסנתז את המידע לתמונת "היכן אנחנו עכשיו" ברורה, כולל פערים בין הרצוי למצוי
2. **גיבוש כיווני אסטרטגיה** — מציע 2-4 נדבכים אסטרטגיים עיקריים עם הנמקה לכל אחד
3. **פירוט יוזמות** — לכל נדבך, מגדיר יוזמות קונקרטיות עם בעלות, לוח זמנים, ותלויות
4. **הגדרת מדדי הצלחה** — מדדי KPI ברים-מדידה לכל יעד, עם ערכי baseline ויעד
5. **תכנית ביצוע ומעקב** — פירוט רבעוני / חודשי, אבני דרך, ונקודות ביקורת

## Output Format

**תכנית אסטרטגית — [שם החברה] — [תקופה]**

```
EXECUTIVE SUMMARY (2-3 משפטים)

SECTION 1: ניתוח מצב
- איפה אנחנו: [תיאור תמציתי]
- הזדמנויות מרכזיות: [3-4 נקודות]
- אתגרים קריטיים: [3-4 נקודות]

SECTION 2: יעדים אסטרטגיים
יעד 1: [שם יעד]
  - תיאור: ...
  - KPIs: ...
  - לוח זמנים: ...

SECTION 3: יוזמות לפי נדבך
[טבלה: יוזמה | בעל תפקיד | Q1/Q2/Q3/Q4 | תקציב | סטטוס]

SECTION 4: תכנית ביצוע רבעונית
Q1: ...
Q2: ...
...

SECTION 5: סיכונים ותלויות
[סיכון | הסתברות | השפעה | תגובה]
```

**Quick Prompts**
- "Build a strategic plan for my SaaS company, we have 12 employees, ARR $800K, goal is to reach $2M next year"
- "Write a Q2 strategic plan for my sales team — we missed Q1 targets and need to course-correct"
- "Create an annual strategy for our e-commerce brand entering the B2B market for the first time"
