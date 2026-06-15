import type { Config } from "tailwindcss";

/**
 * Calliope design system — Tailwind theme.
 * Colors map to CSS variables defined in src/index.css so shadcn components
 * inherit the Calliope brand (deep navy + cyan + purple) automatically.
 */
const config: Config = {
  darkMode: "class",
  content: [
    "./src/**/*.{ts,tsx}",
    "./.storybook/**/*.{ts,tsx}",
  ],
  theme: {
    container: { center: true, padding: "2rem" },
    extend: {
      colors: {
        // Raw brand palette (extracted from calliope.ai)
        brand: {
          navy: "#162345",
          "navy-deep": "#0E1730",
          "navy-card": "#1B2A52",
          "navy-muted": "#223155",
          cyan: "#3FF1EF",
          purple: "#5A4DC7",
        },
        // Semantic tokens (shadcn convention) -> CSS vars
        background: "var(--background)",
        foreground: "var(--foreground)",
        border: "var(--border)",
        input: "var(--input)",
        ring: "var(--ring)",
        primary: {
          DEFAULT: "var(--primary)",
          foreground: "var(--primary-foreground)",
        },
        secondary: {
          DEFAULT: "var(--secondary)",
          foreground: "var(--secondary-foreground)",
        },
        muted: {
          DEFAULT: "var(--muted)",
          foreground: "var(--muted-foreground)",
        },
        accent: {
          DEFAULT: "var(--accent)",
          foreground: "var(--accent-foreground)",
        },
        destructive: {
          DEFAULT: "var(--destructive)",
          foreground: "var(--destructive-foreground)",
        },
        card: {
          DEFAULT: "var(--card)",
          foreground: "var(--card-foreground)",
        },
        popover: {
          DEFAULT: "var(--popover)",
          foreground: "var(--popover-foreground)",
        },
      },
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
      },
      fontFamily: {
        sans: ["Helvetica", "Arial", "ui-sans-serif", "system-ui", "sans-serif"],
      },
    },
  },
  plugins: [],
};

export default config;
