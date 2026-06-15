import type { Meta, StoryObj } from "@storybook/react";

const meta = {
  title: "Foundations/Typography",
  parameters: { layout: "fullscreen" },
} satisfies Meta;

export default meta;
type Story = StoryObj<typeof meta>;

const font = "Helvetica, Arial, sans-serif";

export const Scale: Story = {
  render: () => (
    <div style={{ background: "#162345", minHeight: "100vh", padding: 40, color: "#fff", fontFamily: font }}>
      <p style={{ color: "#8A91A2", fontSize: 13, marginBottom: 24 }}>
        Font family: <strong style={{ color: "#fff" }}>Helvetica, Arial, sans-serif</strong> — base 14.4px
      </p>
      <div style={{ display: "flex", flexDirection: "column", gap: 20 }}>
        <div>
          <span style={{ color: "#8A91A2", fontSize: 12 }}>Display / 48px / 800</span>
          <div style={{ fontSize: 48, fontWeight: 800, lineHeight: 1.1, letterSpacing: "-0.02em" }}>
            Ship enterprise AI
          </div>
        </div>
        <div>
          <span style={{ color: "#8A91A2", fontSize: 12 }}>H2 / 28px / 700</span>
          <div style={{ fontSize: 28, fontWeight: 700, lineHeight: 1.3 }}>Build. Run. Observe. Control. Secure.</div>
        </div>
        <div>
          <span style={{ color: "#8A91A2", fontSize: 12 }}>H3 / 20px / 700</span>
          <div style={{ fontSize: 20, fontWeight: 700 }}>Audit-ready by default</div>
        </div>
        <div>
          <span style={{ color: "#8A91A2", fontSize: 12 }}>Body / 16px / 400</span>
          <p style={{ fontSize: 16, maxWidth: 560, color: "rgba(255,255,255,.92)" }}>
            Calliope lets your teams build, run, observe, control, and secure AI on one platform — with
            governance built in, not bolted on.
          </p>
        </div>
        <div>
          <span style={{ color: "#8A91A2", fontSize: 12 }}>Muted / 14px / 400</span>
          <p style={{ fontSize: 14, color: "#8A91A2" }}>Deploy in the cloud, on-prem, or fully air-gapped.</p>
        </div>
        <div>
          <span style={{ color: "#8A91A2", fontSize: 12 }}>Eyebrow / 12px / 600 / uppercase</span>
          <p style={{ fontSize: 12, fontWeight: 600, letterSpacing: "0.14em", textTransform: "uppercase", color: "#3FF1EF" }}>
            The Secure AI Development Platform
          </p>
        </div>
      </div>
    </div>
  ),
};
