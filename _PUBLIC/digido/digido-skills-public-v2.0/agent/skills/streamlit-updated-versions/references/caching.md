# Streamlit Caching - Comprehensive Guide

## Overview

Modern Streamlit caching uses two decorators: `st.cache_data` for data operations and `st.cache_resource` for global resources. This replaces the deprecated `st.cache`.

## st.cache_data - Data Operations

### Basic Usage

```python
import streamlit as st
import pandas as pd

@st.cache_data
def load_csv(file_path):
    return pd.read_csv(file_path)

# Cached on first call, returns cached result on subsequent calls
df = load_csv("data.csv")
```

### Common Use Cases

#### Database Queries
```python
@st.cache_data(ttl=600)  # Cache for 10 minutes
def fetch_users():
    conn = create_connection()
    return pd.read_sql("SELECT * FROM users", conn)
```

#### API Calls
```python
@st.cache_data(ttl=3600)  # Cache for 1 hour
def fetch_weather(city):
    response = requests.get(f"https://api.weather.com/{city}")
    return response.json()
```

#### Data Transformations
```python
@st.cache_data
def process_data(df):
    # Expensive transformations
    df['new_column'] = df['old_column'].apply(complex_function)
    return df.groupby('category').agg({'value': 'sum'})
```

#### ML Inference
```python
@st.cache_data
def predict(model, input_data):
    # Cache predictions for same inputs
    return model.predict(input_data)
```

### Parameters

#### TTL (Time To Live)
```python
@st.cache_data(ttl=600)  # Seconds
def get_stock_price(symbol):
    return fetch_price(symbol)

@st.cache_data(ttl="1h")  # Also accepts: "30s", "5m", "2h", "1d"
def get_daily_summary():
    return calculate_summary()
```

#### Max Entries
```python
@st.cache_data(max_entries=100)
def expensive_calculation(param):
    # Only keeps 100 most recent results
    return complex_math(param)
```

#### Show Spinner
```python
@st.cache_data(show_spinner=False)
def silent_load():
    return load_data()

@st.cache_data(show_spinner="Loading data...")
def custom_spinner():
    return load_data()
```

#### Persist
```python
@st.cache_data(persist="disk")
def load_huge_dataset():
    # Persists cache to disk across sessions
    return pd.read_parquet("huge_file.parquet")
```

### Cache Invalidation

#### Manual Clear
```python
# Clear specific function cache
load_csv.clear()

# Clear all st.cache_data caches
st.cache_data.clear()
```

#### Conditional Caching
```python
@st.cache_data
def get_data(force_refresh=False):
    if force_refresh:
        get_data.clear()
    return fetch_data()

# Usage
if st.button("Refresh"):
    data = get_data(force_refresh=True)
else:
    data = get_data()
```

## st.cache_resource - Global Resources

### Basic Usage

```python
@st.cache_resource
def load_model():
    model = torchvision.models.resnet50(pretrained=True)
    model.eval()
    return model

# Loaded once and reused across all users
model = load_model()
```

### Common Use Cases

#### ML Models
```python
@st.cache_resource
def load_transformer_model():
    from transformers import AutoModelForSequenceClassification
    model = AutoModelForSequenceClassification.from_pretrained("bert-base-uncased")
    return model
```

#### Database Connections
```python
@st.cache_resource
def get_database_connection():
    from sqlalchemy import create_engine
    engine = create_engine("postgresql://user:pass@localhost/db")
    return engine

# Reuse connection
engine = get_database_connection()
df = pd.read_sql("SELECT * FROM table", engine)
```

#### Tokenizers and Preprocessors
```python
@st.cache_resource
def load_tokenizer():
    from transformers import AutoTokenizer
    return AutoTokenizer.from_pretrained("bert-base-uncased")
```

#### Configuration Objects
```python
@st.cache_resource
def load_config():
    import yaml
    with open("config.yaml") as f:
        return yaml.safe_load(f)
```

### UI Caching with st.cache_resource

Cache UI elements that don't change:

```python
@st.cache_resource
def show_model_info():
    st.header("Model Information")
    st.info("Using ResNet-50 architecture")
    st.success("Model loaded successfully!")
    
    model = torchvision.models.resnet50(pretrained=True)
    model.eval()
    return model

# UI elements are cached and replayed
model = show_model_info()
```

### Parameters

#### Show Spinner
```python
@st.cache_resource(show_spinner="Loading model...")
def load_large_model():
    return load_model()
```

#### Validate
```python
@st.cache_resource(validate=lambda x: x.is_alive())
def get_connection():
    return create_connection()
```

### Cache Management

```python
# Clear specific resource cache
load_model.clear()

# Clear all st.cache_resource caches
st.cache_resource.clear()
```

## Migration from st.cache

### Old Code (Deprecated)
```python
@st.cache(allow_output_mutation=True, suppress_st_warning=True)
def load_data():
    return pd.read_csv("data.csv")
```

### New Code
```python
@st.cache_data
def load_data():
    return pd.read_csv("data.csv")
```

### Migration Guide

| Old Pattern | New Pattern |
|-------------|-------------|
| `@st.cache` for data | `@st.cache_data` |
| `@st.cache` for models | `@st.cache_resource` |
| `allow_output_mutation=True` | Remove (not needed) |
| `suppress_st_warning=True` | Remove (not needed) |
| `ttl=600` | `ttl=600` (same) |
| `max_entries=100` | `max_entries=100` (same) |

## Best Practices

### 1. Choose the Right Decorator

**Use `st.cache_data` for:**
- DataFrames and data transformations
- Database query results
- API responses
- Serializable objects
- Pure functions

**Use `st.cache_resource` for:**
- ML models
- Database connections
- Non-serializable objects
- Global singletons
- Expensive initializations

### 2. Set Appropriate TTL

```python
# Real-time data: short TTL
@st.cache_data(ttl=60)
def get_stock_price():
    return fetch_price()

# Static data: no TTL
@st.cache_data
def load_reference_data():
    return pd.read_csv("reference.csv")

# Daily updates: long TTL
@st.cache_data(ttl="1d")
def get_daily_report():
    return generate_report()
```

### 3. Handle Cache Misses Gracefully

```python
@st.cache_data
def safe_load_data():
    try:
        return pd.read_csv("data.csv")
    except FileNotFoundError:
        st.error("Data file not found!")
        return pd.DataFrame()
```

### 4. Use Hash Functions for Complex Parameters

```python
@st.cache_data
def process_dataframe(_df):  # Underscore prefix skips hashing
    # Process the dataframe
    return _df.groupby('category').sum()
```

### 5. Combine Caching Strategies

```python
@st.cache_resource
def load_model():
    return torch.load("model.pth")

@st.cache_data
def predict(_model, input_data):  # _model not hashed
    return _model.predict(input_data)

# Usage
model = load_model()  # Cached resource
result = predict(model, user_input)  # Cached data
```

## Performance Tips

1. **Cache expensive operations**: Database queries, API calls, file I/O
2. **Don't cache everything**: Simple operations don't need caching
3. **Monitor cache size**: Use `max_entries` to prevent memory issues
4. **Use appropriate TTL**: Balance freshness vs. performance
5. **Clear caches strategically**: Provide refresh buttons when needed
6. **Profile your app**: Use Streamlit's built-in profiler to identify bottlenecks
