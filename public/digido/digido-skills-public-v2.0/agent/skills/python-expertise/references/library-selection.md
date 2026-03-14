# Python Library Selection Guide

> **Purpose:** Help select appropriate libraries based on needs

---

## Working with Files

### Excel
- **pandas** - Reading, writing, advanced data processing
- **openpyxl** - Working with Excel 2010+ (.xlsx), cell formatting
- **xlrd/xlwt** - Old Excel files (.xls)

### PDF
- **PyPDF2** - Reading, merging, splitting PDFs
- **pdfplumber** - Text and table extraction
- **reportlab** - Creating PDFs from scratch

### Word Documents
- **python-docx** - Reading and creating .docx
- **python-pptx** - PowerPoint files

### XML/HTML
- **lxml** - Fast XML processing
- **BeautifulSoup4** - Simple HTML/XML parsing
- **xml.etree.ElementTree** - built-in, basic

### JSON/CSV
- **json** - built-in, sufficient for most cases
- **csv** - built-in
- **pandas** - Advanced CSV processing

---

## Automation

### Scheduling
- **schedule** - Simple and friendly
- **APScheduler** - More advanced, cron jobs

### File System Watching
- **watchdog** - Monitor file changes
- **pathlib** - built-in, working with paths

### Process Automation
- **subprocess** - built-in, running commands
- **psutil** - Process and resource management

---

## Web & APIs

### HTTP Requests
- **requests** - The standard, easy to use
- **httpx** - async support
- **urllib** - built-in, basic

### Web Frameworks
- **Flask** - lightweight, quick to start
- **FastAPI** - modern, async, auto-documentation
- **Django** - full-featured, overkill for most projects

### Web Scraping
- **BeautifulSoup4** - HTML parsing
- **Selenium** - browser automation
- **Scrapy** - full scraping framework

---

## Data Processing

### Data Analysis
- **pandas** - The standard for data analysis
- **numpy** - Mathematics, arrays
- **scipy** - Scientific computations

### Visualization
- **matplotlib** - The baseline
- **plotly** - interactive charts
- **seaborn** - statistical plots

---

## AI & LLMs

### LLM APIs
- **openai** - OpenAI API (GPT-4 etc.)
- **anthropic** - Anthropic API (Claude)
- **google-generativeai** - Google (Gemini)

### LLM Frameworks
- **langchain** - framework for chaining LLMs
- **llama-index** - RAG, working with documents

---

## Database

### SQLite
- **sqlite3** - built-in
- **sqlalchemy** - ORM, supports all DBs

### Other Databases
- **pymongo** - MongoDB
- **psycopg2** - PostgreSQL
- **redis-py** - Redis

---

## Backend Infrastructure

### Environment Variables
- **python-dotenv** - Loading .env files
- **environs** - With validation

### Logging
- **logging** - built-in, sufficient for most
- **loguru** - More user-friendly

### Configuration
- **pydantic** - data validation
- **configparser** - built-in, INI files

---

## Security

### Encryption
- **cryptography** - The standard
- **bcrypt** - password hashing

### Authentication
- **PyJWT** - JSON Web Tokens
- **authlib** - OAuth, OpenID

---

## Testing

- **pytest** - The standard for testing
- **unittest** - built-in
- **pytest-cov** - code coverage

---

## Important Notes

1. **Always pin versions** in requirements.txt: `pandas==2.0.0`
2. **Start minimal** - Don't install libraries you don't need
3. **Virtual environment** - Always work in venv
4. **Documentation** - Check most libraries on PyPI

---

## For the future: Libraries Reference Database

Later we'll build a Python script that scans PyPI and creates an updated local library repository.

Currently - relying on existing LLM knowledge + this document.
