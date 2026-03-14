---
name: retention-plan
description: Build employee retention plans targeting flight risks, key talent, and structural churn causes. Auto-load when user asks about employee retention, keeping talent, or reducing turnover.
argument-hint: "[team size, current turnover rate, top retention risks, budget/constraints]"
---

# תוכנית שימור עובדים

גיוס עובד חדש עולה פי 1.5-3 ממשכורתו. שימור עובד טוב הוא ההחלטה הפיננסית הנכונה ביותר שמנהל יכול לקבל. אבל שימור אמיתי מתחיל 6 חודשים לפני שהעובד חושב לעזוב.

## What to Provide
- גודל הצוות וקצב ה-turnover הנוכחי
- מי ה-key people שאסור לאבד
- סיבות עזיבה ידועות (שכר? צמיחה? תרבות? מנהל?)
- מה ה-tools הזמינים (תקציב, גמישות, קידום, הכשרה)
- אילו עובדים אתה מזהה כ-flight risk

## How Claude Works Through This
1. **ממפה סיבות שורש** — מפריד בין retention שאפשר לשלוט בו לבין כזה שלא
2. **מזהה segments** — Key Talent, Flight Risks, Satisfied, Passive — אסטרטגיה שונה לכל קבוצה
3. **בונה תוכנית לכל segment** — שיחות, יעדים, פיתוח, compensation review
4. **מציע Stay Interviews** — שאלות לזיהוי מה שומר ומה מרחיק — לפני שהעובד מגיע עם מכתב
5. **מגדיר מדדים** — איך תדע שהתוכנית עובדת? מה KPIs ל-retention?

## Output Format
- **Retention Segments Map** — טבלה: מי בכל קבוצה ואסטרטגיה מומלצת
- **Stay Interview Script** — 8-10 שאלות עם הוראות ניהול השיחה
- **Action Plan לכל Flight Risk** — מה עושים השבוע, בחודש הקרוב, ב-Q
- **Structural Fixes** — מה לתקן ברמת מדיניות (לא רק אישי)
- **Retention Dashboard** — מדדים לעקוב אחריהם חודשית

**Quick Prompts**
- "אני מאבד 2-3 עובדים ברבעון בצוות הפיתוח, עזור לי לבנות תוכנית שימור"
- "יש לי 3 עובדי מפתח שאני חושש שיעזבו ב-6 חודשים — מה אני עושה?"
- "הצוות מתלונן על חוסר צמיחה — בנה לי תוכנית retention שמתבססת על learning ו-career paths"
