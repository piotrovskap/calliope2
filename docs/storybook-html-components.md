# DAS Storybook HTML Components

## Purpose

The DAS Storybook HTML Components documentation is the implementation reference for building the DAS interface with HTML, Tailwind CSS and DaisyUI.

It defines how the components should be installed, structured, styled and combined in the product UI. The Storybook documentation is the source of truth for component usage in the local HTML prototype.

Reference:

<https://storybook.dastech.app/?path=/docs/html-components_html-components-getting-started--docs>

## Source of truth

The implementation hierarchy is:

```text
DAS Storybook HTML Components
        ↓
HTML structure and component classes
        ↓
Tailwind CSS + DaisyUI
        ↓
localhost prototype
```

Storybook defines the intended component API, markup pattern, variants, states and visual behavior. DaisyUI provides the technical component primitives and utility classes. The product screen combines those components into a complete user flow.

The localhost implementation must not invent a separate visual language for buttons, badges, inputs, dialogs, tooltips, cards or tables when a matching Storybook component exists.

## Installation

The project contains the required packages:

```bash
npm install daisyui
npm install -D tailwindcss @tailwindcss/cli
```

Current packages:

- `daisyui` — `^5.7.16`
- `tailwindcss` — `^4.3.3`
- `@tailwindcss/cli` — `^4.3.3`

## Tailwind and DaisyUI setup

The project uses Tailwind CSS v4. The configuration is kept in CSS rather than in a `tailwind.config.js` file.

Source file:

`customers/daisyui.css`

```css
@import "tailwindcss";
@plugin "daisyui";
@source "./index.html";
```

The `@source` directive tells Tailwind to scan the customer screen for classes used by the static HTML prototype.

## DAS theme

The local theme is named `das` and uses DAS brand values:

```css
@plugin "daisyui/theme" {
  name: "das";
  default: true;
  prefersdark: false;
  color-scheme: light;

  --color-primary: #dd6000;
  --color-primary-content: #ffffff;
  --color-secondary: #54565b;
  --color-secondary-content: #ffffff;
  --color-base-100: #ffffff;
  --color-base-200: #f9fafb;
  --color-base-300: #eaecf0;
  --color-base-content: #4d4d4d;

  --radius-selector: 0.5rem;
  --radius-field: 0.5rem;
  --radius-box: 0.75rem;
}
```

The project uses Satoshi as the primary font. Generic DaisyUI defaults must not replace the DAS font, colors or iconography.

## CSS build

The component CSS is generated with:

```bash
npm run build:customers:css
```

The command uses:

```bash
tailwindcss \
  -i ./customers/daisyui.css \
  -o ./customers/daisyui.generated.css \
  --minify
```

The generated stylesheet is loaded by:

`customers/index.html`

```html
<link rel="stylesheet" href="./daisyui.generated.css" />
```

The CSS is rebuilt automatically before development and deployment through the `predev` and `predeploy` npm scripts.

## How to use components

Components should be built from the HTML patterns documented in Storybook. A component consists of:

1. the semantic HTML element,
2. the Storybook/DaisyUI component class,
3. the correct variant class,
4. the correct size class,
5. the correct state attributes,
6. DAS-specific content, color and icon usage.

Example button pattern:

```html
<button class="btn btn-primary" type="button">
  Add customer
</button>
```

Example outline action:

```html
<button class="btn btn-outline" type="button">
  Review matches
</button>
```

Example disabled state:

```html
<button class="btn btn-primary" type="button" disabled>
  Continue
</button>
```

The exact classes and available variants must be checked in the relevant Storybook component documentation before implementation.

## Components used in Customers

The Customers screen requires the following component groups:

### Buttons

Used for:

- `Add customer`
- `Review matches`
- `Review`
- `More`
- `Continue`
- `Back`
- `Cancel`
- `Confirm merge`
- `Open profile`

Buttons must use Storybook variants. Primary actions use DAS Clementine orange. Secondary or outline actions use the documented neutral treatment.

### Inputs

Used for:

- customer search,
- customer ID search,
- email and phone search,
- merge confirmation fields where applicable.

Inputs must preserve the Storybook focus, disabled, error and placeholder states. Search fields should include a DAS icon from the approved icon set.

### Badges

Used for:

- customer status,
- source labels,
- confidence labels,
- notification counts,
- review state.

Badges must communicate state without relying on color alone. The label must remain explicit, for example `Active`, `Needs review`, `Incomplete` or `High`.

### Cards

Used for:

- KPI metrics,
- customer profile summaries,
- candidate records,
- comparison records,
- resulting Golden Record values.

Cards should use consistent radius, border, padding and elevation from the Storybook pattern. The component must not be recreated with unrelated custom visual rules.

### Tables

Used for the Customers list.

The table should use:

- a semantic `<table>` structure,
- Storybook table styling,
- documented header and row treatment,
- visible hover and focus states,
- consistent cell spacing,
- status and confidence components inside cells,
- a separate action cell.

The table must remain readable when data is missing, duplicated or represented by multiple source records.

### Dialogs and modals

Used for:

- merge review,
- field comparison,
- Golden Record value selection,
- final merge confirmation.

The modal must use the Storybook dialog/modal structure and behavior. It must support:

- clear title and description,
- close action,
- keyboard escape,
- focus management,
- scrollable content,
- explicit cancel and confirm actions,
- a clear destructive or irreversible-action warning where applicable.

### Tooltips

Tooltips must use the DAS Storybook tooltip pattern, including its arrow/direction treatment. The tooltip must not be implemented as an unrelated browser `title` attribute when the content is important to the user.

Use tooltips for:

- truncated source lists,
- confidence explanations,
- masked or unavailable data,
- unfamiliar icons,
- secondary metadata.

Tooltip text must explain the meaning of the data, not merely repeat the visible label.

### Avatar

Avatars represent a customer or a curator. If a customer photo is unavailable, use initials. The avatar must preserve the documented size and shape variants.

### Progress and confidence

Confidence scores use a progress treatment together with an explicit numeric value and label. For example:

```text
92% · High
```

The progress bar is supporting information. The percentage and confidence label remain visible so the meaning is accessible without relying on color.

## Data and provenance requirements

The HTML component layer is only the presentation layer. It must not change the meaning of Golden Record data.

The Customers UI must support:

- missing values,
- multiple phone numbers,
- multiple source records,
- source-specific values,
- similar names,
- conflicting names or addresses,
- shared phone numbers,
- restricted or masked fields,
- multiple candidate duplicates,
- field-level provenance.

When values conflict, the UI must show:

- the observed value,
- the source,
- the record identifier where available,
- the selected surviving value,
- the fact that unselected observations remain in history/provenance.

## Storybook versus DaisyUI

These two layers have different responsibilities:

| Layer | Responsibility |
|---|---|
| DAS Storybook | Source of truth for component usage, variants, states and visual behavior |
| DaisyUI | Tailwind-based HTML component primitives and implementation classes |
| Tailwind CSS | Utility styling and CSS generation |
| Product UI | Composition of components into the Customers and Golden Record workflows |

DaisyUI alone is not the DAS Design System. A default DaisyUI component must not be used without checking its DAS Storybook counterpart and applying the DAS theme and conventions.

## Implementation rule

Before adding or changing a UI element:

1. Find the matching component in DAS Storybook.
2. Check its HTML structure and available variants.
3. Copy the documented component pattern.
4. Apply DAS content, data and icons.
5. Preserve the documented states and accessibility behavior.
6. Build the generated CSS.
7. Verify the result on `http://localhost:4173/customers/`.

## Local commands

Build the component CSS:

```bash
npm run build:customers:css
```

Start the local project:

```bash
npm run dev
```

Customers screen:

<http://localhost:4173/customers/>

## Current limitation

The published Storybook documentation is the source of truth for the HTML component contract. The local repository does not contain the original DAS component source package, so the localhost uses the documented HTML/CSS contract rather than importing React components from the Storybook build.

If the original DAS component package becomes available, the local prototype should migrate from copied HTML patterns to direct package imports while preserving the same Storybook API and visual behavior.
