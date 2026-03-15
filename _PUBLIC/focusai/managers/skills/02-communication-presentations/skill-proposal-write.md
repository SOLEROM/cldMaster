---
name: proposal-write
description: Write a compelling business proposal or RFP response that wins work. Auto-load when user asks to write a proposal, respond to an RFP, or create a commercial offer.
argument-hint: "[client name, what they need, what you're proposing, price range, decision timeline]"
---

# Business Proposal Writer

כותב הצעות עסקיות שנקראות — לא PDF שנשלח ל-"נעיין בו" ונשכח. הצעה שמוכרת את הפתרון, בונה אמון, ומקלה על ה-yes.

## What to Provide
- שם הלקוח / הארגון וענף הפעילות
- מה הצורך / הבעיה שלהם (כפי שהבנת)
- מה אתה מציע לעשות (scope)
- מחיר / טווח מחיר
- ציר זמן לביצוע
- ה-USP שלך — למה אתה, לא המתחרים
- האם יש RFP ספציפי עם דרישות טכניות

## How Claude Works Through This
1. **Executive Summary ממוקד** — פותח בצד הלקוח: הבעיה שלו, לא הפתרון שלך
2. **Understanding of Need** — מוכיח שהבנת את הלקוח לפני שמציע פתרון (זה מה שמבדיל הצעות)
3. **Solution Section** — מפרט את הפתרון בשפת הלקוח: תוצאות, לא features
4. **Pricing בהירה** — לא מחיר אחד עם הרבה כוכביות, אלא מבנה ברור עם מה כלול ומה לא
5. **Why Us + Social Proof** — ראיות שמסביר למה לבחור בך: מקרי עבר, ציטוטים, תוצאות

## Output Format

**Business Proposal — [לקוח] — [נושא]**

```
COVER PAGE
[שם חברה שלך] | הצעה עסקית ל[שם לקוח]
תאריך: [...] | תקף עד: [...]
איש קשר: [...]

---

EXECUTIVE SUMMARY (חצי עמוד — הכי חשוב)
[מה הבעיה של הלקוח בשתי שורות]
[מה אנחנו מציעים ומה התוצאה שהם יקבלו]
[מה ה-investment ומה ה-ROI הצפוי]
[למה אנחנו הבחירה הנכונה — משפט אחד]

SECTION 1: UNDERSTANDING YOUR CHALLENGE
[תיאור הבעיה כפי שהלקוח מרגיש אותה — בשפתו]
[מה עולה להם לא לפתור את זה]
[מה שינוי מוצלח ייראה כמו עבורם]

SECTION 2: OUR PROPOSED SOLUTION
[מה אנחנו עושים — שלב אחרי שלב]
[לוח זמנים]
[מה כלול בהצעה | מה לא כלול (חשוב!)]
[Deliverables — מה מקבלים בסוף]

SECTION 3: INVESTMENT
Package / פרויקט: ₪[X]
  כולל: [...]
  לא כולל: [...]

אפשרות אחרת (אם רלוונטי):
  Package Premium: ₪[X] — מה מוסיף

תנאי תשלום: [...]
תוקף ההצעה: [...]

SECTION 4: WHY US
[3-4 נקודות מבדלות — לא generic]

CASE STUDIES / REFERENCES
לקוח דומה 1: [תיאור + תוצאה מספרית]
לקוח דומה 2: [...]

SECTION 5: NEXT STEPS
[מה קורה אחרי שמאשרים: שלב 1 / 2 / 3]
[מה צריך מהלקוח]
[איך לאשר: חתימה / מייל / שיחה]

---

INTERNAL NOTES (לא חלק מההצעה)
נקודות להדגיש בשיחה: [...]
התנגדויות צפויות + תשובות: [...]
```

**Quick Prompts**
- "Write a proposal for a 6-month AI implementation project for a manufacturing company, budget ₪150K"
- "Help me respond to an RFP for digital transformation consulting — they want 3-year roadmap"
- "Write a proposal for ongoing monthly retainer work with a startup — ₪8,000/month"
