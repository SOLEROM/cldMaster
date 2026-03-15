---
name: accessibility
description: Web accessibility audit and fixes (WCAG 2.1 AA). Use when building UI components, reviewing frontend code, or when asked about a11y compliance.
argument-hint: [component-or-page]
---

# Accessibility Review (WCAG 2.1 AA)

Audit the specified component or page for accessibility issues. WCAG 2.1 AA is the standard for most legal compliance requirements (ADA, EU Accessibility Act).

---

## The Four Principles (POUR)

**Perceivable** — Information is presentable in ways users can perceive
**Operable** — UI components must be operable by everyone
**Understandable** — Information and UI operation must be understandable
**Robust** — Content must be interpretable by assistive technologies

---

## Checklist by Category

### Semantic HTML
- [ ] Headings form a logical hierarchy (h1 → h2 → h3, no skipping)
- [ ] `<button>` for actions, `<a>` for navigation (not `<div onClick>`)
- [ ] `<main>`, `<nav>`, `<header>`, `<footer>`, `<section>` landmarks present
- [ ] Lists use `<ul>`/`<ol>`, not divs with bullets
- [ ] Tables use `<th>` with `scope` attribute, `<caption>` for data tables
- [ ] `<form>` elements have associated `<label>` (not just placeholder)

### Images & Media
- [ ] All `<img>` have `alt` text
  - Decorative images: `alt=""` (empty, not missing)
  - Informative images: describe the content, not "image of..."
  - Functional images (icons as buttons): describe the action
- [ ] Complex images (charts, graphs) have extended description
- [ ] Videos have captions; audio has transcripts
- [ ] Animations can be paused (prefers-reduced-motion respected)

### Keyboard Navigation
- [ ] All interactive elements reachable by Tab key
- [ ] Tab order is logical (matches visual order)
- [ ] No keyboard traps (user can Tab out of any component)
- [ ] Custom widgets have keyboard interactions per ARIA patterns:
  - Dropdown: Arrow keys to navigate, Escape to close
  - Modal: Focus trapped inside, Escape to close, returns focus on close
  - Tabs: Arrow keys to switch tabs
- [ ] Skip-to-content link as first focusable element

### Focus Management
- [ ] Focus indicator visible (not removed with `outline: none` without replacement)
- [ ] After modal opens, focus moves inside
- [ ] After modal closes, focus returns to trigger element
- [ ] After dynamic content loads, focus moves to new content or announcement

### Color & Contrast
- [ ] Normal text: minimum 4.5:1 contrast ratio
- [ ] Large text (18pt+ or 14pt+ bold): minimum 3:1 contrast ratio
- [ ] UI components and focus indicators: minimum 3:1 against adjacent colors
- [ ] Information not conveyed by color alone (error states use icon + color + text)
- [ ] Links distinguishable from surrounding text by more than color

### ARIA (Use Sparingly — Semantic HTML First)
- [ ] `aria-label` on icon-only buttons: `<button aria-label="Close dialog">`
- [ ] `aria-expanded` on toggles (accordions, dropdowns)
- [ ] `aria-controls` linking trigger to controlled element
- [ ] `role` only used when no semantic HTML element fits
- [ ] `aria-live` regions for dynamic content updates (status messages, errors)
- [ ] `aria-describedby` for inputs with helper text
- [ ] Never use ARIA to override wrong semantic HTML — fix the HTML instead

### Forms
- [ ] Every input has a visible `<label>` (not just placeholder)
- [ ] Required fields indicated (and `aria-required="true"`)
- [ ] Error messages associated with the field (`aria-describedby`)
- [ ] Error messages explain how to fix, not just that there's an error
- [ ] Success/error states announced to screen readers (`aria-live`)
- [ ] `autocomplete` attribute on personal data fields

### Motion & Animation
- [ ] `@media (prefers-reduced-motion: reduce)` respected
- [ ] Auto-playing animations stop after 5 seconds or have pause control
- [ ] No content flashing more than 3 times per second (seizure risk)

---

## Quick Wins (Common Fixes)

```html
<!-- Missing alt text -->
<img src="chart.png">                         <!-- BAD -->
<img src="chart.png" alt="Revenue grew 40% Q3 2024">  <!-- GOOD -->

<!-- Div button (not keyboard accessible) -->
<div onclick="submit()">Submit</div>          <!-- BAD -->
<button type="submit">Submit</button>          <!-- GOOD -->

<!-- Placeholder as label -->
<input placeholder="Email">                   <!-- BAD -->
<label for="email">Email</label>
<input id="email" placeholder="you@example.com">  <!-- GOOD -->

<!-- Color-only error state -->
<input class="red-border">                    <!-- BAD -->
<input aria-invalid="true" aria-describedby="email-error">
<span id="email-error" role="alert">Please enter a valid email</span>  <!-- GOOD -->
```

---

## Testing Tools

- **Automated**: axe DevTools, Lighthouse, WAVE
- **Keyboard**: Tab through entire page without a mouse
- **Screen reader**: NVDA + Firefox (Windows), VoiceOver + Safari (Mac)
- **Color contrast**: WebAIM Contrast Checker

Note: Automated tools catch ~30% of accessibility issues. Manual testing is required.
