---
name: unit-economics
description: Calculate, interpret, and improve unit economics — CAC, LTV, payback period, and gross margin per unit. Auto-load when user asks to analyze unit economics, calculate LTV/CAC, or understand business model profitability.
argument-hint: "[business model, revenue per customer, cost to acquire, churn rate, gross margin]"
---

# Unit Economics — CAC, LTV, Payback

Unit economics הן מה שמחלק חברות שנראות "מגניבות" לחברות שבאמת עובדות. אתה יכול לצמוח מהר ועדיין לשרוף כסף לכל לקוח — בלי לדעת זאת. ה-skill הזה חושף את המציאות ומציע דרך לשפרה.

## What to Provide
- מודל עסקי (SaaS, E-commerce, Marketplace, Services, etc.)
- הכנסה ממוצעת ללקוח (MRR / ARR / AOV)
- עלות רכישת לקוח (CAC) — אם לא ידוע, תיאור תהליך גיוס + הוצאות שיווק ומכירות
- Churn rate (אם SaaS)
- Gross Margin %
- כמה לקוחות יש כרגע ובאיזה tempo גדל

## How Claude Works Through This
1. **מחשב CAC** — Total Sales & Marketing / New Customers Acquired (בחודש / רבעון)
2. **מחשב LTV** — ARPU × Gross Margin / Churn Rate (SaaS) — או Average Order × Purchase Frequency × Lifespan (e-comm)
3. **מחשב LTV:CAC ו-Payback Period** — מה ביצועי הנורמה לפי תעשייה ושלב
4. **מזהה את ה-lever החזק ביותר** — מה הכי משנה: להוריד CAC / להעלות LTV / להוריד churn?
5. **מציע 3 התערבויות** — פעולות ספציפיות להשיג שיפור ב-12 חודש

## Output Format
- **טבלת חישוב** — CAC, LTV, Payback, LTV:CAC Ratio
- **Benchmark Comparison** — איפה אתה ביחס לנורמה בתעשייה
- **Sensitivity Analysis** — מה קורה אם Churn ירד ב-1%? CAC ירד ב-20%?
- **Improvement Levers** — מה לשנות ומה השפעתו המוערכת
- **Dashboard Template** — מה למדוד חודשית כדי לעקוב אחרי שיפור

**Quick Prompts**
- "המוצר שלי: SaaS, $150/חודש ARPU, Churn 5% חודשי, CAC $900, Gross Margin 75% — איך אני עומד?"
- "אנחנו e-commerce, AOV 280 ש\"ח, לקוח קונה בממוצע 2.3 פעמים בשנה, CAC 85 ש\"ח — חשב unit economics"
- "עזור לי להבין איזה lever להפעיל: הוריד churn מ-4% ל-2% vs. הוריד CAC ב-30%"
