---
name: churn-analysis
description: Analyze churn reasons and build retention interventions. Auto-load when user asks to reduce churn, understand why customers leave, or build a retention strategy.
argument-hint: "[נתוני Churn קיימים, סוג מוצר, ממוצע ACV, מה ידוע על הסיבות, מה כבר ניסיתם]"
---

# Churn Analysis — ניתוח נטישה ובניית שימור

הבנה עמוקה של למה לקוחות עוזבים — ובניית מניעות ממוקדות שעובדות לפני שמאוחר מדי.

## What to Provide
- Churn Rate נוכחי (% חודשי/שנתי)
- סוגי Churn ידועים: מה הלקוחות אומרים כשעוזבים?
- מאפייני לקוחות שעוזבים לעומת נשארים (אם ידוע)
- שלב ב-Lifecycle שרוב הנטישה קורית
- מה כבר ניסיתם למנוע (ומה לא עבד)
- נתונים זמינים: exit surveys / שיחות / דוחות

## How Claude Works Through This
1. **Churn Taxonomy** — סיווג סיבות הנטישה לקטגוריות (Product / Price / Competition / Success / Life Events)
2. **Cohort Hypothesis** — זיהוי איזה סגמנט לקוחות בסיכון גבוה ביותר ולמה
3. **Root Cause Analysis** — חפירה לסיבה האמיתית (לא הסימפטום) מאחורי הנטישה
4. **Intervention Playbook** — פעולות מניעה לכל סיבת נטישה (מוקדמות / מאוחרות)
5. **Retention Experiment Design** — 3–5 ניסויים הניתנים למדידה עם Hypothesis ברורה

## Output Format
**Churn Analysis Report:**
- Churn Breakdown לפי קטגוריות (ממוין לפי השפעה)
- Risk Profile — מי הלקוח שצפוי לעזוב (ולמה)
- Root Cause Summary (לא רשימת תלונות — ניתוח עמוק)
- Intervention Matrix (סיבה / מניעה / בעלים / KPI)
- 30-Day Retention Sprint Plan — מה עושים עכשיו
- Exit Interview Script — לאסוף דאטה על הבא

**Quick Prompts**
- "Churn שלנו עמד על 8% בחודשיים האחרונים — עזור לי להבין למה ומה עושים"
- "לקוחות שמשתמשים פחות מ-3 פעמים בשבוע נוטשים פי 3 — בנה Intervention Plan"
- "תכנן Exit Interview Survey שיגלה את הסיבה האמיתית לנטישה ב-SaaS B2B"
