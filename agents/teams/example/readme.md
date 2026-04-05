# examples

```
cp *.md .claude/agents/
```


### 1. Code Reviewer (`code-reviewer.md`)

**Purpose**: Comprehensive code quality and maintainability analysis

**Tools**: Read, Grep, Glob, Bash

**Specialization**:
- Security vulnerability detection
- Performance optimization identification
- Code maintainability assessment
- Test coverage analysis

**Use When**: You need automated code reviews with focus on quality and security

---

### 2. Test Engineer (`test-engineer.md`)

**Purpose**: Test strategy, coverage analysis, and automated testing

**Tools**: Read, Write, Bash, Grep

**Specialization**:
- Unit test creation
- Integration test design
- Edge case identification
- Coverage analysis (>80% target)

**Use When**: You need comprehensive test suite creation or coverage analysis

---

### 3. Documentation Writer (`documentation-writer.md`)

**Purpose**: Technical documentation, API docs, and user guides

**Tools**: Read, Write, Grep

**Specialization**:
- API endpoint documentation
- User guide creation
- Architecture documentation
- Code comment improvement

**Use When**: You need to create or update project documentation

---

### 4. Secure Reviewer (`secure-reviewer.md`)

**Purpose**: Security-focused code review with minimal permissions

**Tools**: Read, Grep

**Specialization**:
- Security vulnerability detection
- Authentication/authorization issues
- Data exposure risks
- Injection attack identification

**Use When**: You need security audits without modification capabilities

---

### 5. Implementation Agent (`implementation-agent.md`)

**Purpose**: Full implementation capabilities for feature development

**Tools**: Read, Write, Edit, Bash, Grep, Glob

**Specialization**:
- Feature implementation
- Code generation
- Build and test execution
- Codebase modification

**Use When**: You need a subagent to implement features end-to-end

---

### 6. Debugger (`debugger.md`)

**Purpose**: Debugging specialist for errors, test failures, and unexpected behavior

**Tools**: Read, Edit, Bash, Grep, Glob

**Specialization**:
- Root cause analysis
- Error investigation
- Test failure resolution
- Minimal fix implementation

**Use When**: You encounter bugs, errors, or unexpected behavior

---

### 7. Data Scientist (`data-scientist.md`)

**Purpose**: Data analysis expert for SQL queries and data insights

**Tools**: Bash, Read, Write

**Specialization**:
- SQL query optimization
- BigQuery operations
- Data analysis and visualization
- Statistical insights

**Use When**: You need data analysis, SQL queries, or BigQuery operations

---