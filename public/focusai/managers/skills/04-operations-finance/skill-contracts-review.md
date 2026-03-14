---
name: contracts-review
description: Review contract terms to flag risks, missing clauses, and negotiation opportunities — before you sign. Auto-load when user asks to review a contract, check terms, or analyze an agreement.
argument-hint: "[contract type, your role (buyer/seller/employer/employee), key terms you've seen, what concerns you]"
---

# סקירת חוזים ואיתור סיכונים

חוזה שלא נקרא בכוונה הוא פצצה מתקתקת. רוב הבעיות בחוזים לא נובעות מרצון רע של הצד השני — הן נובעות מסעיפים שנכתבו בשביל מצב שאתם לא חשבתם עליו. ה-skill הזה עוזר לך לסרוק, לזהות, ולנהל מו"מ.

## What to Provide
- סוג החוזה: עם לקוח / ספק / עובד / שותף / NDA / SaaS EULA / ייעוץ
- תפקידך בחוזה: קונה / מוכר / מעביד / עובד / מקבל שירות / נותן שירות
- תנאים שכבר ראית ומטרידים אותך
- סעיפים ספציפיים שרוצה לנתח
- מה המינוף שלך במו"מ?
- מה פרק הזמן לחתימה?

## How Claude Works Through This
1. **סורק לפי קטגוריות סיכון** — liability, termination, IP, exclusivity, payment terms, SLA, jurisdiction
2. **מדרג סיכונים** — Critical (לא לחתום בלי לתקן) / High / Medium / Low
3. **מזהה מה חסר** — סעיפים שבדרך כלל קיימים ופה לא (force majeure, indemnification, etc.)
4. **מציין Red Flags** — ניסוחים מעורפלים שיכולים להתפרש נגדך
5. **מכין Counter-Proposals** — ניסוחים חלופיים לסעיפים בעייתיים

## Output Format
- **Risk Summary** — ממצאים לפי דחיפות: Critical / High / Medium / Low
- **Clause-by-Clause Analysis** — לכל סעיף בעייתי: מה כתוב, מה הסיכון, מה לבקש במקום
- **Missing Clauses** — מה לא קיים ולמה זה בעיה
- **Negotiation Cheat Sheet** — מה לבקש, מה "trade" טוב, ומה קו אדום
- **Go / No-Go Summary** — האם לחתום as-is, עם תיקונים, או לא?

**Quick Prompts**
- "יש לי הסכם SaaS עם לקוח Enterprise — 3 שנים, קנסות ביציאה, SLA 99.9% — סרוק לי את הסיכונים"
- "קיבלתי NDA מחברה גדולה — מה בדרך כלל בעייתי ב-NDA, ומה לדרוש לשנות?"
- "חוזה עם ספק outsourcing — 12 חודש, תשלום מראש — מה הסעיפים שחייבים להיות שם?"
