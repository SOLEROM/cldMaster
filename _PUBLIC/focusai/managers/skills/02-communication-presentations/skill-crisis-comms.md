---
name: crisis-comms
description: Write crisis communication messages for internal and external audiences. Auto-load when user asks to handle a crisis, write a crisis statement, or communicate bad news under pressure.
argument-hint: "[what happened, who needs to be told, current known facts, what you don't know yet, urgency level]"
---

# Crisis Communications Writer

כותב תקשורת משבר שמשמרת אמינות, מפחיתה נזק, ומספקת תחושת שליטה — גם כשהמצב לא בשליטה.

## What to Provide
- מה קרה (עובדות בלבד, לא spin)
- מי הקהלים שצריך לתקשר: עובדים / לקוחות / עיתונות / רגולטורים / משקיעים
- מה ידוע ומה עדיין לא ידוע
- מה נעשה עד עכשיו
- מה הפוטנציאל לנזק נוסף
- אילוצים משפטיים / רגולטוריים שיש לשים לב אליהם

## How Claude Works Through This
1. **Triage** — מדרג את רמת החומרה ומגדיר את ה-golden hour: מה צריך לצאת בשעה הקרובה
2. **הגדרת Holding Statement** — מסר ראשוני שניתן לשלוח עוד לפני שיש כל העובדות
3. **כתיבה לפי קהל** — מעצב מסר מותאם לכל קהל: עובדים / לקוחות / מדיה
4. **מה לומר ומה לא לומר** — מסמן red lines: מה שאף פעם לא אומרים במשבר
5. **תכנית follow-up** — מתי ומה מתקשרים בעדכון הבא, גם אם אין חדש

## Output Format

**Crisis Communications Plan — [אירוע] — [תאריך/שעה]**

```
SITUATION ASSESSMENT
חומרה: [P0 / P1 / P2]
קהלים מושפעים: [...]
מה ידוע: [...]
מה לא ידוע: [...]
Deadline לתגובה ראשונה: [...]

MESSAGING HOUSE (עקרונות התקשורת)
Core Message: "[מה שאנחנו אומרים בכל פלטפורמה]"
מה שאנחנו לא אומרים: [...]
מי מדבר (Spokesperson): [...]

HOLDING STATEMENT (לשלוח עכשיו — לפני שיש כל התמונה)
"אנחנו מודעים ל[X]. אנחנו בוחנים את הנושא בדחיפות ונעדכן תוך [X שעות]. [אם רלוונטי: הצעדים שנקטנו כרגע הם ...]"

---

MESSAGE TO EMPLOYEES (פנימי)
[גרסה מלאה ואנושית — אין place for spin כלפי עובדים]

MESSAGE TO CUSTOMERS
[ממוקד בהם: מה המשמעות עבורם | מה עושים עכשיו | מה הצעד הבא]

STATEMENT TO MEDIA (אם נדרש)
[קצר | עובדתי | לא מתגונן | מסתיים ב-next steps]

ESCALATION PROTOCOL
[שעה 0: Holding Statement]
[שעה 2: עדכון פנימי לצוות]
[שעה 6: עדכון לקוחות אם נפגעו]
[24 שעות: Post-mortem ראשוני]

WHAT NOT TO DO
✗ לא להגיד "לא ידענו"
✗ לא להאשים גורם חיצוני לפני בדיקה
✗ לא להבטיח מה שלא בשליטתך
✗ לא לשתוק יותר מ-X שעות
```

**Quick Prompts**
- "We had a data breach — customer data may have been exposed — help me write the crisis communications"
- "A key employee posted something damaging on social media — I need internal and external statements"
- "Our product failed for 4 hours and major customers were affected — what do I say and how?"
