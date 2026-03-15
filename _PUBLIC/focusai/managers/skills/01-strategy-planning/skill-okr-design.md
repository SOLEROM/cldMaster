---
name: okr-design
description: Design a complete OKR set for a company, department, or team. Auto-load when user asks to write OKRs, define objectives, or set key results.
argument-hint: "[team/company name, quarter, top priorities, current performance data]"
---

# OKR Designer

מעצב OKRs שמנהלים ועובדים יקחו ברצינות — לא buzz-words ריקות, אלא יעדים עם שיניים שמניעים התנהגות.

## What to Provide
- מי מרכיב את ה-OKRs: חברה / מחלקה / צוות ספציפי
- רבעון ושנה
- אסטרטגיה או עדיפויות עליונות הרלוונטיות
- מדדים נוכחיים (baseline) — מה אנחנו מודדים כיום
- מה הצלחה נראית כמו בסוף הרבעון
- אתגרים ידועים שצריך לשים לב אליהם

## How Claude Works Through This
1. **הגדרת Objectives** — מנסח 3-5 Objectives שמעוררים השראה, ממוקדים בתוצאה, ולא מתחילים ב"לעשות"
2. **בניית Key Results** — לכל Objective, 2-4 Key Results הניתנים לאימות כמותי ובינארי
3. **בדיקת איכות** — מוודא שכל KR עומד במבחן: "Is it measurable? Is 100% possible? Is 70% a stretch?"
4. **זיהוי תלויות** — ממפה אילו OKRs תלויים זה בזה ואיפה צריך תיאום בין צוותים
5. **הצעת Initiatives** — לכל KR, מציע 2-3 יוזמות קונקרטיות שיניעו את המחט

## Output Format

**OKR Set — [שם הצוות/חברה] — [רבעון/שנה]**

```
OBJECTIVE 1: [משפט השראתי, ממוקד בתוצאה]
  KR 1.1: [מדד ספציפי] מ-[X] ל-[Y] עד [תאריך]
  KR 1.2: [מדד ספציפי] מ-[X] ל-[Y] עד [תאריך]
  KR 1.3: [מדד ספציפי] מ-[X] ל-[Y] עד [תאריך]

  Initiatives:
  → [פעולה קונקרטית]
  → [פעולה קונקרטית]

OBJECTIVE 2: ...

SCORING GUIDE
70% = הצלחה (stretch goal הושג)
100% = יעד לא היה מספיק שאפתני

DEPENDENCIES MAP
[OKR X תלוי ב-OKR Y של צוות Z]

REVIEW CADENCE
- Weekly: בדיקת אינדיקטורים שבועיים
- Monthly: עדכון תחזיות ועדכון confidence score
- End of Quarter: scoring + תחקיר
```

**Quick Prompts**
- "Design OKRs for my product team for Q2 — focus: reducing churn and increasing feature adoption"
- "Write company-level OKRs for an early-stage startup, we want to hit product-market fit this year"
- "Our marketing team needs OKRs for Q3, goal is to generate 500 qualified leads per month"
