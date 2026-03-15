# Streamlit Fragments - Advanced Patterns

## Overview

Fragments allow you to rerun only specific parts of your Streamlit app, significantly improving performance for interactive applications. This reference provides detailed patterns and examples.

## Basic Fragment Pattern

```python
import streamlit as st

@st.fragment
def interactive_section():
    # Only this section reruns when widgets inside change
    value = st.slider("Select value", 0, 100)
    st.write(f"Selected: {value}")
    
# Main app continues here
st.title("My App")
interactive_section()
```

## Auto-Rerun Fragments

Fragments can automatically rerun at specified intervals:

```python
@st.fragment(run_every="10s")
def live_data_stream():
    import time
    current_time = time.time()
    
    # Fetch new data
    data = fetch_latest_metrics()
    
    # Update display
    st.metric("Current Value", data['value'])
    st.line_chart(data['history'])
```

**Supported intervals:**
- Seconds: `"10s"`, `"30s"`
- Minutes: `"1m"`, `"5m"`
- Hours: `"1h"`

## Triggering Full Reruns from Fragments

Sometimes a fragment needs to trigger a full app rerun:

```python
@st.fragment
def date_selector(data):
    selected_date = st.date_input(
        "Pick a day",
        value=date(2023, 1, 1),
        key="selected_date"
    )
    
    # Track previous date to detect month changes
    if "previous_date" not in st.session_state:
        st.session_state.previous_date = selected_date
    
    previous_date = st.session_state.previous_date
    st.session_state.previous_date = selected_date
    
    # Trigger full rerun if month changed
    is_new_month = selected_date.replace(day=1) != previous_date.replace(day=1)
    if is_new_month:
        st.rerun()  # Full app rerun
    
    # Display data for selected date
    st.dataframe(data.loc[selected_date])
```

## Fragment with Session State

Fragments work seamlessly with session state:

```python
@st.fragment
def counter_fragment():
    if "count" not in st.session_state:
        st.session_state.count = 0
    
    col1, col2 = st.columns(2)
    
    if col1.button("Increment"):
        st.session_state.count += 1
    
    if col2.button("Decrement"):
        st.session_state.count -= 1
    
    st.metric("Counter", st.session_state.count)
```

## Performance Optimization Pattern

Use fragments to isolate expensive operations:

```python
import time

@st.fragment
def quick_filters():
    # Fast interactive filters
    category = st.selectbox("Category", ["A", "B", "C"])
    min_value = st.slider("Min Value", 0, 100)
    return category, min_value

# Expensive operation outside fragment
@st.cache_data
def load_large_dataset():
    time.sleep(2)  # Simulates expensive load
    return pd.read_csv("large_file.csv")

# Main app
st.title("Data Explorer")
data = load_large_dataset()  # Only runs once

# Fragment for interactive filtering
category, min_value = quick_filters()

# Filter and display
filtered = data[(data['category'] == category) & (data['value'] >= min_value)]
st.dataframe(filtered)
```

## Rolling Window Pattern

Maintain a rolling window of data with auto-rerun:

```python
@st.fragment(run_every="2s")
def rolling_data_display():
    import time
    
    # Initialize session state
    if "data" not in st.session_state:
        st.session_state.data = pd.DataFrame()
    
    # Fetch new data point
    new_point = {
        'timestamp': time.time(),
        'value': np.random.randn()
    }
    
    # Append to existing data
    st.session_state.data = pd.concat([
        st.session_state.data,
        pd.DataFrame([new_point])
    ])
    
    # Keep only last 100 points
    st.session_state.data = st.session_state.data.tail(100)
    
    # Display
    st.line_chart(st.session_state.data.set_index('timestamp'))
```

## Multiple Fragments Pattern

Combine multiple independent fragments:

```python
@st.fragment
def sidebar_controls():
    st.sidebar.header("Controls")
    speed = st.sidebar.slider("Speed", 1, 10)
    return speed

@st.fragment(run_every="1s")
def live_counter(speed):
    if "counter" not in st.session_state:
        st.session_state.counter = 0
    
    st.session_state.counter += speed
    st.metric("Counter", st.session_state.counter)

@st.fragment
def reset_button():
    if st.button("Reset"):
        st.session_state.counter = 0
        st.rerun()

# Main app
st.title("Multi-Fragment App")
speed = sidebar_controls()
live_counter(speed)
reset_button()
```

## Best Practices

1. **Keep fragments focused**: Each fragment should handle one interactive concern
2. **Minimize fragment size**: Smaller fragments = faster reruns
3. **Use session state**: Share data between fragments and main app
4. **Avoid nested fragments**: Don't define fragments inside fragments
5. **Cache expensive operations**: Use `@st.cache_data` outside fragments
6. **Consider full reruns**: Use `st.rerun()` when fragment changes affect entire app

## Common Pitfalls

**❌ Don't do this:**
```python
@st.fragment
def bad_fragment():
    # Loading data inside fragment - runs every rerun!
    data = pd.read_csv("large_file.csv")
    st.dataframe(data)
```

**✅ Do this instead:**
```python
@st.cache_data
def load_data():
    return pd.read_csv("large_file.csv")

@st.fragment
def good_fragment():
    data = load_data()  # Cached, won't reload
    st.dataframe(data)
```
