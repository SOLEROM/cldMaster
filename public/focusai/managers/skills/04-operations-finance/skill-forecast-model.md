---
name: forecast-model
description: Build revenue and growth forecasts with explicit assumptions, scenarios, and sensitivity analysis. Auto-load when user asks to build a forecast, revenue model, or growth projection.
argument-hint: "[business model, current revenue/metrics, growth drivers, time horizon, known assumptions]"
---

# בניית מודל תחזית הכנסות וצמיחה

תחזית שלא מכילה הנחות מפורשות היא אופטימיזם בהתחפשות של spreadsheet. תחזית טובה לא ניבאת בדיוק — היא מסבירה כיצד להגיב כשהמציאות סוטה ממנה.

## What to Provide
- מודל עסקי (SaaS / E-commerce / Services / Marketplace)
- מדדי בסיס נוכחיים (MRR/ARR, לקוחות, pipeline)
- נהגי הצמיחה (new sales / expansion / upsell / שיווק)
- אופק זמן (6 חודש / שנה / 3 שנים)
- הנחות שיש לך כבר (growth rate, CAC, churn, average deal)
- מה ייעשה עם התחזית (משקיעים? Board? תכנון פנימי?)

## How Claude Works Through This
1. **מגדיר Building Blocks** — מזהה את ה-drivers שמניעים הכנסה לפי המודל העסקי
2. **בונה Bottom-Up + Top-Down** — Bottom-up מה אפשר להשיג, Top-down מה השוק מצפה
3. **מכתיב הנחות מפורשות** — כל מספר עם הנחה כתובה לידו
4. **מייצר 3 Scenarios** — Base / Optimistic (x1.3) / Conservative (x0.7) עם ההנחות השונות
5. **מוסיף Sensitivity Analysis** — מה הכי משנה אם הוא משתנה ב-10%?

## Output Format
- **Driver Tree** — מה מוביל להכנסה, בפירמידה ויזואלית
- **מודל חודשי / רבעוני** — טבלת הכנסה לפי תרחיש
- **Assumptions Sheet** — כל הנחה כתובה, עם source (היסטוריה / benchmark / ניחוש)
- **Sensitivity Table** — השפעת שינויים מרכזיים
- **Summary לדירקטוריון** — 3-4 bullets + מספר שנה אחת

**Quick Prompts**
- "עזור לי לבנות תחזית SaaS ל-2026: כרגע ARR $400K, Churn 3% חודשי, pipeline של 50 deals"
- "בנה מודל צמיחה לחברת שירותים ב2-3 שנים — הכנסה נוכחית 4M ש\"ח, רוצים להגיע ל-12M"
- "אני מציג למשקיעים — עזור לי לבנות מודל שמראה 3 תרחישים עם הנחות שקופות"
