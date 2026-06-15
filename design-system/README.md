# Calliope Design System

Standalone Storybook with the **core components** and **brand tokens** for Calliope,
built on [shadcn/ui](https://ui.shadcn.com) (React + Tailwind + Radix). Use this as the
source of truth for consistent buttons, colors, typography, etc. when building the new
landing page (and the Astralift site).

Tokens were extracted from the live `calliope.ai` (see `reference/` — screenshots +
`calliope-tokens.json`), so components match the real brand: deep navy `#162345`,
cyan `#3FF1EF` (primary CTA), purple `#5A4DC7` (secondary).

## Run

```bash
cd design-system
npm install
npm run storybook        # http://localhost:6006
```

## Build static Storybook

```bash
npm run build-storybook  # -> storybook-static/
```

## What's inside

```
src/
  index.css                 # brand CSS variables (dark-first) + Tailwind layers
  lib/utils.ts              # cn() helper
  components/ui/            # shadcn components: button, badge, card, input, label
    *.stories.tsx           # one story file per component
  foundations/
    Colors.stories.tsx      # brand + semantic color palette
    Typography.stories.tsx  # type scale
tailwind.config.ts          # maps tokens -> Tailwind theme
reference/                  # extracted screenshots + tokens from calliope.ai
```

## Adding more shadcn components

These are plain shadcn components — copy any new one from the shadcn registry into
`src/components/ui/`, and it will inherit the Calliope theme automatically through the
CSS variables in `index.css`. Add a matching `*.stories.tsx` next to it.
