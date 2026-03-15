---
name: stakeholder-email
description: Write clear, professional stakeholder update emails that build trust and drive action. Auto-load when user asks to write a stakeholder email, update stakeholders, or communicate project status by email.
argument-hint: "[stakeholder relationship, what happened, what they need to know, what action you need from them]"
---

# Stakeholder Email Writer

כותב אימיילים לבעלי עניין שנקראים, מובנים, ומניעים לפעולה — לא מיילים שנשלחים ל-"I'll read this later" ונשכחים שם.

## What to Provide
- מי הנמען: משקיעים / דירקטוריון / שותפים / לקוחות אסטרטגיים / ספקים מרכזיים
- מה הקשר: עדכון שוטף / חדשות בעיות / הודעה / בקשה
- מה קרה (עובדות, לא spin)
- מה אתה צריך מהם: תגובה / אישור / עזרה / רק מידע
- מה הטון הנדרש: Formal / Warm / Urgent / Routine
- deadline אם יש

## How Claude Works Through This
1. **זיהוי ה-One Thing** — קובע מה ה-single most important thing שהנמען צריך לקחת מהמייל
2. **Subject Line** — כותב 3 אפשרויות לשורת נושא שנפתחת
3. **מבנה BLUF** — Bottom Line Up Front: המסר הראשי בשורה הראשונה, פרטים אחרי
4. **טון מכוון** — מתאים את הניסוח לסוג הקשר (משקיע vs. לקוח vs. ספק)
5. **CTA ברור** — מסיים עם בקשה ספציפית + deadline + הוראות מדויקות

## Output Format

**Stakeholder Email — [נמען] — [נושא]**

```
SUBJECT LINE OPTIONS (בחר אחת)
Option A: [ישיר ומדויק]
Option B: [ממוקד בתוצאה]
Option C: [urgent אם רלוונטי]

---

[EMAIL BODY]

שלום [שם],

[פסקה 1 — Bottom Line Up Front: מה קרה / מה אנחנו מבקשים — 2-3 משפטים]

[פסקה 2 — רקע ופרטים — רק מה שצריך, לא יותר]

[פסקה 3 — מה אנחנו עושים / איך זה ישפיע עליך]

[פסקה 4 — ה-Ask + Deadline + הנחיות ברורות]

[חתימה]

---

TONE NOTES
הסבר: [למה הטון הזה מתאים לקשר הזה]

ALTERNATIVE VERSION (אם הודעה רגישה)
[גרסה שניה שקצת יותר / פחות פורמלית]
```

**Quick Prompts**
- "Write a monthly investor update email — we're growing but missed our MRR target by 15%"
- "Draft a stakeholder email explaining a 2-month project delay to a key client"
- "I need to email our board members about an unexpected executive departure — keep it controlled"
