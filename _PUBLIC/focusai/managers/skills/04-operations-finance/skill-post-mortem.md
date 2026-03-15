---
name: post-mortem
description: Run blameless, action-oriented project post-mortems that produce real learning and systemic fixes. Auto-load when user asks to run a post-mortem, retrospective, or incident review.
argument-hint: "[what happened, when, teams involved, impact of the incident or failure, current status]"
---

# Post-Mortem — ניתוח אירוע ולמידה ארגונית

Post-mortem שמסתיים ב"נהיה יותר זהירים" הוא חסר ערך. Post-mortem טוב מזהה את הסיבות המערכתיות — לא אנשים — ומייצר שינויים שמונעים חזרה על האירוע. Blameless לא אומר no-accountability — זה אומר שהמטרה היא הבנה, לא ענישה.

## What to Provide
- תיאור האירוע (מה קרה, מתי, כמה זמן נמשך)
- צוותים מעורבים
- השפעה: על לקוחות? הכנסות? מוניטין? זמינות מערכת?
- טיימליין של הדברים כפי שהתרחשו
- מה נעשה לתיקון מיידי
- מה ה-gaps הידועים שהובילו לאירוע

## How Claude Works Through This
1. **בונה Timeline** — מה קרה בדיוק, בסדר כרונולוגי, ללא שיפוטיות
2. **מזהה Contributing Factors** — מה ה-5 Whys? מה הסיבה לסיבה?
3. **מפריד סיבת שורש ממנגנון ההתרחשות** — מה גרם לבעיה? מה אפשר לה להשפיע?
4. **מגדיר Action Items** — ספציפיים, עם בעלים ותאריך, ממוינים לפי impact
5. **מציע שיפורים מערכתיים** — מה לשנות בתהליך, בכלים, בתקשורת — לא "לשים לב יותר"

## Output Format
- **Executive Summary** — 3-5 משפטים על מה קרה ומה ההשפעה
- **Timeline** — כרונולוגיה עם timestamps
- **Root Cause Analysis** — 5 Whys + Contributing Factors
- **Action Items** — טבלה: פעולה / בעלים / תאריך / priority
- **What Went Well** — מה עבד גם תחת לחץ (חשוב: מגדיל נכונות לדווח בעתיד)
- **Learning for the Org** — מה כל הארגון יכול ללמוד מזה

**Quick Prompts**
- "עשינו deploy שהוריד את האתר ל-4 שעות — עזור לי לנהל post-mortem"
- "פספסנו delivery ללקוח גדול בגלל תקלת תקשורת בין Sales ל-Operations — ניתוח"
- "קמפיין שיווקי יצא עם שגיאה מביכה — עזור לי לנתח מה קרה ולמנוע הפעם הבאה"
