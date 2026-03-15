---
name: meeting-agenda
description: Create a structured meeting agenda that ensures productive meetings with clear outcomes. Auto-load when user asks to build a meeting agenda, prepare for a meeting, or structure a discussion.
argument-hint: "[meeting type, participants, duration, topics to cover, desired outcome]"
---

# Meeting Agenda Designer

מכין אג'נדות שגורמות לפגישות להסתיים בזמן, עם החלטות, ובלי שאנשים יוצאים ושואלים "ואז מה?"

## What to Provide
- סוג הפגישה: הנהלה / צוות / לקוח / one-on-one / brainstorm / החלטה / תחקיר
- משתתפים ותפקידיהם
- משך: 30 / 60 / 90 / 120 דקות
- נושאים שצריך לכסות
- מה ה-outcome הרצוי: החלטה / יישור קו / תוכנית / דיאגנוסטיקה
- מה הסיכון שהפגישה תעוף לו אם לא מנהלים אותה טוב

## How Claude Works Through This
1. **הגדרת ה-Meeting Goal** — מסיק מהו ה-single deliverable שיוצא מהפגישה
2. **תכנון זמן** — מחלק דקות לפי עדיפות — לא כל נושא זוכה לזמן שווה
3. **סדר נושאים** — קובע את הלוגיקה: מה צריך להגיע לפני מה כדי שהדיון יעבוד
4. **הגדרת Decision Points** — מסמן היכן בדיוק תהיה הצבעה / החלטה — לא "נדון"
5. **הכנת Pre-Read ופעולות מקדימות** — מה כל משתתף צריך לדעת לפני שמגיע

## Output Format

**Meeting Agenda — [שם הפגישה] — [תאריך]**

```
MEETING BRIEF
מטרה: [מה מושג בפגישה הזאת — משפט אחד]
Outcome: [מה יוצא מהפגישה: החלטה / תכנית / רשימת actions]
Decision Maker: [מי מחליט כשאין קונצנזוס]
Facilitator: [מי מנהל]
Time Box: [שעת התחלה → שעת סיום]

PRE-WORK (לפני הפגישה)
- [שם] → [מה להכין / לקרוא]
- [שם] → [...]

AGENDA

[00:00-00:05] — פתיחה ומטרת הפגישה
  אחראי: [Facilitator]
  Output: כולם מיושרים על המטרה

[00:05-00:20] — [נושא 1]
  אחראי: [שם]
  שאלת מוביל: "[השאלה שצריך לענות עליה]"
  Output: [מה יוצא — החלטה / עמדה / נתונים]
  ⚑ Decision Point: [כן/לא | A/B | אחר]

[00:20-00:45] — [נושא 2]
  ...

[00:45-00:55] — [נושא 3 — discussion בלבד]

[00:55-01:00] — Action Items וסגירה
  אחראי: [Facilitator / Note Taker]
  Output: רשימת actions עם שמות ותאריכים

PARKING LOT (נושאים לפגישה אחרת)
[...]

GROUND RULES (אם נדרש)
- מכשירים על שקט
- אף אחד לא מדבר יותר מ-X דקות ברצף
- החלטות ב-Consent, לא בקונצנזוס
```

**Quick Prompts**
- "Design a 60-minute quarterly business review agenda for a team of 12"
- "Build an agenda for a difficult conversation between two departments that are in conflict"
- "I have 90 minutes with a potential strategic partner — what's the right meeting structure?"
