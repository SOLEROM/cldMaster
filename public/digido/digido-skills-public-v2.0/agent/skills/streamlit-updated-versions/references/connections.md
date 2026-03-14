# Streamlit Connections - Database Integration Guide

## Overview

`st.connection` provides a unified interface for connecting to databases and external services with built-in caching and secrets management.

## SQL Connections

### Basic Setup

```python
import streamlit as st

# Create connection (requires SQLAlchemy)
conn = st.connection('mydb', type='sql')

# Query with automatic caching
df = conn.query('SELECT * FROM users LIMIT 100', ttl=600)
st.dataframe(df)
```

### Configuration

Add connection details to `.streamlit/secrets.toml`:

```toml
[connections.mydb]
url = "postgresql://username:password@localhost:5432/database"
```

Or for separate components:

```toml
[connections.mydb]
dialect = "postgresql"
host = "localhost"
port = 5432
database = "mydb"
username = "user"
password = "password"
```

### Advanced SQL Usage

#### Custom Queries with Parameters
```python
@st.cache_data(ttl=600)
def get_user_data(_conn, user_id):
    query = "SELECT * FROM users WHERE id = :user_id"
    return _conn.query(query, params={"user_id": user_id})

conn = st.connection('mydb', type='sql')
user_data = get_user_data(conn, 123)
```

#### Using SQLAlchemy Session
```python
conn = st.connection('mydb', type='sql')

# Get SQLAlchemy session
session = conn.session

# Use ORM
from models import User
users = session.query(User).filter(User.active == True).all()
```

#### Write Operations
```python
conn = st.connection('mydb', type='sql')

# Insert data
conn.session.execute(
    "INSERT INTO users (name, email) VALUES (:name, :email)",
    {"name": "John", "email": "john@example.com"}
)
conn.session.commit()
```

## Snowflake Connections

### Basic Setup

```python
import streamlit as st

# Create Snowflake connection
conn = st.connection('snowflake')

# Query data
df = conn.query('SELECT * FROM sales WHERE date > CURRENT_DATE - 7')
st.dataframe(df)
```

### Configuration

`.streamlit/secrets.toml`:

```toml
[connections.snowflake]
account = "your-account"
user = "your-username"
password = "your-password"
warehouse = "your-warehouse"
database = "your-database"
schema = "your-schema"
role = "your-role"
```

### Advanced Snowflake Usage

#### Multiple Queries
```python
conn = st.connection('snowflake')

# Run multiple queries
sales_df = conn.query('SELECT * FROM sales', ttl=600)
products_df = conn.query('SELECT * FROM products', ttl=3600)

# Join in pandas
merged = sales_df.merge(products_df, on='product_id')
st.dataframe(merged)
```

#### Using Snowpark
```python
conn = st.connection('snowflake')

# Get Snowpark session
session = conn.session()

# Use Snowpark DataFrame API
df = session.table('sales').filter(col('amount') > 1000)
pandas_df = df.to_pandas()
st.dataframe(pandas_df)
```

## Custom Connections

### Creating a Custom Connection Class

```python
from streamlit.connections import ExperimentalBaseConnection
import requests

class APIConnection(ExperimentalBaseConnection):
    def _connect(self, **kwargs):
        # Initialize connection
        self.api_key = self._secrets.get("api_key")
        self.base_url = self._secrets.get("base_url")
        return self
    
    def query(self, endpoint, ttl=600):
        @st.cache_data(ttl=ttl)
        def _query(endpoint):
            response = requests.get(
                f"{self.base_url}/{endpoint}",
                headers={"Authorization": f"Bearer {self.api_key}"}
            )
            return response.json()
        
        return _query(endpoint)

# Usage
conn = st.connection('myapi', type=APIConnection)
data = conn.query('users')
```

### Configuration for Custom Connection

`.streamlit/secrets.toml`:

```toml
[connections.myapi]
api_key = "your-api-key"
base_url = "https://api.example.com"
```

## Connection Patterns

### Pattern 1: Cached Queries

```python
conn = st.connection('mydb', type='sql')

# Cache for 10 minutes
recent_data = conn.query(
    'SELECT * FROM events WHERE created_at > NOW() - INTERVAL 1 DAY',
    ttl=600
)

# Cache for 1 hour
reference_data = conn.query(
    'SELECT * FROM categories',
    ttl=3600
)
```

### Pattern 2: User-Specific Queries

```python
conn = st.connection('mydb', type='sql')

user_id = st.text_input("User ID")

if user_id:
    @st.cache_data(ttl=300)
    def get_user_orders(_conn, uid):
        return _conn.query(
            'SELECT * FROM orders WHERE user_id = :uid',
            params={"uid": uid}
        )
    
    orders = get_user_orders(conn, user_id)
    st.dataframe(orders)
```

### Pattern 3: Multiple Databases

```python
# Production database
prod_conn = st.connection('production', type='sql')
prod_data = prod_conn.query('SELECT * FROM sales')

# Analytics database
analytics_conn = st.connection('analytics', type='sql')
analytics_data = analytics_conn.query('SELECT * FROM metrics')

# Compare
st.write("Production:", len(prod_data))
st.write("Analytics:", len(analytics_data))
```

### Pattern 4: Connection Pooling

```python
@st.cache_resource
def get_connection():
    return st.connection('mydb', type='sql')

# Reuse connection across app
conn = get_connection()
df1 = conn.query('SELECT * FROM table1')
df2 = conn.query('SELECT * FROM table2')
```

## Error Handling

### Graceful Failures

```python
conn = st.connection('mydb', type='sql')

try:
    df = conn.query('SELECT * FROM users', ttl=600)
    st.dataframe(df)
except Exception as e:
    st.error(f"Database error: {e}")
    st.info("Using cached data...")
    # Fallback to cached data or default
```

### Connection Testing

```python
def test_connection():
    try:
        conn = st.connection('mydb', type='sql')
        conn.query('SELECT 1')
        return True
    except Exception as e:
        st.error(f"Connection failed: {e}")
        return False

if test_connection():
    st.success("Database connected!")
else:
    st.warning("Database unavailable")
```

## Performance Optimization

### 1. Appropriate TTL Values

```python
# Real-time data: short TTL
live_data = conn.query('SELECT * FROM live_metrics', ttl=60)

# Reference data: long TTL
categories = conn.query('SELECT * FROM categories', ttl=86400)

# No cache for write operations
conn.query('INSERT INTO logs VALUES (...)', ttl=0)
```

### 2. Limit Result Sets

```python
# Paginated queries
page_size = 100
offset = st.number_input("Page", min_value=0) * page_size

df = conn.query(
    f'SELECT * FROM users LIMIT {page_size} OFFSET {offset}',
    ttl=600
)
```

### 3. Selective Column Loading

```python
# Only load needed columns
df = conn.query(
    'SELECT id, name, email FROM users',  # Not SELECT *
    ttl=600
)
```

### 4. Aggregate on Database Side

```python
# Better: aggregate in database
summary = conn.query(
    'SELECT category, COUNT(*) as count FROM products GROUP BY category',
    ttl=600
)

# Worse: load all data then aggregate in pandas
# all_products = conn.query('SELECT * FROM products')
# summary = all_products.groupby('category').size()
```

## Best Practices

1. **Use secrets for credentials**: Never hardcode database credentials
2. **Set appropriate TTL**: Balance freshness vs. performance
3. **Handle errors gracefully**: Provide fallbacks for connection failures
4. **Limit query results**: Use LIMIT and WHERE clauses
5. **Cache expensive queries**: Use `ttl` parameter for frequently-run queries
6. **Close connections properly**: Let Streamlit manage connection lifecycle
7. **Use connection pooling**: Cache connection objects with `@st.cache_resource`
8. **Test connections**: Verify connectivity before running main queries

## Migration from Manual Connections

### Before (Manual Connection)

```python
import streamlit as st
from sqlalchemy import create_engine

@st.cache_resource
def get_engine():
    return create_engine("postgresql://user:pass@localhost/db")

@st.cache_data(ttl=600)
def load_data():
    engine = get_engine()
    return pd.read_sql("SELECT * FROM users", engine)

df = load_data()
```

### After (st.connection)

```python
import streamlit as st

conn = st.connection('mydb', type='sql')
df = conn.query('SELECT * FROM users', ttl=600)
```

**Benefits:**
- Less boilerplate code
- Automatic secrets management
- Built-in caching
- Consistent interface across connection types
