---
name: firebase-deployment-protocol
description: "Step-by-step protocol for deploying React/Vite applications to a NEW Firebase project. Use this skill when the user wants to: (1) Connect an existing React/Vite app to Firebase Firestore, (2) Deploy an app to Firebase Hosting, (3) Migrate from LocalStorage to Firestore, (4) Set up a new Firebase project from scratch. This is a GUIDED PROTOCOL - the agent walks the user through each step, waits for user actions in Firebase Console, then completes the code changes."
---

# Firebase Deployment Protocol

פרוטוקול מדויק לפריסת אפליקציית React/Vite לפרויקט Firebase חדש.

> **חשוב**: זהו תהליך **מודרך** - הסוכן מנחה את המשתמש צעד אחר צעד, ממתין לפעולות המשתמש ב-Firebase Console, ורק אז מבצע את השינויים בקוד.

---

## Phase 1: Pre-flight Checks

לפני תחילת התהליך, ודא:

1. **הפרויקט קיים ויש בו package.json**
2. **הפרויקט הוא React/Vite** (בדוק ב-package.json)
3. **יש תיקיית context או state management** שצריך לעדכן

הרץ בדיקה מהירה:
```bash
# בדוק אם יש package.json
cat package.json | grep "name"
```

---

## Phase 2: User Instructions - Firebase Console

שלח למשתמש את ההוראות הבאות **בדיוק כפי שהן**:

```markdown
## שלב 1: יצירת פרויקט ב-Firebase Console

1. פתח דפדפן וגש אל: https://console.firebase.google.com/
2. התחבר עם חשבון Google שלך
3. לחץ על **"Add project"** / **"הוסף פרויקט"**
4. בחר שם לפרויקט (לדוגמה: `my-app-name`)
5. **Google Analytics** - אפשר לכבות (לא נחוץ כרגע)
6. לחץ **"Create Project"** / **"צור פרויקט"**
7. המתן כ-30 שניות עד שהפרויקט נוצר
8. לחץ **"Continue"** כשמוכן

## שלב 2: הפעלת Firestore Database - CRITICAL ! DONT FORGET THIS STEP!

1. בתפריט צד שמאל, לחץ על **"Firestore Database"**
2. לחץ **"Create database"**
3. **Security rules**: בחר **"Start in test mode"**
4. **Location**: בחר `eur3 (europe-west)` (הכי קרוב לישראל)
5. לחץ **"Enable"**
6. המתן שה-database יופעל (כ-1 דקה)

## שלב 3: יצירת אפליקציית Web

1. בדף הבית של הפרויקט (Project Overview), לחץ על הסמל **</\>** (Web)
2. **App nickname**: הקלד שם (לדוגמה: `my-app-web`)
3. **Firebase Hosting**: ⬜ **אל תסמן** (נעשה את זה אחר כך)
4. לחץ **"Register app"**
5. תראה מסך עם קוד - **זה חשוב!** 🔑

תראה משהו כזה:
\`\`\`javascript
const firebaseConfig = {
  apiKey: "AIzaSy...",
  authDomain: "xxx.firebaseapp.com",
  projectId: "xxx",
  storageBucket: "xxx.firebasestorage.app",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abcdef123456"
};
\`\`\`

📋 **העתק את כל האובייקט firebaseConfig ושלח לי אותו**
(זה בטוח לשתף - מיועד לקוד צד-לקוח)
```

**המתן לתגובת המשתמש עם ה-firebaseConfig לפני שתמשיך!**

---

## Phase 3: Install Firebase Package

לאחר קבלת ה-firebaseConfig, הרץ התקנה:

```bash
npm install firebase
```

---

## Phase 4: Create firebase.ts Configuration File

צור קובץ `src/firebase.ts` עם התוכן הבא (החלף את ה-config בזה שקיבלת מהמשתמש):

```typescript
import { initializeApp } from 'firebase/app';
import { getFirestore } from 'firebase/firestore';

// Firebase configuration - received from user
const firebaseConfig = {
  apiKey: "USER_PROVIDED",
  authDomain: "USER_PROVIDED",
  projectId: "USER_PROVIDED",
  storageBucket: "USER_PROVIDED",
  messagingSenderId: "USER_PROVIDED",
  appId: "USER_PROVIDED"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Initialize Firestore
export const db = getFirestore(app);

export default app;
```

---

## Phase 5: Update Context to Use Firestore

מצא את קובץ ה-Context הראשי (לדוגמה: `context/FinanceContext.tsx` או דומה).

### 5.1 הוסף imports בתחילת הקובץ:

```typescript
import { db } from '../src/firebase';
import { 
  collection, 
  addDoc, 
  deleteDoc, 
  doc, 
  onSnapshot, 
  query, 
  orderBy,
  getDocs,
  writeBatch
} from 'firebase/firestore';
```

### 5.2 הוסף isLoading ל-interface:

```typescript
interface ContextType {
  // ... existing fields
  isLoading: boolean;
}
```

### 5.3 החלף את ה-state:

```typescript
const [isLoading, setIsLoading] = useState(true);
const [hasMigrated, setHasMigrated] = useState(false);
```

### 5.4 הוסף פונקציית migration מ-LocalStorage:

```typescript
const migrateLocalStorageToFirestore = async () => {
  const storedData = localStorage.getItem(STORAGE_KEY);
  if (storedData && !hasMigrated) {
    try {
      const localItems = JSON.parse(storedData);
      const collectionRef = collection(db, 'COLLECTION_NAME');
      const snapshot = await getDocs(collectionRef);
      
      if (snapshot.empty && localItems.length > 0) {
        console.log('Migrating', localItems.length, 'items to Firestore...');
        const batch = writeBatch(db);
        
        localItems.forEach((item: any) => {
          const docRef = doc(collectionRef, item.id);
          batch.set(docRef, item);
        });
        
        await batch.commit();
        console.log('Migration completed successfully!');
      }
      
      setHasMigrated(true);
    } catch (e) {
      console.error('Failed to migrate:', e);
    }
  }
};
```

### 5.5 החלף את ה-useEffect לטעינה מ-Firestore:

```typescript
useEffect(() => {
  const collectionRef = collection(db, 'COLLECTION_NAME');
  const q = query(collectionRef, orderBy('date', 'desc'));

  const unsubscribe = onSnapshot(q, (snapshot) => {
    const loadedItems: ItemType[] = [];
    snapshot.forEach((doc) => {
      loadedItems.push({ ...doc.data(), id: doc.id } as ItemType);
    });

    setItems(loadedItems);
    setIsLoading(false);

    if (!hasMigrated) {
      migrateLocalStorageToFirestore();
    }
  }, (error) => {
    console.error('Error loading:', error);
    setIsLoading(false);
  });

  return () => unsubscribe();
}, [hasMigrated]);
```

### 5.6 עדכן פונקציות CRUD:

```typescript
// ADD
const addItem = async (itemData: Omit<ItemType, 'id'>) => {
  try {
    const collectionRef = collection(db, 'COLLECTION_NAME');
    await addDoc(collectionRef, itemData);
  } catch (error) {
    console.error('Error adding:', error);
  }
};

// DELETE
const deleteItem = async (id: string) => {
  try {
    const itemRef = doc(db, 'COLLECTION_NAME', id);
    await deleteDoc(itemRef);
  } catch (error) {
    console.error('Error deleting:', error);
  }
};

// RESET ALL
const resetData = async () => {
  try {
    const collectionRef = collection(db, 'COLLECTION_NAME');
    const snapshot = await getDocs(collectionRef);
    
    const batch = writeBatch(db);
    snapshot.docs.forEach((doc) => {
      batch.delete(doc.ref);
    });
    
    await batch.commit();
    localStorage.removeItem(STORAGE_KEY);
  } catch (error) {
    console.error('Error resetting:', error);
  }
};
```

### 5.7 עדכן את ה-Provider value:

```typescript
<Context.Provider value={{ ...existingValues, isLoading }}>
```

---

## Phase 6: Update Components for Loading State

בקומפוננטות שמשתמשות ב-Context, הוסף תמיכה ב-loading:

```typescript
const { items, isLoading } = useContext();

if (isLoading) {
  return (
    <div className="flex items-center justify-center h-64">
      <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-emerald-500"></div>
      <p className="ml-4 text-slate-400">Loading...</p>
    </div>
  );
}
```

## רצוי : להוסיף דיבאג כלשהו שנותן אינדיקציה בקונסול שהאפליקציה מחוברת לפיירבייס
---

## Phase 7: Local Verification

הרץ בדיקה מקומית:

```bash
npm run build
```

**אם עובר ללא שגיאות**, המשך לשלב הבא.
**אם יש שגיאות**, תקן אותן לפני שממשיכים.

לאחר מכן:

הנחה את המשתמש לפתוח עצמאית את הממשק באופן מקומי:

```bash
npm run dev
```

בקש מהמשתמש:
1. לפתוח את האפליקציה בדפדפן
2. לבדוק ב-Console שאין שגיאות אדומות
3. לנסות להוסיף/למחוק פריט ולראות שזה עובד

---

## Phase 8: Firebase Hosting Deployment

שלח למשתמש את ההוראות הבאות:

```markdown
## פרסום האפליקציה ל-Firebase Hosting

### שלב 1: התקנת Firebase CLI (אם עדיין לא מותקן)

הרץ בטרמינל:
\`\`\`bash
npm install -g firebase-tools
\`\`\`

### שלב 2: התחברות ל-Firebase

\`\`\`bash
firebase login
\`\`\`

אם כבר מחובר, זה יאמר `Already logged in as...`
אם לא, תעזור למשתמש להתחבר.

### שלב 3: אתחול Firebase Hosting

הרץ בתיקיית הפרויקט:
\`\`\`bash
firebase init hosting
\`\`\`

**ענה על השאלות כך:**
1. "Please select an option" → **Use an existing project**
2. "Select a default Firebase project" → **בחר את הפרויקט שיצרת**
3. "What do you want to use as your public directory?" → הקלד: **dist**
4. "Configure as a single-page app?" → **Yes**
5. "Set up automatic builds and deploys with GitHub?" → **No**
6. "File dist/index.html already exists. Overwrite?" → **No** (אם שואל)

### שלב 4: בניית האפליקציה

\`\`\`bash
npm run build
\`\`\`

### שלב 5: פרסום

\`\`\`bash
firebase deploy --only hosting
\`\`\`

אחרי כמה שניות תקבל:
\`\`\`
✔  Deploy complete!

Hosting URL: https://YOUR-PROJECT.web.app
\`\`\`

**זהו! האפליקציה שלך בלייב! 🎉**
```

---

## Post-Deployment Notes

הסבר למשתמש:

```markdown
## מצב נוכחי

✅ האפליקציה פעילה ב: `https://PROJECT-ID.web.app`
✅ הנתונים נשמרים ב-Firestore Cloud
✅ Real-time sync בין כל המכשירים

## אזהרות

⚠️ **Security Rules ב-Test Mode** - יפקעו אחרי 30 יום
⚠️ **אין הפרדה בין משתמשים** - כולם רואים את אותם הנתונים
⚠️ **כל מי שיש לו את הקישור** - יכול לערוך

## בעתיד

אם תרצה משתמשים נפרדים:
1. הוסף Firebase Authentication
2. עדכן Security Rules
3. שנה מבנה נתונים ל-`users/{userId}/collection`

## פקודות שימושיות

\`\`\`bash
# פרסום מחדש אחרי שינויים
npm run build && firebase deploy --only hosting

# הרצה מקומית
npm run dev
\`\`\`
```

---

## Checklist Summary

- [ ] Pre-flight checks passed
- [ ] User created Firebase project in Console
- [ ] User created Firestore Database (test mode)
- [ ] User registered Web App
- [ ] Received firebaseConfig from user
- [ ] Installed `firebase` package
- [ ] Created `src/firebase.ts`
- [ ] Updated Context with Firestore integration
- [ ] Added real-time listener (`onSnapshot`)
- [ ] Added migration from LocalStorage
- [ ] Updated CRUD functions
- [ ] Added loading states to components
- [ ] Verified `npm run build` passes
- [ ] Verified local testing works
- [ ] User ran `firebase init hosting`
- [ ] User ran `firebase deploy --only hosting`
- [ ] App is live at Firebase Hosting URL
