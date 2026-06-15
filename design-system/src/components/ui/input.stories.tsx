import type { Meta, StoryObj } from "@storybook/react";

import { Button } from "./button";
import { Input } from "./input";
import { Label } from "./label";

const meta = {
  title: "Components/Input",
  component: Input,
  tags: ["autodocs"],
  parameters: { layout: "centered" },
  args: { placeholder: "you@company.com" },
} satisfies Meta<typeof Input>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {};
export const Disabled: Story = { args: { disabled: true } };

/** Labelled field with a CTA — the "Talk to sales" pattern. */
export const WithLabelAndButton: Story = {
  render: () => (
    <div className="flex w-80 flex-col gap-3">
      <div className="flex flex-col gap-1.5">
        <Label htmlFor="email">Work email</Label>
        <Input id="email" type="email" placeholder="you@company.com" />
      </div>
      <Button className="w-full">Talk to sales</Button>
    </div>
  ),
};
