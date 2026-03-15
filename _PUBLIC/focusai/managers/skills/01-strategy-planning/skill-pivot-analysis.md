---
name: pivot-analysis
description: Evaluate whether and how to pivot a business, product, or strategy. Auto-load when user asks to consider a pivot, change direction, or evaluate major strategic shifts.
argument-hint: "[current business model, what's not working, pivot options you're considering, constraints]"
---

# Pivot Analysis Framework

מסייע לקבל את ההחלטה הקשה ביותר: להמשיך, לשנות כיוון, או לעצור. עם מסגרת ברורה — לא תחושת בטן.

## What to Provide
- המודל העסקי הנוכחי: מה אתה עושה, למי, ואיך מרוויח
- מה לא עובד: נתונים ספציפיים — צמיחה, churn, הכנסות, משוב לקוחות
- כמה זמן יש לך (runway): תקציב וזמן עד שצריך להחליט
- פיבוטים שאתה שוקל (גם אם הם רעיוניים בלבד)
- מה לא ניתן לשנות (constraints קשים: חוזים, משקיעים, צוות)
- מה מה כן עובד שאתה לא רוצה לאבד

## How Claude Works Through This
1. **אבחון "למה לא עובד"** — מפריד בין בעיית ביצוע לבעיית אסטרטגיה (חיוני לפני פיבוט!)
2. **מיפוי אפשרויות הפיבוט** — ממפה 4-6 כיוונים שאפשר ללכת, כולל שמירה על מסלול נוכחי
3. **הערכת אפשרויות** — לכל אפשרות: פוטנציאל, סיכון, מה צריך לוותר, זמן עד הכנסות
4. **ניתוח Signal vs. Noise** — האם הנתונים הנוכחיים מספיקים להחלטה, ומה עוד צריך לאסוף
5. **המלצה ו-Decision Framework** — מה לעשות ב-30/60/90 ימים הבאים

## Output Format

**Pivot Analysis — [חברה/מוצר] — [תאריך]**

```
DIAGNOSIS (לפני שמחליטים מה לשנות)
האם הבעיה היא ביצוע או אסטרטגיה?
- ראיות שזה ביצוע: [...]
- ראיות שזה אסטרטגיה: [...]
- מסקנה: [ביצוע / אסטרטגיה / שניהם]

CURRENT STATE
✓ מה עובד ויש לשמר: [...]
✗ מה לא עובד ודורש שינוי: [...]
⚡ Runway: [כמה זמן + כסף]

PIVOT OPTIONS

אפשרות 0: המשך בנתיב הנוכחי
  - מה נדרש כדי לנצח: [...]
  - הסתברות: [%]
  - המלצה: עשה / אל תעשה

אפשרות 1: [שם הפיבוט]
  - מה משתנה: [...]
  - מה נשמר: [...]
  - זמן עד ראיות ראשונות: [...]
  - מה צריך לוותר: [...]
  - Go/No-Go test: [מה ידאיג ב-60 יום]

אפשרות 2: [...]

SIGNALS TO COLLECT BEFORE DECIDING
[אם עדיין לא ברור — מה צריך לבדוק + בכמה זמן]

RECOMMENDATION
[פיבוט / המשך / עצור] + תוכנית ל-30/60/90 ימים
```

**Quick Prompts**
- "Should we pivot from B2C to B2B? We have 2,000 users but barely any revenue and 8 months runway"
- "Our SaaS product isn't growing — help me decide if this is an execution problem or a product problem"
- "We're considering pivoting from services to products — what should I think through?"
