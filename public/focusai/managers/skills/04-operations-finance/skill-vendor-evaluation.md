---
name: vendor-evaluation
description: Evaluate and select vendors or suppliers using a structured scoring framework and risk analysis. Auto-load when user asks to evaluate vendors, compare suppliers, or choose between service providers.
argument-hint: "[what you're buying, vendors being considered, key decision criteria, budget, timeline]"
---

# הערכת ספקים ובחירת ורנדור

בחירת ספק לא נכון עולה לא רק כסף — היא עולה זמן, אמון, ולעיתים לקוחות. תהליך הערכה מובנה מונע החלטה רגשית ומאפשר לך להגן על הבחירה שלך מול כל stakeholder.

## What to Provide
- מה אתה רוכש (SaaS, שירות, ציוד, outsourcing)
- ספקים בהשוואה (שמות)
- קריטריוני ההחלטה המרכזיים (מחיר, quality, support, שילוב טכני, מוניטין, גמישות)
- תקציב מוגדר / טווח
- טיימליין לקבלת החלטה
- מי בארגון מושפע מהבחירה

## How Claude Works Through This
1. **מגדיר קריטריוני הערכה** — ממיר את הצרכים לקריטריונים ניתנים לציון, עם משקל לכל אחד
2. **בונה Scorecard** — טבלת השוואה ספק × קריטריון עם ציון 1-5
3. **מציין שאלות לכל ספק** — מה לשאול בדמו, מה לבקש ב-POC, מה לקרוא בחוזה
4. **מזהה סיכונים** — vendor lock-in, חוסר stability, SLA בעייתי, hidden costs
5. **ממליץ ומציע Negotiation Tactics** — מה לנסות לשפר בהצעה לפני חתימה

## Output Format
- **Weighted Scorecard** — טבלה מלאה עם ניקוד כולל לכל ספק
- **Red Flags רשימה** — מה לשים לב אליו בכל ספק ספציפי
- **שאלות לדמו / POC** — 10-15 שאלות ממוקדות
- **Risk Summary** — סיכונים עיקריים לכל ספק
- **המלצה** — איזה ספק ולמה, עם הצדקה

**Quick Prompts**
- "אני בוחר בין HubSpot ל-Salesforce לצוות מכירות של 15 אנשים — עזור לי לבנות scorecard"
- "אנחנו בוחרים ספק לוגיסטיקה — בנה מסגרת הערכה לספקי fulfillment"
- "קיבלתי 4 הצעות מחיר לפיתוח מיקור חוץ — בנה לי framework לבחירה שמתחשב גם בסיכון"
