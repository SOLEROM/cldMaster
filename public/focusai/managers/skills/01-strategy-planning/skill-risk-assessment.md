---
name: risk-assessment
description: Identify, score, and build mitigation plans for business risks. Auto-load when user asks to assess risks, identify what could go wrong, or build a risk register.
argument-hint: "[project/initiative/company context, stage, known concerns, decision being made]"
---

# Risk Assessment Framework

מזהה את הסיכונים שמנהלים לא אוהבים לדבר עליהם — ובונה תכניות מיטיגציה שניתן לבצע בפועל, לא רק לכתוב בהם.

## What to Provide
- הפרויקט / החברה / ההחלטה שאתה מעריך
- שלב: pre-launch, scale, פעילות שוטפת
- תחומי סיכון שאתה כבר מודאג מהם
- מה הנזק הפוטנציאלי שאתה לא מוכן לספוג
- האופק: לכמה זמן קדימה אתה רוצה לחשוב
- כל מידע על תלויות: ספקים, רגולציה, שותפים

## How Claude Works Through This
1. **סריקת סיכונים** — עובר על 7 קטגוריות: אסטרטגי, תפעולי, פיננסי, משפטי/רגולטורי, טכנולוגי, אנשים/HR, שוק/מתחרים
2. **ניקוד סיכונים** — לכל סיכון: Probability (1-5) × Impact (1-5) = Risk Score
3. **מטריצת חומרה** — מסווג סיכונים ל-Critical / High / Medium / Low
4. **תכניות מיטיגציה** — לכל סיכון Critical/High: Prevent / Detect / Respond
5. **Risk Owner ו-Review Cadence** — מי אחראי, מתי בודקים מחדש

## Output Format

**Risk Assessment — [פרויקט/חברה] — [תאריך]**

```
RISK REGISTER

| # | קטגוריה | תיאור סיכון | Prob | Impact | Score | רמה |
|---|---------|------------|------|--------|-------|-----|
| 1 | פיננסי  | [...]      |  4   |   5    |  20   | CRITICAL |
| 2 | משפטי   | [...]      |  3   |   4    |  12   | HIGH |
...

CRITICAL RISKS — פירוט ותכנית פעולה

סיכון 1: [שם]
- תיאור: ...
- סימני אזהרה מוקדמים: [מה לחפש]
- מניעה: [מה עושים עכשיו]
- תגובה אם מתממש: [תוכנית B]
- Risk Owner: [תפקיד]
- Review: [שבועי / חודשי]

HIGH RISKS — [פירוט קצר + owner + action]

RISK APPETITE STATEMENT
"אנחנו מוכנים לקחת סיכון [X] אם [תנאי] — לא מוכנים לסכן [Y] בשום תרחיש"

UPCOMING RISK CALENDAR
[חודש/אירוע] → [סיכון שמתחיל להיות רלוונטי]
```

**Quick Prompts**
- "Assess risks for launching our product in a new country in 6 months — budget is limited"
- "Do a risk assessment for taking on a major client that would be 60% of our revenue"
- "What are the risks of moving our entire team to remote work permanently?"
