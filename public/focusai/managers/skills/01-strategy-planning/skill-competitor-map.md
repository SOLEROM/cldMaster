---
name: competitor-map
description: Map the competitive landscape with positioning, gaps, and strategic implications. Auto-load when user asks to map competitors, analyze competition, or understand the competitive landscape.
argument-hint: "[your company/product, industry, known competitors, key differentiators you believe you have]"
---

# Competitive Landscape Mapper

ממפה את הזירה התחרותית לעומק — מי שחקנים, מה הם עושים טוב, איפה הפערים, ואיפה יש לך מקום לנצח.

## What to Provide
- שם החברה / המוצר שלך ומה הוא עושה
- תעשייה וסגמנט שוק
- מתחרים שאתה כבר מכיר (ישירים ועקיפים)
- קהל יעד שלך ה-ICP
- מה אתה חושב שהיתרון שלך הוא
- כל נתון שיש לך: מחירים, נתחי שוק, משוב לקוחות

## How Claude Works Through This
1. **קטגוריזציה של מתחרים** — מפריד בין מתחרים ישירים, עקיפים, וחלופות שוק
2. **פרופיל מתחרים** — לכל שחקן: עוצמה, חולשה, עמדת מחיר, ICP, מסרים עיקריים
3. **מטריצת מיצוב** — מציב את כל השחקנים על ציר X/Y לפי מאפיינים רלוונטיים
4. **מיפוי פערים (White Space)** — מזהה איפה השוק לא משורת ומה ההזדמנויות הלא-מנוצלות
5. **המלצת מיצוב** — איפה לשחק, כלפי מי לנצח, ממי להתרחק

## Output Format

**Competitive Landscape — [חברה] — [שנה]**

```
MARKET OVERVIEW
- מספר שחקנים בשוק: [...]
- דינמיקה: [שוק ממוקד / מפוצל / בשלב consolidation]
- מה קובע ניצחון בשוק הזה: [2-3 גורמים]

COMPETITOR PROFILES
[טבלה: מתחרה | מוצר עיקרי | ICP | מחיר | חוזקה | חולשה | עד כמה מאיים]

מתחרה A: [פסקה קצרה]
מתחרה B: [...]

POSITIONING MAP
ציר X: [מאפיין] | ציר Y: [מאפיין]
[מיקומי שחקנים בטקסט: "מתחרה A: X גבוה, Y נמוך"]

WHITE SPACE — הזדמנויות שאין מי שתופס
1. [פלח לקוחות / צורך / מחיר לא מכוסה]
2. [...]

ה-POSITIONING שלך (מומלץ)
"אנחנו [מה] ל[מי] שרוצה [מה], בניגוד ל[מתחרה] שהוא [מה]"

COMPETITIVE MOVES TO WATCH
- [שחקן X] כנראה יעשה [Y] בשנה הבאה — תכין [...]
```

**Quick Prompts**
- "Map the competitive landscape for Israeli cybersecurity startups in the SMB space"
- "I'm launching a project management tool — who are the real competitors and where's the white space?"
- "Help me understand how to position against Monday.com and Asana for agencies"
