# API & Environment Variables Setup

> **When to use:** When the project needs API keys, secrets, or configuration

---

## When do you need .env?

- Working with APIs (OpenAI, Anthropic, Google, etc.)
- Storing credentials (database passwords, API keys)
- Environment settings (DEV, PROD)
- File paths that change between machines

---

## Quick Setup

### 1. Install python-dotenv

Add to `requirements.txt`:
```
python-dotenv==1.0.0
```

Install:
```bash
pip install -r requirements.txt
```

### 2. Create .env

Create a `.env` file in the project root:

```
# API Keys
OPENAI_API_KEY=sk-proj-xxxxxxxxxxxxxx
ANTHROPIC_API_KEY=sk-ant-xxxxxxxxxxxxxx
GOOGLE_API_KEY=AIzaxxxxxxxxxxxxxx

# Database
DB_HOST=localhost
DB_PORT=5432
DB_NAME=myproject
DB_USER=admin
DB_PASSWORD=secretpassword123

# Paths
INPUT_FOLDER=./data/input
OUTPUT_FOLDER=./data/output

# Environment
ENVIRONMENT=development
DEBUG=True
```

### 3. Use in Code

```python
from dotenv import load_dotenv
import os

# Load .env
load_dotenv()

# Access variables
api_key = os.getenv('OPENAI_API_KEY')
db_host = os.getenv('DB_HOST')
debug_mode = os.getenv('DEBUG') == 'True'

# Usage
if debug_mode:
    print(f"Connecting to {db_host}...")
```

---

## Security - Very Important!

### ✅ Always do:

1. **Add .env to .gitignore:**
   ```
   # .gitignore
   .env
   .env.local
   .env.*.local
   ```

2. **Create .env.example:**
   ```
   # .env.example (commit this!)
   OPENAI_API_KEY=your_key_here
   ANTHROPIC_API_KEY=your_key_here
   DB_PASSWORD=your_password_here
   ```

3. **Document in README:**
   ```markdown
   ## Setup
   1. Copy `.env.example` to `.env`
   2. Fill in your actual API keys
   3. Never commit .env!
   ```

### ❌ Never do:

- ❌ commit .env to Git
- ❌ share API keys in code
- ❌ hardcode passwords in Python files

---

## Best Practices

1. **Validation** - Ensure all required keys exist
2. **Defaults** - Provide reasonable default values
3. **Type conversion** - Convert strings to int/bool as needed
4. **Documentation** - Document every variable in .env.example
5. **Rotation** - Change API keys periodically

---

## Troubleshooting

### "API key not found"

1. Check that .env is in project root
2. Check variable name matches (case-sensitive!)
3. Check `load_dotenv()` is called before use
4. Check no extra spaces: `KEY=value` not `KEY = value`

### "ModuleNotFoundError: No module named 'dotenv'"

```bash
pip install python-dotenv
```

### .env not loading

Ensure file is named exactly `.env` (with dot at start) not `env.txt` or `.env.txt`
