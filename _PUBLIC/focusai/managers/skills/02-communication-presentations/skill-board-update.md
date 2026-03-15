---
name: board-update
description: Prepare a complete board meeting update report with the right level of detail and framing. Auto-load when user asks to prepare a board update, write a board report, or get ready for a board meeting.
argument-hint: "[company stage, time period covered, key metrics, major events since last meeting, what you need from the board]"
---

# Board Update Preparer

מכין עדכון לדירקטוריון שמנהלים כבר ניסו להסתיר בתוכו רע-חדשות — ולא הצליחו. הגישה הנכונה: שקיפות, בקרה, ואמינות.

## What to Provide
- תקופה מדווחת (רבעון / חצי שנה)
- מדדים עיקריים: הכנסות, לקוחות, צמיחה, burn, runway
- מה הצלחת מאז הפגישה האחרונה
- מה לא הלך לפי התכנית — ומה עשית בנוגע לכך
- שאלות פתוחות שדורשות עמדת הדירקטוריון
- מה ה-Ask מהפגישה: אישור / עצה / חיבור / תקציב

## How Claude Works Through This
1. **עיצוב ה-Frame הנכון** — קובע את הטון: מה הסיפור של הרבעון הזה בשתי שורות
2. **סנתוז נתונים לסיפור** — לא רשימת מספרים, אלא מה המספרים אומרים על הכיוון
3. **ניסוח מסרים קשים** — אם יש חדשות רעות, מנסח אותן בצורה שמבטאת שליטה ולא פאניקה
4. **הכנת הדיון** — מזהה את הסוגיות שיוצרו דיון ומכין עמדה ברורה לכל אחת
5. **Action Items מהפגישה** — מבנה מוכן לסגירת הפגישה עם החלטות ברורות

## Output Format

**Board Update — [חברה] — [תקופה]**

```
EXECUTIVE HEADLINE (2-3 משפטים)
"הרבעון הזה היה [תיאור]. הצלחנו [X]. לא הצלחנו [Y].
האסטרטגיה שלנו ל-[תקופה הבאה] היא [...]"

SECTION 1: SCORECARD
| מדד | יעד | בפועל | מגמה | הערה |
|-----|-----|-------|------|------|
| ARR | ₪[X] | ₪[Y] | ↑/↓ | [הסבר אם מתחת ליעד] |
| Burn | ₪[X]/m | ₪[Y]/m | | |
| Runway | [X months] | [Y months] | | |
| לקוחות חדשים | [X] | [Y] | | |
| Churn | <[X]% | [Y]% | | |

SECTION 2: WINS (מה הלך טוב)
1. [הישג + נתון]
2. ...

SECTION 3: CHALLENGES (מה לא הלך — ומה עשינו)
אתגר 1: [תיאור]
  → מה קרה: [...]
  → מה עשינו: [...]
  → מה אנחנו מצפים: [...]

SECTION 4: KEY DECISIONS NEEDED
שאלה 1: [תיאור הדילמה]
  → אפשרות A: [...]
  → אפשרות B: [...]
  → עמדת ההנהלה: [...]
  → מה אנחנו מבקשים מהדירקטוריון: [הצבעה / עצה / חיבור]

SECTION 5: LOOK AHEAD (Q הבא)
יעדים קריטיים: [3 דברים]
סיכונים שצריך לעקוב: [2 דברים]

ACTION ITEMS (לסגירת הפגישה)
| פעולה | אחראי | תאריך |
|-------|-------|--------|
```

**Quick Prompts**
- "Prepare my Q1 board update — we hit 85% of revenue target, lost 2 key customers, hired VP Sales"
- "I need to present bad news to the board — we're 3 months behind on product delivery"
- "Write a board update that asks for approval to raise a bridge round of $500K"
