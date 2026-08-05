---
title: "Design system (graphs, colors, layout)"
type: story
status: planned
priority: medium
estimate: XXL
labels: [frontend, design, design-system, ux, 1a]
date: ~
---

Design-system bucket owned by the UX engineer: the shared visual language for the portal surfaces — color tokens, layout/grid, typography, and the chart/graph styling reused across the read surfaces (Golden Record / Identity Map / Source Status / Data Health) and the admin UIs. A reserved bucket (not decomposed yet) so frontend stories compose a consistent surface instead of reinventing styling per screen.

**Governing library:** use **only and exclusively `DAS | MAIN DESIGN`** for this product. All components, component instances, variants, variables, color/text/effect styles, icons, and layout tokens used in the product design must come from `DAS | MAIN DESIGN`. Do not use or mix assets from `ANA APP | DESIGN SYSTEM`, `DSCPLES | DESIGN SYSTEM`, or any other Figma library. Storybook is the implementation source of truth; the `DAS | MAIN DESIGN` Figma library is the product-design source of truth.

**Acceptance:** design tokens (color palette, typography scale, spacing/layout grid) and chart/graph style specs exist as a single shared source in the Next.js app and are documented; at least one read surface and one admin screen consume the shared tokens/components (no per-screen hardcoded styling for those values); changing a token updates both consuming surfaces; `next build` succeeds with the shared module in place.

**References:**
- Decided 2026-06-13 (Phase 0 arch): Next.js (TypeScript) frontend on `boilerworks-django-nextjs`, 4 read surfaces (Golden Record / Identity Map / Source Status / Data Health) — `memory/decisions.md#d-087`
- `wiki/Frontend.md` — the four read surfaces and admin/operator (not consumer-facing) scope this design system styles
- `wiki/Tech-Stack.md` — canonical frontend stack the tokens/components target
- `DAS | MAIN DESIGN` — the only permitted Figma component and token library for the product
- Storybook — the implementation source of truth for component behavior, variants, and styling
