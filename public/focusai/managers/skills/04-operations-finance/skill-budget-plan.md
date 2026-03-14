---
name: budget-plan
description: Build department or project budgets with line-item breakdown, assumptions, and variance tracking. Auto-load when user asks to build a budget, plan department spending, or create a financial plan for a project.
argument-hint: "[department or project, time period, known cost categories, revenue if relevant, constraints]"
---

# בניית תקציב מחלקה / פרויקט

תקציב שלא מבוסס על הנחות כתובות הוא ניחוש מסודר. תקציב טוב מכיל לא רק את המספרים אלא גם את ההנחות שמאחוריהם — כך שכאשר המציאות משתנה, יודעים בדיוק מה לשנות.

## What to Provide
- מחלקה / פרויקט
- תקופה (חודש / רבעון / שנה)
- קטגוריות הוצאה ידועות (Headcount, כלים, שיווק, נסיעות, ייעוץ, etc.)
- הכנסות צפויות אם רלוונטי
- אילו constraints קיימים (מקסימום הוצאה, יחס headcount להכנסה)
- מה המטרה: הגשה לדירקטוריון? תכנון פנימי? RFP?

## How Claude Works Through This
1. **מרצף קטגוריות** — ממיין הוצאות ל-Fixed / Variable / One-time
2. **בונה שורות line-item** — כל הוצאה עם כמות × מחיר × תדירות
3. **מכתיב הנחות מפורשות** — מה מניחים לגבי צמיחה, עונתיות, שינויי שכר
4. **מוסיף Contingency** — כמה רזרבה, לאיזו קטגוריה
5. **מציג Variance Framework** — מה +/- 10% אומר, אילו שינויים דורשים אישור מחדש

## Output Format
- **טבלת תקציב** — קטגוריה / שורה / הנחה / סכום חודשי / סכום שנתי
- **Executive Summary** — 3-5 משפטים על ה-key decisions בתקציב
- **הנחות מפורשות** — מה מוניחים ומדוע
- **Scenarios** — Base / Optimistic / Conservative (אם רלוונטי)
- **Variance Triggers** — מה גורם ל-replan

**Quick Prompts**
- "בנה תקציב שנתי למחלקת מכירות של 8 אנשים — SDRs, AEs, Manager — כולל כלים, נסיעות, events"
- "אני צריך תקציב לפרויקט השקת מוצר חדש — 6 חודשים, כולל שיווק, פיתוח, ו-ops"
- "בנה תקציב מחלקת HR לחברה ב-50 עובד, כולל גיוס, הכשרה, ו-benefits"
