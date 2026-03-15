---
name: mvp-design
description: Design the minimal viable scope for a new product or feature. Auto-load when user asks to define an MVP, cut scope, or decide what to build first.
argument-hint: "[תיאור המוצר/פיצ'ר, בעיה שפותרת, קהל יעד, מה כבר קיים, deadline/תקציב]"
---

# MVP Design — עיצוב מינימום מוצר ריאלי

הפרדה בין מה שנחמד לבנות למה שצריך לבדוק ב-90 הימים הקרובים. הכלי עוזר לחדד את שאלת ה-Riskiest Assumption ולבנות את הגרסה הקטנה ביותר שתוכיח ערך.

## What to Provide
- תיאור המוצר/פיצ'ר ומה הוא פותר
- מי המשתמשים הראשונים (Early Adopters)
- מה כבר קיים (קוד / מוצר / לקוחות / ידע)
- הנחת הסיכון הגבוהה ביותר שעוד לא בדקתם
- אילוצים: זמן / תקציב / צוות
- KPI להצלחת ה-MVP

## How Claude Works Through This
1. **Assumption Mapping** — מזהה את ההנחות שהמוצר עומד עליהן, ממדר לפי סיכון
2. **Job-to-be-Done הגדרה** — מה המשתמש מנסה להשיג ולמה הפתרון הנוכחי לא מספיק
3. **Feature Triage** — מסווג פיצ'רים ל-Must / Should / Could / Won't (MoSCoW)
4. **MVP Scope** — הגדרת הגרסה הקטנה ביותר שתספק תשובה לשאלה הגדולה ביותר
5. **Experiment Design** — איך מודדים הצלחה ומה ה-Go/No-Go Criteria

## Output Format
**MVP Blueprint:**
- Problem Statement (1 פסקה)
- Riskiest Assumptions (ממוינות לפי סיכון)
- Feature List מלא עם MoSCoW Classification
- MVP Scope — מה כן / מה לא (ולמה)
- Success Metrics וקריטריון הצלחה מדיד
- לו"ז מוצע לבנייה + Milestone ראשון

**Quick Prompts**
- "הגדר MVP לפלטפורמת matching בין פרילנסרים לחברות — מה לבנות ראשון?"
- "יש לי 60 יום ו-2 מפתחים — מה ה-MVP למוצר ניהול פרויקטים לחברות בנייה?"
- "עזור לי לחתוך סקופ — יש לנו 40 פיצ'רים בbacklog ויש לשחרר תוך חודשיים"
