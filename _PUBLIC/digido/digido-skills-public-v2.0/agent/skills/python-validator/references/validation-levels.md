# Validation Levels — Full Reference

## Level 1: pytest (Best)

**When available:** Project has tests, pytest is installed.

```bash
# Run all tests
pytest -v

# Run specific test file
pytest tests/test_processor.py -v

# Run specific test
pytest tests/test_processor.py::test_clean_data -v

# Run with output capture disabled (see prints)
pytest -v -s

# Run with short traceback
pytest -v --tb=short
```

**What counts as passed:**
```
=================== 5 passed in 0.42s ===================    ← ✅ PASS
=================== 4 passed, 1 failed in 0.38s ===========  ← ❌ FAIL
```

**Partial pass is a FAIL.** 4 out of 5 is not "mostly works." Fix the failing test.

---

## Level 2: Smoke Test (Good)

**When:** No existing tests, but the code can be executed directly.

A smoke test answers: "Does it run without crashing, and does it produce reasonable output?"

```bash
# Script that processes a file
python process.py --input test_data.csv
# Expected: Output file created, no errors

# API server
python app.py &
curl http://localhost:8000/health
# Expected: {"status": "ok"}

# Function test
python -c "from module import func; print(func('test_input'))"
# Expected: Specific output value
```

**Smoke test must include:**
1. The command you ran
2. The actual output (copy-paste, not paraphrase)
3. Whether output matches expectation

---

## Level 3: Import Validation (Minimum)

**When:** Code is a library/module, can't be "run" directly.

```bash
# Can it be imported without error?
python -c "import mymodule; print('OK')"

# Do all sub-modules import?
python -c "from mymodule import utils, models, api; print('All imports OK')"

# Does it have the expected attributes?
python -c "from mymodule import MyClass; print(dir(MyClass))"
```

**Import validation alone is NOT sufficient for task completion** — it only proves the code doesn't crash on load. Combine with smoke test when possible.

---

## Level 4: Syntax Check (Bare Minimum)

**When:** Cannot run the code at all (missing dependencies, external services, etc.)

```bash
# Check syntax without executing
python -m py_compile myfile.py
# No output = valid syntax

# Check multiple files
python -m py_compile *.py

# Using AST (more thorough)
python -c "import ast; ast.parse(open('myfile.py').read()); print('Syntax OK')"
```

**Syntax check alone means task stays as "partially verified."** Document why you couldn't do a higher-level check.

---

## Validation by Change Type

| Change Type | Required Validation | Minimum Level |
|-------------|---------------------|---------------|
| New function | Test with expected I/O | Level 2 (smoke) |
| Bug fix | Reproduce → fix → verify gone | Level 1 (pytest) if tests exist |
| New file/module | Import + basic execution | Level 3 (import) |
| Package installed | Import + version check | Level 3 (import) |
| API endpoint | Request + response check | Level 2 (smoke) |
| Data processing | Input → output comparison | Level 2 (smoke) |
| Config/env change | System runs without error | Level 2 (smoke) |
| Refactor | All existing tests still pass | Level 1 (pytest) |
| Script | Run with sample input | Level 2 (smoke) |
| Build/package | Build completes + installs | Level 2 (smoke) |
