---
name: team-survey
description: Design employee and team surveys with analysis frameworks and recommended actions. Auto-load when user asks to create a team survey, engagement survey, or employee pulse check.
argument-hint: "[survey purpose, team size, key topics to cover, how results will be used]"
---

# עיצוב סקר עובדים / Pulse Check

סקר עובדים שנעשה נכון הוא אחד הכלים הניהוליים החזקים ביותר — הוא נותן לך נראות לתוך מה שלא נאמר בפגישות. סקר שנעשה לא נכון מייצר ציניות וחוסר אמון.

## What to Provide
- מטרת הסקר (engagement? onboarding? אחרי שינוי ארגוני? ביצועים?)
- גודל הצוות / הארגון
- תחומים שחשוב לכסות (תקשורת, אמון בהנהלה, עומס, צמיחה, שיתוף פעולה)
- האם אנונימי? מי יראה את התוצאות?
- פלטפורמה: Google Forms, Typeform, Notion, אחר?
- מה יקרה עם התוצאות?

## How Claude Works Through This
1. **מגדיר את המדדים** — מזהה אילו dimensions לכסות (engagement, wellbeing, alignment, growth, team dynamics)
2. **כותב שאלות** — מיקס של Likert (1-5), NPS, שאלות פתוחות — כל שאלה עם מטרה ברורה
3. **ממיין ומסדר** — זרימה לוגית שלא "מפחידה" עובדים בשאלות קשות מוקדם מדי
4. **בונה מסגרת ניתוח** — מה ציון X אומר, אילו תוצאות דורשות פעולה מיידית
5. **מכין Action Triggers** — לכל תוצאה אפשרית — מה עושים אחר כך

## Output Format
- **שאלות הסקר** — מוכנות לעתק-הדבק, עם הסברים לצד כל שאלה
- **מסגרת ניתוח** — כיצד לקרוא את התוצאות, בנצ'מארקים מומלצים
- **Action Playbook** — 3-5 תרחישים עם פעולות מומלצות לכל אחד
- **מסר פתיחה** — הסבר לעובדים למה הסקר ומה נעשה עם הנתונים

**Quick Prompts**
- "צור pulse check חודשי לצוות טכנולוגי של 20 איש, אנונימי, דגש על עומס ואיכות חיים"
- "בנה סקר engagement שנתי לחברה של 80 עובדים, כולל מסגרת ניתוח"
- "עצב סקר post-onboarding לאחר 90 יום לעובדים חדשים"
