---
name: team-structure
description: Design org charts and team structures for growth — including reporting lines, roles, and hiring sequence. Auto-load when user asks to design a team structure, org chart, or plan team growth.
argument-hint: "[current team size, company stage, goals for next 12 months, budget constraints]"
---

# עיצוב מבנה צוות לצמיחה

מבנה ארגוני לא נכון הוא אחד הגורמים הנסתרים לאיטיות. כשאנשים לא יודעים למי הם שייכים, על מה הם אחראים, ואת מי הם עוצרים — כולם עובדים קשה ושום דבר לא מתקדם.

## What to Provide
- שלב החברה (Seed / A / B / Growth / Enterprise)
- גודל הצוות הנוכחי ומבנה קיים
- מטרות 12 חודש הבאים (מוצר, מכירות, לקוחות)
- אילו תפקידים קיימים, אילו חסרים
- תקציב גיוס משוער (כמה headcount?)
- בעיות ידועות במבנה הנוכחי

## How Claude Works Through This
1. **מאבחן את הבעיה** — מה לא עובד במבנה הנוכחי? gaps, overlaps, reporting בעייתי?
2. **מציע מבנה מטרה** — org design שמותאם לשלב ולמטרות (Squad / Functional / Matrix)
3. **מגדיר תפקידים** — מה כל role אחראי לו, ולמי הוא מדווח
4. **מציע רצף גיוס** — איזה hire ראשון, שני, שלישי — לפי leverage
5. **מזהה סיכונים** — single points of failure, תפקידים עם scope גדול מדי, dependencies

## Output Format
- **Org Chart טקסטואלי** (היררכי, עם ניתוח רמות)
- **Role Cards** — לכל תפקיד: אחריות, מדדי הצלחה, למי מדווח
- **Hiring Roadmap** — רצף גיוסים לפי quarter עם הצדקה
- **Risk Map** — מה שבור היום ומה נשבר בצמיחה
- **השוואת מבנים** — 2-3 אופציות עם trade-offs

**Quick Prompts**
- "עזור לי לתכנן מבנה צוות לחברת SaaS ב-Series A עם 25 עובדים, צריכים להכפיל ל-50 ב-18 חודש"
- "בנה מבנה צוות מכירות מ-0: VP Sales, SDRs, AEs, CS — מה ה-hiring sequence?"
- "המבנה שלי שבור: Product ו-Engineering מסוכסכים על ownership — תעזור לי לתקן"
