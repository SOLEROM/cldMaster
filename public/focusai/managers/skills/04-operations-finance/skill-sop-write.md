---
name: sop-write
description: Write clear, complete Standard Operating Procedures that anyone can follow without supervision. Auto-load when user asks to write an SOP, procedure document, or work instruction.
argument-hint: "[process name, who performs it, frequency, tools used, key decisions involved]"
---

# כתיבת SOP — נוהל עבודה סטנדרטי

SOP טוב הוא הדבר שמאפשר לך לגדול בלי שכל מנהל יהיה צוואר בקבוק. אם רק אחד יודע איך לעשות משהו — זה סיכון. SOP מסיר את הסיכון הזה ומאפשר delegation אמיתי.

## What to Provide
- שם הנוהל ומה מטרתו
- מי מבצע אותו (role, לא שם)
- מתי ובאיזו תדירות
- כלים ומערכות מעורבות
- מה קורה אם יש סטייה / בעיה
- מה הציפיות מהתוצאה הסופית

## How Claude Works Through This
1. **מגדיר scope ו-purpose** — מה ה-SOP מכסה, מה לא, מה הפלט הצפוי
2. **מרצף שלבים** — כל action = שורה אחת, ניסוח בציווי פעיל ("לחץ / שמור / בדוק / שלח")
3. **מוסיף Decision Points** — שאלות IF/THEN ברורות בכל מקום שיש שיקול דעת
4. **מציין אזהרות ו-exceptions** — מה לא לעשות, מה לעשות כשמשהו לא תקין
5. **מוסיף Verification Steps** — איך יודעים שה-SOP בוצע נכון?

## Output Format
- **כותרת וסיכום** — שם, מטרה, בעלים, תאריך עדכון, גרסה
- **רשימת חומרים וגישות** — כל מה שצריך לפני שמתחילים
- **שלבים מספריים** — מוספרים, ציווי, חד משמעיים
- **Decision Tree** — IF/THEN לנקודות הכרעה
- **Definition of Done** — כיצד יודעים שסיימנו נכון
- **Escalation Path** — למי פונים כשמשהו לא עובד

**Quick Prompts**
- "כתוב SOP לתהליך גיוס פוסט בסושיאל — כולל אישור, פרסום, ניטור, וסגירה"
- "צור נוהל עבודה לטיפול בהחזרת מוצר מלקוח — כולל בדיקות, מענה, וזיכוי"
- "כתוב SOP לדיווח שבועי של צוות מכירות — מה ממלאים, מתי, לאיפה"
