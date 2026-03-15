# PowerShell ExecutionPolicy Fix

> **Problem:** venv activation fails on Windows due to PowerShell execution policy

---

## Symptoms

When trying to run:
```bash
.\venv\Scripts\activate
```

The following error appears:
```
.\venv\Scripts\activate : File [...]\ activate.ps1 cannot be loaded because running scripts is disabled on this system.
```

---

## The Solution

### Step 1: Run PowerShell as regular user

**No Admin rights needed!**

### Step 2: Run the command

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Step 3: Confirmation

When prompted:
```
Execution Policy Change
The execution policy helps protect you from scripts that you do not trust...
Do you want to change the execution policy?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"):
```

Type: **Y** and press Enter

### Step 4: Try activation again

```bash
.\venv\Scripts\activate
```

Now it should work, and you'll see:
```
(venv) C:\path\to\project>
```

---

## Explanation

### What is Execution Policy?

Windows protects against running malicious scripts.  
Execution Policy determines which scripts can run.

### Why RemoteSigned?

- `RemoteSigned` = local scripts (like venv) can run
- Scripts downloaded from the internet need a digital signature
- Safe and also allows venv to work

### Why Scope CurrentUser?

- Only affects the current user
- Does not require Admin
- Does not affect other users on the computer

---

## Alternative: If PowerShell doesn't work

You can use Command Prompt (cmd) instead:

```bash
venv\Scripts\activate.bat
```

This always works, but less convenient.

---

## Verification that everything works

After successful activation, check:

```bash
python --version
```

And:

```bash
pip list
```

Should show only the packages in venv, not all global packages.

---

## Additional Troubleshooting

### If still not working:

1. **Check that Python is installed:**
   ```bash
   python --version
   ```

2. **Check that venv was created successfully:**
   ```bash
   dir venv\Scripts
   ```
   activate.ps1 should be there

3. **Try creating venv again:**
   ```bash
   rmdir /s venv
   python -m venv venv
   ```

---

## When to use this guide?

- Architect reports that venv is not activated
- See an "execution policy" error
- First time working with Python on Windows
