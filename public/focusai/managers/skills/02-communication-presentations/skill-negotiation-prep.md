---
name: negotiation-prep
description: Prepare thoroughly for a negotiation with positions, BATNA, and tactical planning. Auto-load when user asks to prepare for a negotiation, plan a deal discussion, or prepare for a salary/contract/partnership talk.
argument-hint: "[what you're negotiating, with whom, your goals, their likely goals, constraints on both sides]"
---

# Negotiation Preparation Kit

מכין אותך לכל מו"מ כמו שיש לך יועץ עסקי בחדר — עם עמדות ברורות, BATNA חזק, וטקטיקות לכל תרחיש.

## What to Provide
- מה מנהלים: חוזה / שכר / שותפות / עסקה / תנאי ספק / M&A
- עם מי: תפקיד, חברה, מה הוא מניע אותו
- המטרה שלך: מה תוצאת החלום, מה minimum מקובל
- מה אתה מביא לשולחן (leverage)
- מה הם מביאים לשולחן (מה הם צריכים ממך)
- אתגרים שאתה חושש מהם

## How Claude Works Through This
1. **מיפוי אינטרסים** — מפריד בין עמדות (Positions) לאינטרסים (Interests) — שלך ושל הצד השני
2. **BATNA Analysis** — מחשב את ה-Best Alternative שלך ושל הצד השני — זה קובע את ה-power
3. **ZOPA Mapping** — מגדיר את Zone of Possible Agreement — איפה העסקה יכולה לקרות
4. **Opening Move ו-Anchoring** — ממליץ מה להציע ראשון, במה לפתוח, ואיך לעגן
5. **תרחישים וטקטיקות** — מכין תגובה לכל תרחיש: דחייה / קאונטר / לחץ / שתיקה

## Output Format

**Negotiation Prep — [נושא] — [תאריך]**

```
NEGOTIATION OVERVIEW
מה על השולחן: [...]
הצד השני: [שם/חברה/תפקיד]
ציר הזמן: [מתי צריך להחליט]

INTERESTS MAPPING

שלי:
  רצוי מאוד: [...]
  חשוב: [...]
  גמיש עליו: [...]

שלהם (ניתוח):
  כנראה רוצים: [...]
  כנראה מוכנים לוותר על: [...]
  הדבר שלא יסכימו עליו: [...]

BATNA ANALYSIS

ה-BATNA שלי: [מה אעשה אם העסקה לא תיסגר]
  חוזק ה-BATNA שלי: [חזק / בינוני / חלש] — הסבר

ה-BATNA שלהם (ניתוח): [מה יעשו אם אני לא מסכים]
  חוזק ה-BATNA שלהם: [חזק / בינוני / חלש]

Power Balance: [מי ב-leverage, ולמה]

ZOPA (Zone of Possible Agreement)
  Floor שלי (מינימום קביל): [...]
  Ceiling שלהם (מקסימום שיתנו): [...]
  ZOPA: [קיים / לא קיים / לא ברור]

OPENING STRATEGY
פתיחה מומלצת: [מה להציע ראשון]
Anchor: [מספר / תנאי שפותח גבוה/נמוך מהיעד]
Framing: [איך לנסח את הפתיחה]

TRADE-OFFS (ויתורים שלא עולים לך הרבה אבל שווים להם)
  [ויתור A → מה מקבל בתמורה]
  [ויתור B → ...]

SCENARIOS & RESPONSES
אם יאמרו "[...]" → תגיב "[...]"
אם יאמרו "[...]" → תגיב "[...]"
אם ינסו לחץ זמן → [...]
אם ינסו Good Cop/Bad Cop → [...]
אם יציעו Take-it-or-leave-it → [...]

WALK-AWAY POINT
[מה התנאי שאתה עוזב את החדר עליו]
```

**Quick Prompts**
- "Prepare me for salary negotiation — I want ₪35K, current offer is ₪28K, I have a competing offer"
- "Help me prep for a vendor contract negotiation — they want 12-month commitment, I want 3 months"
- "I'm about to negotiate a partnership deal worth ₪500K — what's my strategy?"
