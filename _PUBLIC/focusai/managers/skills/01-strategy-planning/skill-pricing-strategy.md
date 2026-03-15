---
name: pricing-strategy
description: Develop a pricing model and strategy for a product or service. Auto-load when user asks to set prices, design a pricing model, or evaluate whether current pricing is right.
argument-hint: "[product/service description, target customer, current pricing if exists, competitors' pricing, cost structure]"
---

# Pricing Strategist

מפתח מודל תמחור שמרבה הכנסות מבלי לאבד לקוחות — עם הנמקה עסקית, לא רק מספרים מהאוויר.

## What to Provide
- תיאור המוצר / השירות ומה הערך שהוא מספק
- קהל יעד וה-ICP (לקוח אידיאלי)
- מבנה עלויות: עלויות משתנות, קבועות, ו-COGS
- מחירי מתחרים (אם ידוע)
- המחיר הנוכחי שלך ומה לא עובד בו
- מה הלקוחות אומרים על מחיר

## How Claude Works Through This
1. **בחירת מתודולוגיית תמחור** — מעריך: Cost-Plus, Value-Based, Competitive, Freemium, Usage-Based — ממליץ על מה מתאים ולמה
2. **מחקר רצון לשלם** — מנתח את הנתונים הקיימים ומציע שאלות לבדיקת WTP
3. **עיצוב מבנה תמחור** — Tiers? Packages? One-time vs. recurring? Add-ons?
4. **ניתוח רגישות** — מה קורה ל-LTV, churn, CAC לפי תרחישי מחיר שונים
5. **תכנית מעבר** — אם יש שינוי מחיר: איך לעשות אותו בלי לפגוע בלקוחות קיימים

## Output Format

**Pricing Strategy — [מוצר/שירות] — [תאריך]**

```
PRICING PHILOSOPHY
"אנחנו תמחר לפי [value / cost / competition] כי [הנמקה]"

RECOMMENDED MODEL: [שם]
למה זה מתאים: [...]
למה לא [חלופה]: [...]

PRICING STRUCTURE

Tier 1 — [שם]: ₪[X]/חודש (או חד-פעמי)
  כולל: [...]
  מתאים ל: [ICP]
  מטרה: [acquisition / revenue / upsell hook]

Tier 2 — [שם]: ₪[X]/חודש
  כולל: [...]
  מה מוסיף על Tier 1: [...]

Tier 3 — [Enterprise / Custom]
  תמחור: לפי הצעה
  גורמי מחיר: [...]

UNIT ECONOMICS
עלות COGS לעסקה: ₪[X]
Gross Margin ב-Tier 2: [%]
LTV מצופה: ₪[X]
LTV:CAC יעד: [3:1 / 5:1]

PRICE CHANGE PLAYBOOK (אם רלוונטי)
[איך לתקשר עלייה / שינוי מבנה ללקוחות קיימים]

TEST BEFORE COMMITTING
[2-3 דברים שכדאי לבדוק לפני שמשנים מחיר]
```

**Quick Prompts**
- "I'm launching a B2B SaaS, help me design a 3-tier pricing model, my COGS is ₪50/customer/month"
- "Should I switch from one-time payment to subscription? Currently charging ₪2,000 one-time"
- "Our competitors charge $99/month and we charge $149 — are we pricing ourselves out?"
