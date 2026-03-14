---
name: exec-presentation
description: Build a structured executive presentation for boards, investors, or senior leadership. Auto-load when user asks to create a presentation for executives, build a board deck, or prepare a leadership presentation.
argument-hint: "[audience, topic/purpose, key message you want them to walk away with, data/content you have]"
---

# Executive Presentation Builder

בונה מצגות שמנהלים בכירים זוכרים — לא slides עמוסות בבולטים, אלא narrative ברור עם One Big Message לכל slide.

## What to Provide
- קהל: דירקטוריון / משקיעים / הנהלה בכירה / לקוח אסטרטגי
- מטרת המצגת: לקבל אישור / לעדכן / לשכנע / לגייס
- ה-Ask: מה אתה צריך שיקרה בסוף?
- תוכן שיש לך: נתונים, slides קיימות, ממצאים, עמדה
- אורך המצגת ומסגרת הזמן
- רגישויות שחשוב לשים לב אליהן

## How Claude Works Through This
1. **גיבוש ה-Governing Thought** — מסיק את המסר המרכזי אחד שיש לתקשר
2. **בניית Pyramid Structure** — מסדר את הטיעונים לפי Minto Pyramid: Situation → Complication → Resolution
3. **תכנון slide-by-slide** — מגדיר לכל slide: Headline (action title), מסר אחד, visualization אחד
4. **עיצוב ה-Flow** — מוודא שיש narrative thread בין slides — כל slide מוביל לבאה
5. **הכנת Speaker Notes** — לכל slide: מה לאמור, מה לצפות כשאלה, ואיך לנהל

## Output Format

**Executive Presentation Blueprint — [נושא] — [קהל]**

```
GOVERNING THOUGHT (המסר שלא יישכח)
"[משפט אחד שמסכם הכל]"

THE ASK (מה צריך שיקרה בסוף)
[ספציפי ומדיד]

SLIDE-BY-SLIDE BLUEPRINT

SLIDE 1 — TITLE
Title: [...]
Visual: [...]

SLIDE 2 — SITUATION (מה קורה בשוק / בחברה)
Headline: "[Action Title — עובדה + משמעות]"
Key Point: [...]
Data: [...]
Speaker Note: [מה לאמור | שאלות צפויות | טיפ]

SLIDE 3 — COMPLICATION (מה האתגר / ההזדמנות)
...

SLIDE 4-N — SOLUTION / DATA / OPTIONS
...

SLIDE FINAL — THE ASK + NEXT STEPS
Headline: "[...]"
Ask: [...]
Next Steps: [תאריך | פעולה | אחראי]

APPENDIX SLIDES (מוכן לשאלות)
[רשימת נושאים + מה ה-slide הנתמך]

PRESENTATION RISKS
[מה עלול להתנגד, מה התשובה שלך]
```

**Quick Prompts**
- "Build a 10-slide board presentation for our Q4 results — revenue was down 12% but we have a recovery plan"
- "I need a 20-minute investor update presentation — we closed 3 key deals but missed growth targets"
- "Create an executive presentation to get ₪2M budget approval for a new technology platform"
