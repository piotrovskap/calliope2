import type { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "Foundations/Colors",
  parameters: { layout: "fullscreen" },
} satisfies Meta;

export default meta;
type Story = StoryObj<typeof meta>;

type Swatch = { name: string; value: string; note?: string; text?: string };

const brand: Swatch[] = [
  { name: "brand.navy", value: "#162345", note: "Primary background", text: "#fff" },
  { name: "brand.navy-deep", value: "#0E1730", note: "Deeper background", text: "#fff" },
  { name: "brand.navy-card", value: "#1B2A52", note: "Card surface", text: "#fff" },
  { name: "brand.navy-muted", value: "#223155", note: "Muted surface", text: "#fff" },
  { name: "brand.cyan", value: "#3FF1EF", note: "Primary accent / CTA", text: "#162345" },
  { name: "brand.purple", value: "#5A4DC7", note: "Secondary accent", text: "#fff" },
];

const semantic: Swatch[] = [
  { name: "primary", value: "#3FF1EF", note: "var(--primary)", text: "#162345" },
  { name: "secondary", value: "#5A4DC7", note: "var(--secondary)", text: "#fff" },
  { name: "muted-foreground", value: "#8A91A2", note: "var(--muted-foreground)", text: "#fff" },
  { name: "background", value: "#162345", note: "var(--background)", text: "#fff" },
  { name: "card", value: "#1B2A52", note: "var(--card)", text: "#fff" },
  { name: "destructive", value: "#EF4444", note: "var(--destructive)", text: "#fff" },
];

function Grid({ title, items }: { title: string; items: Swatch[] }) {
  return (
    <section style={{ marginBottom: "2.5rem" }}>
      <h2
        style={{
          color: "#fff",
          fontFamily: "Helvetica, sans-serif",
          fontSize: 20,
          fontWeight: 700,
          marginBottom: 16,
        }}
      >
        {title}
      </h2>
      <div
        style={{
          display: "grid",
          gridTemplateColumns: "repeat(auto-fill, minmax(180px, 1fr))",
          gap: 16,
        }}
      >
        {items.map((s) => (
          <div
            key={s.name}
            style={{ borderRadius: 10, overflow: "hidden", border: "1px solid rgba(255,255,255,.1)" }}
          >
            <div style={{ background: s.value, height: 96 }} />
            <div style={{ background: "#1B2A52", padding: "10px 12px", fontFamily: "Helvetica, sans-serif" }}>
              <div style={{ color: "#fff", fontWeight: 700, fontSize: 13 }}>{s.name}</div>
              <div style={{ color: "#8A91A2", fontSize: 12 }}>{s.value}</div>
              {s.note && <div style={{ color: "#8A91A2", fontSize: 11, marginTop: 2 }}>{s.note}</div>}
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}

export const Palette: Story = {
  render: () => (
    <div style={{ background: "#162345", minHeight: "100vh", padding: 32 }}>
      <Grid title="Brand" items={brand} />
      <Grid title="Semantic tokens" items={semantic} />
    </div>
  ),
};
