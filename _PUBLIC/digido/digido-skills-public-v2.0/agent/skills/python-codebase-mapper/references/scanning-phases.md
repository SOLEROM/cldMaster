# Scanning Phases — Detailed Procedures

## Phase 1: Project Type Detection

Scan for marker files to identify project type:

| Marker File | Project Type |
|-------------|-------------|
| `manage.py` + `settings.py` | Django web app |
| `app.py` or `main.py` + `FastAPI()` / `Flask()` | Web API (FastAPI / Flask) |
| `streamlit_app.py` or `st.` usage | Streamlit dashboard |
| `setup.py` / `pyproject.toml` with `[build-system]` | Distributable package |
| `Dockerfile` + Python files | Containerized service |
| Single `.py` file | Standalone script |
| `tasks/` or `celery` imports | Task queue / worker |
| `pipeline.py` or `dag` files | Data pipeline |
| `train.py` or ML library imports | Machine learning project |
| `tests/` directory + `conftest.py` | Test suite present |
| `agent` / `crew` / `chain` in files | AI agent / LLM application |
| `bot.py` or `discord` / `telegram` imports | Chat bot |

If multiple markers exist, identify PRIMARY type and note secondary aspects.

## Phase 2: Environment Detection

### Python Version
```bash
python --version
python3 --version

# Check if specified in project:
# pyproject.toml → [tool.poetry.dependencies] python = "^3.11"
# setup.py → python_requires='>=3.10'
# .python-version (pyenv)
# runtime.txt (Heroku)
```

### Virtual Environment
```bash
# Look for: venv/  .venv/  env/  .env/ (if directory)

# Check if activated:
echo $VIRTUAL_ENV        # Linux/Mac
echo %VIRTUAL_ENV%       # Windows cmd
$env:VIRTUAL_ENV         # PowerShell

where python             # Windows
which python             # Linux/Mac
```

### Package Manager
| Marker | Package Manager |
|--------|----------------|
| `requirements.txt` | pip (basic) |
| `requirements-dev.txt` / `requirements-test.txt` | pip (split environments) |
| `Pipfile` + `Pipfile.lock` | pipenv |
| `pyproject.toml` + `poetry.lock` | Poetry |
| `pyproject.toml` + `uv.lock` | uv |
| `setup.py` only | setuptools (legacy) |
| `pyproject.toml` + `hatch` section | Hatch |
| `conda.yaml` / `environment.yml` | Conda |

## Phase 3: Structure Scan

**Always ignore:**
```
__pycache__/  .git/  .venv/  venv/  env/  node_modules/
.mypy_cache/  .pytest_cache/  *.egg-info/  dist/  build/
.tox/  .eggs/  *.pyc  .DS_Store
```

For each source directory, note:
- What it contains (models? routes? utils?)
- How many files
- Key files and their purpose

## Phase 4: Dependency Analysis

### Production Dependencies
Read from `requirements.txt`, `pyproject.toml`, `Pipfile`, or `setup.py`:
```
For each dependency:
  Name, Version, Purpose (infer from imports), Category (web/db/api/testing/utility/ml/devops)
```

### Development Dependencies
Look for: `requirements-dev.txt`, `[tool.poetry.group.dev.dependencies]`, `[project.optional-dependencies]`, `dev-packages` in Pipfile.

### Dependency Pinning Status
| Status | Risk |
|--------|------|
| `package==1.2.3` | Low — reproducible |
| `package>=1.2,<2.0` | Medium — controlled updates |
| `package>=1.2` | High — breaking updates possible |
| `package` (no pin) | Highest — anything can happen |

## Phase 5: Import Graph

```
Scan all .py files for:
  from project.module import X
  import project.module

Build dependency map:
  main.py → imports: config, routes, models
  routes/users.py → imports: models.user, services.auth
```

**Flag:** Circular imports, Deep chains (A→B→C→D→E), God modules (imported by 5+), Orphan files (not imported by anything).

## Phase 6: Entry Points

| Entry Type | Detection |
|------------|-----------|
| Direct script | `if __name__ == "__main__"` |
| CLI tool | `[project.scripts]` in pyproject.toml |
| Web server | `uvicorn`, `gunicorn`, `flask run` |
| Task worker | `celery -A` commands |
| Docker | `CMD` / `ENTRYPOINT` in Dockerfile |
| Scheduled | `cron`, `schedule`, `APScheduler` |

## Phase 7: Configuration Analysis

### Environment Variables
```
Scan for:
  os.getenv("VAR_NAME")
  os.environ["VAR_NAME"]
  config("VAR_NAME")        # decouple
  settings.VAR_NAME         # Django

List: Name, Where used (file:line), Has default?, Purpose
```

**IMPORTANT: Never read or display the CONTENTS of .env files. Only list variable NAMES.**

### Config Files
```
.env / .env.example / .env.local
config.py / settings.py
pyproject.toml [tool.*] sections
setup.cfg / tox.ini / pytest.ini
.flake8 / .ruff.toml / mypy.ini
.pre-commit-config.yaml
```

## Phase 8: Technical Debt Scan

```
Search for:
  TODO / FIXME / HACK / XXX / NOQA / type: ignore
  pass  (empty functions)
  except Exception:  (bare exception)
  print(  (debug prints in production code)
  # pylint: disable / # noqa  (suppressed warnings)
  deprecated  (in docstrings or comments)

For each: What, Where (file:line), Severity (low/med/high), Effort (quick/moderate/significant)
```
