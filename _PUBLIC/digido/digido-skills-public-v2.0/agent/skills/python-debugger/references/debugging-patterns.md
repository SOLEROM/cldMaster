# Python-Specific Debugging Patterns

## Pattern 1: The None Cascade

```
Symptom: AttributeError: 'NoneType' object has no attribute '...'
Reality: Something upstream returned None and nobody checked

Investigation:
1. Find where the None value originated (trace backwards)
2. Check: Is the function supposed to return None? (missing return statement?)
3. Check: Is it a failed lookup? (.get() returns None, dict[] raises KeyError)
4. Check: Is it an uninitialized variable?
```

## Pattern 2: The Import Maze

```
Symptom: ModuleNotFoundError / ImportError
Reality: Almost never a code problem

Investigation:
1. which python / where python → correct interpreter?
2. Is venv activated? (check prompt or $VIRTUAL_ENV)
3. pip show package_name → is it installed? what version?
4. Is there a file in your project with the same name as the package? (shadowing)
5. Circular import? (A imports B, B imports A)
```

## Pattern 3: The Silent Failure

```
Symptom: No error, but wrong output / no output
Reality: Code runs but doesn't do what you think

Investigation:
1. Add print() at function entry — is it even being called?
2. Check conditions — is the if/else going where you expect?
3. Check return values — is the function returning what you think?
4. Check variable scope — is the variable you're modifying the one you think?
```

## Pattern 4: The Version Mismatch

```
Symptom: Code works locally, fails elsewhere (or worked yesterday)
Reality: Different package version, Python version, or OS

Investigation:
1. pip freeze > current.txt → compare with requirements.txt
2. python --version → match expected?
3. Check breaking changes in package changelog
4. OS-specific: file paths (/ vs \), line endings, encoding
```

## Pattern 5: The Encoding Trap

```
Symptom: UnicodeDecodeError, garbled text, mystery characters
Reality: File isn't UTF-8, or contains BOM

Investigation:
1. open(file, encoding='utf-8-sig') → handles BOM
2. Check actual encoding: chardet.detect(raw_bytes)
3. Hebrew/Arabic text? Check for RTL issues in output
4. CSV from Excel? Often cp1255 or cp1252, not UTF-8
```

## Pattern 6: The Path Problem (Windows-Specific)

```
Symptom: FileNotFoundError, but the file clearly exists
Reality: Windows paths are tricky

Investigation:
1. print(repr(path)) → are there hidden characters?
2. Backslashes: use raw strings r"C:\path" or forward slashes "C:/path"
3. Spaces in path: "D:\apps and tools" needs quoting in shell
4. Long paths: Windows has 260-char limit (can be disabled)
5. os.path.exists(path) before opening → confirm the path works
```
