import type { Meta, StoryObj } from "@storybook/react";

import { Badge } from "./badge";

const meta = {
  title: "Components/Badge",
  component: Badge,
  tags: ["autodocs"],
  parameters: { layout: "centered" },
  argTypes: {
    variant: { control: "select", options: ["default", "secondary", "outline", "solid"] },
  },
  args: { children: "Build" },
} satisfies Meta<typeof Badge>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {};
export const Secondary: Story = { args: { variant: "secondary", children: "Run" } };
export const Outline: Story = { args: { variant: "outline", children: "Observe" } };
export const Solid: Story = { args: { variant: "solid", children: "Secure" } };

export const Showcase: Story = {
  render: () => (
    <div className="flex flex-wrap gap-2">
      <Badge variant="default">Build</Badge>
      <Badge variant="secondary">Run</Badge>
      <Badge variant="outline">Observe</Badge>
      <Badge variant="solid">Secure</Badge>
    </div>
  ),
};
