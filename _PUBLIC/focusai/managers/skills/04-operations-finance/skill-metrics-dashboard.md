---
name: metrics-dashboard
description: Design KPI dashboards and metrics frameworks that drive decisions, not just reporting. Auto-load when user asks to design a dashboard, define KPIs, or build a metrics framework.
argument-hint: "[team or department, business goals, decisions the dashboard should support, audience (ops / exec / board)]"
---

# עיצוב Dashboard ומדדי ביצוע (KPIs)

Dashboard שאף אחד לא מסתכל עליו הוא בזבוז. Dashboard שמצביע בדיוק מה לעשות אחרת הוא נכס ניהולי. ההבדל הוא לא הכלי — הוא השאלות שמאחורי המספרים.

## What to Provide
- מחלקה / תחום (Sales, Product, CS, Marketing, Operations)
- מה המטרות האסטרטגיות שה-dashboard אמור לתמוך בהן
- אילו החלטות אמור ה-dashboard לסייע בהן?
- קהל: תפעולי (יומי) / ניהול ביניים (שבועי) / C-Level / דירקטוריון
- כלים קיימים (CRM, BI tool, Sheets, etc.)
- מה המדדים הנוכחיים אם יש

## How Claude Works Through This
1. **מגדיר North Star Metric** — מדד אחד שמסכם הצלחה לתקופה
2. **מסדר מדדים בהיררכיה** — North Star → Input Metrics → Health Metrics → Operational Metrics
3. **מגדיר כל מדד בדיוק** — שם, נוסחת חישוב, תדירות, מי אחראי, מה target
4. **מזהה Leading ו-Lagging Indicators** — מה מנבא, מה מסכם
5. **מציע פריסה ויזואלית** — איך לסדר את ה-widgets, מה "מעל הקפל", מה לפי דרישה

## Output Format
- **Dashboard Architecture** — שלבי מידע: Quick Glance / Performance / Drill-Down
- **KPI Definitions Table** — שם / נוסחה / תדירות / בעלים / target / ירוק-אדום
- **Leading vs. Lagging Split** — אילו מדדים לפעול עליהם מוקדם
- **Suggested Layout** — wire-frame טקסטואלי של ה-dashboard
- **Review Cadence** — מה בודקים יומי, שבועי, חודשי

**Quick Prompts**
- "עצב dashboard ל-VP Sales: pipeline health, conversion, ARR, churn, forecast accuracy"
- "בנה מדדי KPI לצוות Customer Success — onboarding, NPS, health score, expansion"
- "אני צריך Executive Dashboard חודשי לדירקטוריון: 5-7 מדדים שמספרים את סיפור החברה"
