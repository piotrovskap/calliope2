import type { Meta, StoryObj } from "@storybook/react";
import { ArrowRight, Download } from "lucide-react";

import { Button } from "./button";

const meta = {
  title: "Components/Button",
  component: Button,
  tags: ["autodocs"],
  parameters: { layout: "centered" },
  argTypes: {
    variant: {
      control: "select",
      options: ["default", "secondary", "ghost", "outline", "link", "destructive"],
    },
    size: { control: "select", options: ["sm", "default", "lg", "icon"] },
  },
  args: { children: "Talk to sales" },
} satisfies Meta<typeof Button>;

export default meta;
type Story = StoryObj<typeof meta>;

/** Cyan CTA — Calliope's primary action. */
export const Primary: Story = { args: { variant: "default" } };

/** Purple — the brand's secondary action (e.g. "See It in Action", "Download"). */
export const Secondary: Story = { args: { variant: "secondary", children: "See it in action" } };

export const Ghost: Story = { args: { variant: "ghost", children: "Log in" } };
export const Outline: Story = { args: { variant: "outline", children: "Request a demo" } };
export const Link: Story = { args: { variant: "link", children: "See governance" } };

export const WithIcon: Story = {
  args: {
    variant: "default",
    children: (
      <>
        Get started <ArrowRight />
      </>
    ),
  },
};

/** All variants and sizes side by side — the canonical button matrix. */
export const Showcase: Story = {
  render: () => (
    <div className="flex flex-col gap-6">
      <div className="flex flex-wrap items-center gap-3">
        <Button variant="default">Cyan CTA</Button>
        <Button variant="secondary">Purple</Button>
        <Button variant="ghost">Ghost</Button>
        <Button variant="outline">Outline</Button>
        <Button variant="link">Link</Button>
      </div>
      <div className="flex flex-wrap items-center gap-3">
        <Button size="sm">Small</Button>
        <Button size="default">Default</Button>
        <Button size="lg">Large</Button>
        <Button size="icon" aria-label="Download">
          <Download />
        </Button>
      </div>
      <div className="flex flex-wrap items-center gap-3">
        <Button disabled>Disabled</Button>
        <Button variant="secondary" disabled>
          Disabled
        </Button>
      </div>
    </div>
  ),
};
