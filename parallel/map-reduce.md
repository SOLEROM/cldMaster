# Map-Reduce Pattern

A large input is split into chunks and mapped to N parallel agents, each processing one chunk. A reducer merges all partial results into a final output.

```mermaid
flowchart TD
    D["Large Input\n(docs, data, code)"] --> SP["Splitter"]
    SP --> M1["Map Agent 1\nChunk A"]
    SP --> M2["Map Agent 2\nChunk B"]
    SP --> M3["Map Agent 3\nChunk C"]
    SP --> M4["Map Agent 4\nChunk D"]
    M1 --> RED["Reducer\nMerge Results"]
    M2 --> RED
    M3 --> RED
    M4 --> RED
    RED --> O["Final Output"]
```

## When to Use
- Analyzing documents too large for one context window
- Bulk processing (summarize 100 articles, classify 1000 items)
- Codebase-wide analysis across many files
- Any task that can be split into identical independent units
