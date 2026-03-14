---
name: meeting-summary
description: Turn raw meeting notes into structured summaries with decisions and action items. Auto-load when user asks to summarize a meeting, write meeting minutes, or create a meeting recap.
argument-hint: "[paste raw meeting notes or transcript, meeting type, participants]"
---

# Meeting Summary Generator

הופך פגישה כאוטית לתיעוד שכולם יסכימו עליו — עם החלטות ברורות, action items ממוספרים, ובלי הסיפורת המיותרת.

## What to Provide
- הדבר שיצא מהפגישה: גולמי, transcript, נקודות מפוזרות — כל פורמט מתאים
- שמות משתתפים ותפקידיהם (כדי לייחס נכון)
- סוג הפגישה: brainstorm / החלטה / עדכון / אחרת
- ערוץ שיתוף: Slack / אימייל / Notion / Google Docs
- אם יש: ההחלטות שנלקחו לפי הזיכרון שלך

## How Claude Works Through This
1. **מיצוי ה-Signal מה-Noise** — מפריד בין החלטות, דיון, ורעיונות לעתיד
2. **ניסוח החלטות** — מנסח כל החלטה כ-Action Statement ברור: "הוחלט ש-[X]" — לא "דנו ב-[Y]"
3. **Action Items** — כל פריט: מה, מי, מתי — ללא עמימות
4. **דיון עיקרי** — מסכם את הנקודות המרכזיות שעלו, כולל מחלוקות שנפתחו
5. **Open Items / Parking Lot** — מה נפתח ולא נסגר, ומה מועבר לפגישה הבאה

## Output Format

**Meeting Summary — [שם הפגישה] — [תאריך]**

```
MEETING AT A GLANCE
תאריך: [...]
משתתפים: [שמות ותפקידים]
מנחה: [...]
מטרה: [...]

DECISIONS MADE (מה הוחלט — אין כאן "שקלנו" או "אולי")
✅ [החלטה 1 — ניסוח ברור כ-fact, לא כ-option]
✅ [החלטה 2]
✅ [החלטה 3]

ACTION ITEMS
| # | פעולה | אחראי | תאריך יעד | סטטוס |
|---|-------|-------|-----------|-------|
| 1 | [...] | [...] | [dd/mm]   | Open  |
| 2 | [...] | [...] | [dd/mm]   | Open  |

KEY DISCUSSION POINTS (לא כל מה שנאמר — רק מה שחשוב לדעת)
נושא 1: [...]
  עמדות שעלו: [...]
  תוצאה: [...]

נושא 2: [...]

OPEN ITEMS / PARKING LOT (לא נסגר — נדרש המשך)
- [נושא → מה נדרש → מתי חוזרים אליו]

NEXT MEETING
תאריך: [...]
מטרה: [...]
Pre-work נדרש: [...]
```

**Quick Prompts**
- "Summarize these meeting notes: [paste notes] — it was a product planning session with 5 people"
- "Turn this Zoom transcript into meeting minutes with action items: [paste transcript]"
- "Write a recap of our board meeting based on these bullet points: [paste bullets]"
