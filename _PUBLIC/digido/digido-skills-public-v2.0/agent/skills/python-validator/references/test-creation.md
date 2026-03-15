# Creating Tests When None Exist

If a project has no tests and you just wrote new code, **create a basic test**.

## When to Create Tests

| Situation | Create Test? |
|-----------|-------------|
| New function with clear input/output | ✅ Yes — always |
| Bug fix | ✅ Yes — regression test |
| New API endpoint | ✅ Yes — request/response test |
| Config change | ❌ No — smoke test is enough |
| Simple script (run once) | ❌ No — smoke test is enough |
| Complex script (reusable) | ✅ Yes — at least happy path |

---

## Test Template

```python
"""Tests for {module_name}."""
import pytest
from {module} import {function}


class TestFunctionName:
    """Tests for {function_name}."""

    def test_happy_path(self):
        """Basic expected behavior."""
        result = function(valid_input)
        assert result == expected_output

    def test_edge_case_empty(self):
        """Handle empty input."""
        result = function("")
        assert result == expected_for_empty

    def test_edge_case_none(self):
        """Handle None input."""
        with pytest.raises(TypeError):
            function(None)

    def test_error_case(self):
        """Handle invalid input."""
        with pytest.raises(ValueError):
            function(invalid_input)
```

---

## Test Location

```
project/
├── src/
│   └── module.py
├── tests/
│   ├── __init__.py
│   └── test_module.py       ← tests mirror source structure
└── pytest.ini / pyproject.toml
```

---

## If pytest Is Not Installed

Don't install it without asking. Instead:

```
pytest is not installed in this project.

Options:
  A) Install pytest (recommended): pip install pytest
  B) Run smoke test instead (sufficient for now)
  C) Run basic assert test without pytest:
     python -c "from module import func; assert func('input') == 'expected', 'FAIL'; print('PASS')"

Which approach should I use?
```
