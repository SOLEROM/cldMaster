---
name: interview-kit
description: Build structured interview kits with scorecards, questions by competency, and calibration guides. Auto-load when user asks to build an interview process or interview scorecard.
argument-hint: "[job title, key competencies to assess, number of interview rounds]"
---

# ערכת ראיון מובנית עם סקורקארד

ראיון לא מובנה הוא הגרלה. ראיון מובנה עם סקורקארד מגדיל את הדיוק בגיוס ב-50% ומוריד bias — כי כולם שואלים את אותן שאלות ומדרגים לפי אותם קריטריונים.

## What to Provide
- תפקיד ורמת סניוריטי
- 3-5 קומפטנציות קריטיות להצלחה בתפקיד
- מבנה תהליך הראיון (כמה שלבים, מי מראיין בכל שלב)
- האם צריך case study / מטלה מעשית
- ערכים ותרבות ארגונית שרוצים לבדוק

## How Claude Works Through This
1. **מגדיר קומפטנציות** — ממיר את הדרישות לתכונות הניתנות לבדיקה (Execution, Leadership, Communication, etc.)
2. **בונה שאלות STAR לכל קומפטנציה** — 3-4 שאלות behavioral עם followup מומלץ
3. **יוצר סקורקארד** — טבלת דירוג 1-4 עם עוגנים התנהגותיים (מה נראה בכל ציון)
4. **מציין אדום / ירוק לכל קומפטנציה** — Green flags ו-Red flags שיש לשים לב אליהם
5. **מוסיף מדריך calibration** — איך הצוות מסכם יחד ומחליט

## Output Format
- **סקורקארד** — טבלה עם קומפטנציות, ציון 1-4, הערות
- **שאלות לפי שלב ראיון** — מי שואל מה, כמה זמן
- **עוגנים להחלטה** — מה ציון 4 נראה, מה ציון 1 נראה
- **Green / Red flags** לכל קומפטנציה
- **הוראות debrief** לצוות המגייס

**Quick Prompts**
- "בנה ערכת ראיון ל-Head of Engineering, 3 שלבים, עם דגש על leadership, technical depth, communication"
- "צור סקורקארד לראיון מכירות SDR, בדגש על resilience, coachability, urgency"
- "בנה ערכת ראיון ל-Operations Manager עם case study על תעדוף משימות"
