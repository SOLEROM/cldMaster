---
name: market-entry
description: Plan a complete market entry strategy for a new geography, segment, or channel. Auto-load when user asks to enter a new market, expand to a new country, or launch in a new segment.
argument-hint: "[product/company, target market, current presence, available resources, timeline]"
---

# Market Entry Strategist

בונה אסטרטגיית כניסה לשוק שמבוססת על עובדות — לא על תקוות. מגדיר כיצד להיכנס, דרך מה, ובאיזה סדר עדיפויות.

## What to Provide
- מוצר / שירות שאתה מביא לשוק
- השוק שאתה רוצה להיכנס אליו (גיאוגרפיה, סגמנט, ערוץ)
- מה יש לך היום: לקוחות, הכנסות, נוכחות
- משאבים זמינים (תקציב, צוות, קשרים בשוק היעד)
- ציר זמן לכניסה
- יתרון תחרותי שאתה מביא

## How Claude Works Through This
1. **ניתוח שוק היעד** — גודל שוק, מגמות, שחקנים קיימים, חסמי כניסה, ורגולציה רלוונטית
2. **פילוח ובחירת ICP** — מזהה את פרופיל הלקוח האידיאלי בשוק החדש ואיך הוא שונה מהקיים
3. **בחירת אסטרטגיית כניסה** — מעריך ומדרג: ישיר, שותפות, רכישה, franchising, freemium
4. **תכנון Go-To-Market** — ערוצי הפצה, מסרים, מחיר, ותוכנית ה-launch
5. **לוח זמנים ומיילסטונים** — שלב 1/2/3 עם Go/No-Go gates ברורים

## Output Format

**Market Entry Strategy — [חברה] לשוק [X]**

```
MARKET SNAPSHOT
- גודל שוק: [TAM / SAM / SOM]
- מגמות מרכזיות: [3 נקודות]
- שחקנים עיקריים: [טבלה: שחקן | נתח שוק | חוזק | חולשה]
- חסמי כניסה: [רגולציה / הון / מותג / פיזי]

ICP בשוק היעד
- פרופיל: [תיאור]
- איך שונה מלקוח הנוכחי: [...]
- מסרים שיעבדו איתו: [...]

אסטרטגיית כניסה מומלצת: [שם]
  הנמקה: ...
  יתרונות vs. חלופות: ...

GO-TO-MARKET PLAN
שלב 1 (חודשים 1-3): Beachhead
  - מוצר: [MVP / מלא?]
  - ערוץ: [...]
  - יעד הכנסות: [...]

שלב 2 (חודשים 4-9): Scale
שלב 3 (חודשים 10-18): Expand

GO / NO-GO GATES
Gate 1 (סוף שלב 1): [קריטריון]
Gate 2 (סוף שלב 2): [קריטריון]

INVESTMENT REQUIRED
[טבלה: קטגוריה | עלות חד-פעמית | שוטף/חודש]
```

**Quick Prompts**
- "Plan market entry for our B2B SaaS product into the German market, we have ₪500K budget and 12 months"
- "We're a consulting firm in Israel, we want to enter the UAE market — where do we start?"
- "Help me enter the SMB segment, we've only sold to enterprise so far"
