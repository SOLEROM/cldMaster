---
name: process-map
description: Map, analyze, and optimize business processes to remove waste and improve flow. Auto-load when user asks to map a process, improve a workflow, or find bottlenecks in operations.
argument-hint: "[process name, who is involved, start and end points, current pain points]"
---

# מיפוי ואופטימיזציה של תהליכים עסקיים

תהליך לא מתועד הוא תהליך שכל אחד עושה אחרת. מיפוי תהליכים חושף בזבוז, עיכובים, ו-handoffs שאף אחד לא לקח בעלות עליהם — ומאפשר לך לתקן לפני שבעיה קטנה הופכת לבעיה גדולה.

## What to Provide
- שם התהליך (לדוגמה: onboarding לקוח, טיפול בתקלה, פתיחת הזמנה)
- מי מעורב — צוותים ותפקידים (לא שמות)
- נקודת פתיחה ונקודת סיום ברורות
- כלים ומערכות בשימוש
- כאבים ידועים (איפה נתקעים, מה לוקח זמן, מה חוזר לאחור)
- מה המדד להצלחה של התהליך?

## How Claude Works Through This
1. **מגדיר Swim Lanes** — מי עושה מה, ממפה בעלות לכל שלב
2. **מרצף את השלבים** — מזהה כל action, decision, handoff ו-wait time
3. **מסמן בעיות** — bottlenecks, בלי בעלות, כפילויות, נקודות שנושרות
4. **מציע גרסת TO-BE** — תהליך משופר עם הסבר לכל שינוי
5. **מגדיר KPIs** — מה למדוד כדי לדעת שהתהליך עובד בגרסה החדשה

## Output Format
- **AS-IS Map** — תהליך קיים בפורמט טקסטואלי (ניתן להכניס ל-Miro / Lucidchart)
- **רשימת בעיות** — לפי סדר priority עם הסבר ההשפעה
- **TO-BE Map** — תהליך מוצע עם שינויים מסומנים
- **Implementation Steps** — מה לשנות ראשון, שני, שלישי
- **Process KPIs** — 3-5 מדדים לעקוב

**Quick Prompts**
- "מפה את תהליך ה-onboarding שלנו ללקוח חדש — לוקח 3 שבועות ולקוחות מתלוננים על בלבול"
- "תהליך הגיוס שלנו ארוך מדי — ממועמד שמגיש קורות חיים עד הצעת עבודה לוקח 8 שבועות, עזור לי לקצר"
- "מפה את תהליך הטיפול בתלונת לקוח ומצא איפה אנחנו מאבדים מהירות"
