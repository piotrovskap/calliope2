import type { Meta, StoryObj } from "@storybook/react";

import { AnnouncementBar } from "./announcement-bar";
import { FAQItem } from "./faq-item";
import { Navigation } from "./navigation";
import { ProofStrip } from "./proof-strip";

const meta = { title: "Marketing/Production Components", component: AnnouncementBar, tags: ["autodocs"] } satisfies Meta<typeof AnnouncementBar>;
export default meta;
type Story = StoryObj<typeof meta>;

export const Announcement: Story = { render: () => <AnnouncementBar /> };
export const Header: Story = { render: () => <Navigation /> };
export const FAQ: Story = { render: () => <div className="grid max-w-3xl gap-3"><FAQItem question="What's in the Workbench?" /><FAQItem open question="Are AI tokens included in the price?" answer="Bring your own model keys with zero markup on tokens." /></div> };
export const Metrics: Story = { render: () => <ProofStrip metrics={[
  { value: "100%", label: "of your data stays in your cloud — nothing leaves your VPC" },
  { value: "24", label: "policy controls enforced in real time" },
  { value: "12+", label: "model providers — bring your own keys" },
  { value: "300+", label: "packages bundled for the data-science stack" },
  { value: "9", label: "compliance frameworks mapped" },
  { value: "Days", label: "from contract to production" },
]} /> };
