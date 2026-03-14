---
name: streamlit-updated-versions
description: Comprehensive guide for using the latest Streamlit features and best practices. Use when working with Streamlit applications and need information about modern features like st.fragment, st.dialog, st.navigation, st.connection, st.cache_data, st.cache_resource, or when upgrading from older Streamlit versions. Also use when building new Streamlit apps to ensure best practices are followed.
---

# Streamlit Updated Versions

## Overview

This skill provides guidance on the latest Streamlit features, components, and best practices based on official documentation. It helps developers leverage modern Streamlit capabilities for building performant, interactive data applications.

## Core Modern Features

### 1. Fragments - Partial Reruns (`st.fragment`)

Use fragments to improve performance by rerunning only specific parts of your app instead of the entire script.

```python
@st.fragment
def show_daily_sales(data):
    selected_date = st.date_input("Pick a day", key="selected_date")
    # Only this fragment reruns when the date changes
    st.dataframe(data.loc[selected_date])
    st.bar_chart(data.loc[selected_date])
```

**When to use:**
- Dynamic sections that update frequently
- Interactive widgets that don't need full app rerun
- Performance optimization for large apps

**Auto-rerun fragments:**
```python
@st.fragment(run_every="10s")
def stream_data():
    # Automatically reruns every 10 seconds
    new_data = fetch_latest_data()
    st.line_chart(new_data)
```

### 2. Dialogs - Modal Overlays (`st.dialog`)

Create modal dialogs that can rerun independently from the main app.

```python
@st.dialog("Settings")
def show_settings():
    st.write("Configure your preferences")
    theme = st.selectbox("Theme", ["Light", "Dark"])
    if st.button("Save"):
        st.session_state.theme = theme
        st.rerun()

if st.button("Open Settings"):
    show_settings()
```

**Version notes:**
- Introduced in v1.34.0 as `st.experimental_dialog`
- v1.53.0 added `icon` parameter for dialog titles

### 3. Navigation - Multi-Page Apps (`st.navigation`)

Build multi-page apps with global widgets that persist across pages.

```python
# streamlit_app.py (entrypoint)
import streamlit as st

# Global widgets persist across all pages
user_name = st.sidebar.text_input("Name", key="global_name")
user_role = st.sidebar.selectbox("Role", ["User", "Admin"], key="global_role")

# Define navigation
page = st.navigation([
    st.Page("pages/dashboard.py", title="Dashboard"),
    st.Page("pages/settings.py", title="Settings"),
    st.Page("pages/analytics.py", title="Analytics"),
])
page.run()
```

**Benefits:**
- Global state management across pages
- Consistent navigation structure
- Better widget persistence

### 4. Connections - Database Integration (`st.connection`)

Simplified database connections with automatic caching and secrets management.

```python
import streamlit as st

# SQL Connection (requires SQLAlchemy)
conn = st.connection('mydb', type='sql')
df = conn.query('SELECT * FROM users LIMIT 100', ttl=600)
st.dataframe(df)

# Snowflake Connection
snow_conn = st.connection('snowflake')
snow_df = snow_conn.query('SELECT * FROM sales')
```

**Advantages:**
- Automatic connection caching
- Built-in secrets management
- Reduced boilerplate code
- TTL-based query caching

### 5. Modern Caching

**Replace old `st.cache` with:**

#### `st.cache_data` - For Data Operations
```python
@st.cache_data
def load_data():
    # Cache DataFrames, query results, transformations
    return pd.read_csv("data.csv")

@st.cache_data
def process_data(df):
    # Cached data transformations
    return df.groupby('category').sum()
```

**Use for:**
- DataFrames and data transformations
- Database queries
- API calls returning data
- ML inference results

#### `st.cache_resource` - For Global Resources
```python
@st.cache_resource
def load_model():
    # Cache ML models, database connections
    model = torchvision.models.resnet50(weights=ResNet50_Weights.DEFAULT)
    model.eval()
    return model

@st.cache_resource
def get_database_connection():
    # Cache database connections
    return create_engine("postgresql://...")
```

**Use for:**
- ML models
- Database connections
- Global objects
- Expensive initialization

**UI Caching:**
```python
@st.cache_resource
def load_model():
    st.header("Data analysis")
    model = torchvision.models.resnet50(weights=ResNet50_Weights.DEFAULT)
    st.success("Loaded model!")
    return model
```

**Migration notes:**
- `st.cache` deprecated since v1.18.0
- Remove `allow_output_mutation` parameter (no longer needed)
- Remove `suppress_st_warning` parameter (no longer needed)

## Upgrading Streamlit

### Using pip
```bash
pip install --upgrade streamlit
streamlit version
```

### Using Pipenv
```bash
# Navigate to project directory
cd your_project

# Activate environment and upgrade
pipenv update streamlit

# Verify version
pipenv run streamlit version
```

### Using Poetry
```bash
poetry update streamlit
poetry run streamlit version
```

## Additional Components

For extended functionality, consider these community components:

### Streamlit AgGrid
- Interactive data grids with cell editing
- Advanced filtering and sorting
- 52+ code examples available
- High source reputation

### Extra Streamlit Components
- Router for navigation
- Cookie manager
- Tab bars
- Bouncing images
- Stepper bars

## Best Practices

1. **Use fragments** for performance optimization in dynamic sections
2. **Migrate to modern caching** - replace `st.cache` with `st.cache_data` or `st.cache_resource`
3. **Leverage st.connection** for simplified database access
4. **Use st.dialog** for better UX with modal interactions
5. **Implement st.navigation** for multi-page apps with global state
6. **Keep Streamlit updated** to access latest features and bug fixes
7. **Use TTL caching** with connections to balance freshness and performance

## Reference Documentation

For detailed examples and advanced patterns, see:
- [references/fragments.md](references/fragments.md) - Advanced fragment patterns and auto-reruns
- [references/caching.md](references/caching.md) - Comprehensive caching strategies
- [references/connections.md](references/connections.md) - Database connection patterns

## Version History

- **v1.53.0**: Dialog icon parameter
- **v1.34.0**: Experimental dialog introduced
- **v1.18.0**: New caching commands (`st.cache_data`, `st.cache_resource`)
- Earlier versions: Audio/video improvements, YouTube embedding, URL media loading
