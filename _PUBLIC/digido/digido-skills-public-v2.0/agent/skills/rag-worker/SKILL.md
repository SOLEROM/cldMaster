---
name: rag-worker
description: Cloud-Native RAG system using Google Gemini Flash 3 via the modern google-genai SDK. Ingests documents into local Qdrant Vector DB but performs embedding and generation in the cloud.
---

# RAG Worker Skill (Gemini Edition)

This skill provides a high-performance Retrieval-Augmented Generation (RAG) system using **Google Gemini**.
It creates a local index (Qdrant) of your documents but uses Google's powerful models for semantic understanding and answer generation.

## Capabilities

1.  **Ingest Documents**: Embeds documents using `models/text-embedding-004`.
2.  **Query Knowledge**: Retrieves context and answers using `models/gemini-3.0-flash`.

## Dependencies

-   **Google API Key**: Must be set in environment (`GOOGLE_API_KEY`).
-   **Python**: `pip install -r requirements.txt` (uses `google-genai` SDK).

## Usage

### 1. Setup

Install dependencies and verify API Key.

```bash
python scripts/setup.py
```

### 2. Ingest Data

Ingest documents from a directory.

```bash
python scripts/ingest.py --source "path/to/docs"
```

### 3. Query Key

Ask a question.

```bash
python scripts/query.py --query "Summarize the project status"
```

## Troubleshooting

-   **"GOOGLE_API_KEY not set"**:
    -   PowerShell: `$env:GOOGLE_API_KEY="AIza..."`
    -   CMD: `set GOOGLE_API_KEY=AIza...`
-   **Import Errors**: Ensure you installed the requirements. The code uses `llama-index-llms-google-genai` which depends on the new `google-genai` library.
