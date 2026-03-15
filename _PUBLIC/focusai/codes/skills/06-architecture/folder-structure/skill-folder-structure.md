---
name: folder-structure
description: Project folder structure design and organization patterns. Auto-load when organizing a new project, restructuring an existing one, or when asked how to organize files for a specific framework.
---

# Folder Structure Reference

How you organize files determines how fast your team can find, change, and reason about code.

## Core Principle: Organize by Feature, Not by Type

```
❌ Organize by type (the classic mistake)
src/
  components/
    Header.jsx
    ProductList.jsx
    UserProfile.jsx
  hooks/
    useAuth.js
    useProducts.js
    useUser.js
  services/
    authService.js
    productService.js
    userService.js

Problem: To work on the "User" feature, you touch 3+ folders.
Everything is coupled by directory, not by domain.

✅ Organize by feature
src/
  features/
    auth/
      AuthHeader.jsx
      useAuth.js
      authService.js
    products/
      ProductList.jsx
      useProducts.js
      productService.js
    user/
      UserProfile.jsx
      useUser.js
      userService.js

Benefit: Everything for a feature is co-located.
Delete the folder = feature is gone cleanly.
```

## Universal Structure (Any Framework)

```
project-root/
  src/             # Application source
  tests/           # Test files (or co-located with source)
  docs/            # Documentation
  scripts/         # Build/utility scripts
  config/          # Configuration files
  .github/         # GitHub workflows, PR templates
  dist/ or build/  # Generated output (gitignored)
```

## React / Next.js

```
src/
  app/                    # Next.js App Router (or pages/)
    (routes)/
      page.tsx
      layout.tsx
  components/
    ui/                   # Generic reusable components (Button, Input, Modal)
    layout/               # Header, Footer, Sidebar
  features/               # Feature-specific components + logic
    auth/
    dashboard/
    settings/
  hooks/                  # Shared custom hooks
  lib/                    # Utilities and helpers
  services/               # API calls, external integrations
  stores/                 # State management (Zustand, Redux)
  types/                  # TypeScript type definitions
  styles/                 # Global styles
```

## Node.js / Express API

```
src/
  routes/           # Route definitions (thin — just routing)
    userRoutes.ts
    orderRoutes.ts
  controllers/      # Request/response handling
    userController.ts
  services/         # Business logic (pure functions, no req/res)
    userService.ts
  repositories/     # Database access layer
    userRepository.ts
  middleware/       # Auth, logging, error handling
    authMiddleware.ts
  models/           # Database models/schemas
    User.ts
  utils/            # Generic utilities
  config/           # App configuration
  types/            # TypeScript types
tests/
  unit/
  integration/
  fixtures/
```

## Astro

```
src/
  pages/            # File-based routing — every .astro here = URL
  components/       # Reusable .astro components
    ui/             # Generic UI components
    layout/         # Header, Footer, Navigation
    sections/       # Page sections (Hero, Features, CTA)
  layouts/          # Page layout wrappers
  content/          # Content collections (blog, docs)
    blog/
    docs/
  styles/           # Global CSS
  lib/              # Utilities
  assets/           # Static assets (processed by Astro)
public/             # Unprocessed static files (favicon, robots.txt)
```

## Python / Django

```
project/
  apps/
    users/
      models.py
      views.py
      serializers.py
      urls.py
      tests/
    orders/
      ...
  core/             # Shared utilities, base classes
  config/           # Settings (base, dev, prod)
    settings/
      base.py
      development.py
      production.py
  requirements/
    base.txt
    development.txt
    production.txt
manage.py
```

## File Naming Conventions

```
# JavaScript/TypeScript
PascalCase:   Components, Classes, Types, Interfaces → UserProfile.tsx, OrderService.ts
camelCase:    Functions, variables, hooks → useAuth.ts, orderUtils.ts
kebab-case:   Routes, CSS files, config files → user-profile.css, api-config.ts

# Python
snake_case:   Everything → user_service.py, order_model.py

# Constants
SCREAMING_SNAKE_CASE: MAX_RETRIES, API_BASE_URL

# Test files
*.test.ts         # Unit tests (co-located with source)
*.spec.ts         # Same as above (jest convention)
*.e2e.ts          # End-to-end tests
__tests__/        # Alternative: test directory next to module
```

## Colocation Rules

**Co-locate code that changes together:**

```
features/
  products/
    ProductList.tsx        # Component
    ProductList.test.tsx   # Its test
    ProductList.module.css # Its styles
    useProducts.ts         # Its hook
    productService.ts      # Its API calls
    types.ts               # Its types
    index.ts               # Public API (barrel export)
```

**Barrel exports (index.ts) — use carefully:**
```typescript
// features/products/index.ts
export { ProductList } from './ProductList';
export { useProducts } from './useProducts';
// DON'T export internal implementation details

// Consumer imports cleanly:
import { ProductList } from '@/features/products';
```

Barrel exports simplify imports but can cause circular dependency issues and slower bundling. Only barrel-export the public API of a feature.

## Depth Guidelines

```
Too shallow (everything in one folder):
src/
  ← 50 files at root level — where is anything?

Too deep (nested 5+ levels):
src/features/auth/components/forms/inputs/validation/
  ← Simple file requires navigating 6 directories

Sweet spot: 3-4 levels deep for most features
```

## What NOT to Do

```
❌ God folders — "utils/", "helpers/", "common/" that accumulate everything
   Fix: Be specific — dateUtils.ts, stringFormatters.ts

❌ Numbered files — component1.tsx, component2.tsx
   Fix: Name by what it does

❌ Deeply nested index files — components/index.js that re-exports
   100 components from other index files
   Fix: Direct imports or shallow barrel exports

❌ Mirroring the framework structure exactly
   Fix: Organize by what your app does, not what the framework does
```

## Restructuring an Existing Project

1. **Don't move everything at once** — high merge conflict risk
2. **One feature at a time** — move files for one domain, get it working, commit
3. **Update imports** — use IDE rename/refactor, not manual find/replace
4. **Use path aliases** — `@/features/auth` prevents breaking import paths when files move

```typescript
// tsconfig.json — path aliases
{
  "compilerOptions": {
    "paths": {
      "@/*": ["./src/*"],
      "@/features/*": ["./src/features/*"]
    }
  }
}
```
