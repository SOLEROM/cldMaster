---
name: swot-analysis
description: Run a structured SWOT analysis with strategic implications and action recommendations. Auto-load when user asks to do a SWOT, analyze strengths and weaknesses, or assess competitive position.
argument-hint: "[company/product name, industry, key context about situation, decision being made]"
---

# SWOT Analyst

מנתח SWOT שהולך רחוק מעבר לטבלה — מחבר את הממצאים לאסטרטגיה ממשית ומציג אילו החלטות נובעות מהניתוח.

## What to Provide
- שם החברה / המוצר / הפרויקט
- תעשייה ושוק
- מה הביא אותך לעשות את הניתוח עכשיו (החלטה, אתגר, הזדמנות)
- כל מידע שיש לך: מתחרים, נתוני מכירות, משוב לקוחות, מגמות שוק
- מה השאלה האסטרטגית שאתה מנסה לענות עליה

## How Claude Works Through This
1. **מיפוי SWOT גולמי** — מזהה Strengths, Weaknesses, Opportunities, Threats על בסיס המידע שסיפקת
2. **ניקוד ועדיפות** — מדרג כל גורם לפי עוצמה ומיידיות
3. **מטריצת SO/WO/ST/WT** — בונה 4 אסטרטגיות נגזרות: Leverage / Improve / Protect / Avoid
4. **Insight בלעדי** — מציין מה שעשוי להיות לא ברור אך קריטי (blind spots)
5. **המלצות אסטרטגיות** — 3-5 פעולות קונקרטיות שנובעות ישירות מהניתוח

## Output Format

**SWOT Analysis — [שם] — [תאריך]**

```
STRENGTHS (חוזקות פנימיות)
★★★ [גורם קריטי] — [הסבר 1-2 משפטים]
★★☆ [גורם בינוני] — [...]
★☆☆ [גורם שולי] — [...]

WEAKNESSES (חולשות פנימיות)
⚠️ קריטי: [...]
⚠️ בינוני: [...]

OPPORTUNITIES (הזדמנויות חיצוניות)
🟢 מיידית: [...]
🟡 טווח בינוני: [...]

THREATS (איומים חיצוניים)
🔴 דחוף: [...]
🟠 לעקוב: [...]

STRATEGIC MATRIX
SO (Strength × Opportunity): [אסטרטגיית צמיחה]
WO (Weakness × Opportunity): [אסטרטגיית שיפור]
ST (Strength × Threat): [אסטרטגיית הגנה]
WT (Weakness × Threat): [אסטרטגיית הישרדות]

BLIND SPOTS
[מה שכנראה לא רואים מבפנים]

TOP 3 ACTIONS (מה לעשות עכשיו)
1. ...
2. ...
3. ...
```

**Quick Prompts**
- "SWOT for my e-commerce business before we decide whether to open a physical store"
- "Run a SWOT on our HR-tech startup — we're deciding whether to raise a Series A now or wait"
- "Do a SWOT analysis on our main product before we launch version 2.0"
