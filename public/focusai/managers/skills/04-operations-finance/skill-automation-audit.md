---
name: automation-audit
description: Audit business processes to identify automation opportunities, prioritized by ROI and implementation effort. Auto-load when user asks to find automation opportunities, audit manual processes, or identify what to automate.
argument-hint: "[department or workflow area, team size, tools currently in use, volume of repetitive tasks]"
---

# ביקורת אוטומציה — מה כדאי להפוך לאוטומטי

כ-60% מהעבודה הניהולית ניתנת לאוטומציה חלקית. הבעיה היא לא הטכנולוגיה — הבעיה היא שלא יודעים מה להתחיל. ה-audit הזה ממפה הזדמנויות, מעריך ROI, ומדרג לפי קלות ביצוע.

## What to Provide
- מחלקה או תחום (Sales, HR, Ops, Finance, Marketing, CS)
- כלים שכבר בשימוש (CRM, ERP, שיטות דיווח)
- גודל הצוות וזמן ממוצע על משימות ידניות
- תיאור של 5-10 תהליכים שנעשים ידנית כיום
- מה הכאב הגדול ביותר: זמן? שגיאות? מידע חסר? תגובה איטית?
- רמת בשלות טכנולוגית של הצוות

## How Claude Works Through This
1. **ממפה תהליכים ידניים** — מסדר לפי תדירות × זמן × שגיאות
2. **מזהה Automation Candidates** — מה ניתן לאוטמט עם tools קיימים (Zapier, Make, N8N, AI) לעומת מה שדורש פיתוח
3. **מחשב ROI** — שעות × עלות שעה × תדירות = חיסכון שנתי אל מול עלות הטמעה
4. **מדרג בטריצה** — Impact vs. Effort matrix, מזהה Quick Wins
5. **ממליץ על רצף הטמעה** — מה קודם, מה אחר כך, ומה לא לגעת בו

## Output Format
- **Process Inventory** — רשימת תהליכים + זמן ידני + תדירות
- **Automation Opportunities** — לפי שכבה: כלי קיים / no-code / code / AI
- **ROI Table** — חיסכון שנתי מוערך לכל אוטומציה
- **Impact/Effort Matrix** — ויזואלי טקסטואלי (High Impact/Low Effort = Do First)
- **Roadmap** — רצף ביצוע לפי רבעון
- **כלים מומלצים** — לכל use case בהתאם למה שכבר בשימוש

**Quick Prompts**
- "אני רוצה לבדוק מה אפשר לאוטמט במחלקת Sales Operations — צוות 6 אנשים, HubSpot + Excel"
- "עשה לי automation audit ל-HR: גיוס, onboarding, payroll דיווחים — כל זה ידני"
- "יש לנו Customer Success של 5 אנשים שמבזבזים 40% מהזמן על עדכוני סטטוס ידניים — מה לאוטמט?"
