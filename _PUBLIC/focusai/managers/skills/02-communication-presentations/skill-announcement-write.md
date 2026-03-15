---
name: announcement-write
description: Write company or team announcements that inform clearly and land the right way. Auto-load when user asks to write an announcement, communicate a company change, or share organizational news.
argument-hint: "[what the announcement is about, audience, tone desired, any sensitive context]"
---

# Announcement Writer

כותב הודעות שאנשים קוראים בפועל, מבינים, ולא מסתכלים אחריהן בפגישה ושואלים "מה בדיוק השתנה?"

## What to Provide
- מה ההודעה: מינוי / עזיבה / שינוי מבנה / השקה / מיזוג / מדיניות חדשה / הצלחה
- קהל: כל החברה / מנהלים בלבד / לקוחות / עיתונות / שוק
- מה הם ירגישו בהתחלה: שמחה / דאגה / אדישות / מבוכה
- אלמנטים שחשוב לכלול: ציטוט / עובדות / לוח זמנים
- מה שחשוב שלא לומר (לגאלי, פוליטי, רגיש)
- ערוץ: אימייל / Slack / כנס חברה / LinkedIn / עיתונות

## How Claude Works Through This
1. **Emotional Landing** — מזהה מה האנשים ירגישו ומוודא שהמסר מכיר בכך
2. **Headline ו-Hook** — פותח בצורה שמושכת תשומת לב — לא "ברצוני להודיע ש..."
3. **מבנה WHY → WHAT → HOW → WHAT'S NEXT** — הסבר לפני עובדות
4. **Quotes שנשמעים אנושיים** — לא boilerplate, אלא ציטוטים שמנהל היה אומר בפועל
5. **FAQ אנטיציפציה** — מציע תשובות לשאלות הנפוצות שיישאלו מיד אחרי

## Output Format

**Announcement — [נושא] — [ערוץ]**

```
[PRIMARY ANNOUNCEMENT]

[SUBJECT / HEADLINE]
[פותח בצד חיובי / משמעות, לא בעובדה הטכנית]

[פסקה 1 — ה-WHY: למה ההחלטה הזאת / למה עכשיו]

[פסקה 2 — ה-WHAT: מה בדיוק משתנה / קורה]

[פסקה 3 — ה-HOW IT AFFECTS YOU: מה המשמעות לנמען הספציפי]

[ציטוט — אנושי ואמיתי, לא שגרתי]

[פסקה 4 — WHAT'S NEXT: מה קורה עכשיו / מה הצעדים הבאים]

[סגירה — תודה / אופטימיות / הזמנה לדיאלוג]

---

INTERNAL NOTES (לא בהודעה הגלויה)
שאלות צפויות:
Q: [...]  A: [...]
Q: [...]  A: [...]

גרסה קצרה לSlack/WhatsApp: [...]
גרסה לLinkedIn (אם רלוונטי): [...]
```

**Quick Prompts**
- "Write an all-hands announcement that our VP Marketing is leaving the company after 4 years"
- "Draft an announcement for our company rebranding — new name, new positioning, same team"
- "We just closed a major Series B — write the internal announcement for employees first"
