---
name: business-case
description: Build a rigorous business case for any project, investment, or initiative. Auto-load when user asks to justify a project, build a business case, or get budget approval.
argument-hint: "[project/investment name, cost estimate, expected benefit, decision-maker audience]"
---

# Business Case Builder

בונה תיק עסקי משכנע לפרויקט, השקעה, או יוזמה — כזה שמנהלים בכירים ידרשו ממך לפני שיאשרו תקציב.

## What to Provide
- תיאור הפרויקט / ההשקעה / היוזמה
- עלויות צפויות (חד-פעמיות + שוטפות)
- תועלות צפויות (כמותיות ואיכותיות)
- מי מקבל ההחלטה (CFO? דירקטוריון? שותף?)
- לוח זמנים מצופה
- אלטרנטיבות שנשקלו (אם יש)
- כל נתון רלוונטי: שוק, מתחרים, מגמות

## How Claude Works Through This
1. **הגדרת הבעיה / ההזדמנות** — מנסח בחדות מה הבעיה שהפרויקט פותר ומה עולה לא לעשות אותו
2. **ניתוח עלות-תועלת** — בונה מודל פיננסי פשוט: ROI, payback period, NPV (לפי הנתונים שסיפקת)
3. **ניתוח אלטרנטיבות** — משווה אפשרויות: לעשות / לא לעשות / גרסה מוקטנת
4. **ניתוח סיכונים** — מזהה את הסיכונים הקריטיים ואיך מתמודדים איתם
5. **המלצה ותוכנית פעולה** — תמצית ברורה עם ה"ask" המדויק

## Output Format

**Business Case — [שם הפרויקט]**

```
EXECUTIVE SUMMARY
מה אנחנו מציעים, למה עכשיו, וכמה זה עולה/שווה (3-4 משפטים)

SECTION 1: הצגת הבעיה
- מצב נוכחי ומה זה עולה לנו (כסף, זמן, סיכון)
- למה פתרון חיוני עכשיו

SECTION 2: הפתרון המוצע
- תיאור הפרויקט
- מה כלול ומה לא כלול (scope)
- לוח זמנים

SECTION 3: ניתוח פיננסי
[טבלה: עלויות חד-פעמיות / שוטפות]
[טבלה: תועלות צפויות לפי שנה]
ROI: X%  |  Payback: X חודשים  |  Year-3 NPV: ₪X

SECTION 4: אלטרנטיבות שנשקלו
אפשרות A: [עשה הכל] — יתרון / חיסרון
אפשרות B: [לא לעשות] — מה הסיכון
אפשרות C: [גרסה מוקטנת] — trade-offs

SECTION 5: סיכונים ומיטיגציה
[סיכון | הסתברות | השפעה | תגובה]

SECTION 6: המלצה ו-ASK
[בקשה ספציפית: תקציב, אישור, משאבים]
```

**Quick Prompts**
- "Build a business case for hiring a VP of Sales — cost ₪400K/year, expected revenue impact ₪2M"
- "I need a business case for migrating our infrastructure to the cloud, audience is CFO"
- "Create a business case for launching a new product line, I need board approval next week"
