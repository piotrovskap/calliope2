import type { Meta, StoryObj } from "@storybook/react";

import { Button } from "./button";
import { Badge } from "./badge";
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "./card";

const meta = {
  title: "Components/Card",
  component: Card,
  tags: ["autodocs"],
  parameters: { layout: "centered" },
} satisfies Meta<typeof Card>;

export default meta;
type Story = StoryObj<typeof meta>;

/** A product card, as used on the Calliope landing (Workbench / Astralift / Sentinel). */
export const Product: Story = {
  render: () => (
    <Card className="w-80">
      <CardHeader>
        <Badge className="w-fit">Build</Badge>
        <CardTitle>Workbench</CardTitle>
        <CardDescription>
          The AI development surface — IDE, notebooks, Chat Studio, and visual agent workflows.
        </CardDescription>
      </CardHeader>
      <CardFooter>
        <Button variant="ghost" className="w-full">
          Explore Workbench
        </Button>
      </CardFooter>
    </Card>
  ),
};

/** A pricing card with the cyan CTA. */
export const Pricing: Story = {
  render: () => (
    <Card className="w-80">
      <CardHeader>
        <CardTitle>Business</CardTitle>
        <CardDescription>For growing orgs that need dedicated isolation.</CardDescription>
      </CardHeader>
      <CardContent>
        <p className="text-3xl font-extrabold">
          $5,750 <span className="text-base font-normal text-muted-foreground">/ mo</span>
        </p>
      </CardContent>
      <CardFooter>
        <Button className="w-full">Choose plan</Button>
      </CardFooter>
    </Card>
  ),
};
