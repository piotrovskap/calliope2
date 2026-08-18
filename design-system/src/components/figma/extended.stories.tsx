import type { Meta, StoryObj } from "@storybook/react";

import { CookieBanner, DeploymentPill, LeadForm, MegaMenu, PlanCard, SearchResult, Status } from "./extended";

const meta = { title: "Figma Port/Extended, Pricing & Navigation", component: DeploymentPill, tags: ["autodocs"] } satisfies Meta<typeof DeploymentPill>;
export default meta;
type Story = StoryObj<typeof meta>;

export const Deployment: Story = { render: () => <div className="flex gap-2"><DeploymentPill label="AWS" active /><DeploymentPill label="GCP" /><DeploymentPill label="On-premise" /></div> };
export const SystemStatus: Story = { render: () => <Status /> };
export const Search: Story = { render: () => <div className="max-w-2xl"><div className="mb-5 flex gap-2"><input className="h-11 flex-1 rounded-md border border-input bg-white/5 px-3" placeholder="Search Calliope" /><button className="rounded-md bg-primary px-4 text-primary-foreground">Search</button></div><SearchResult title="How Calliope works" description="Build, run, observe, control, and secure private AI in your own cloud." /></div> };
export const Cookies: Story = { render: () => <CookieBanner /> };
export const ConsentLeadForm: Story = { render: () => <LeadForm /> };
export const MegaMenuPattern: Story = { render: () => <MegaMenu /> };
export const Pricing: Story = { render: () => <div className="grid max-w-3xl gap-4 md:grid-cols-2"><PlanCard name="BYOC" price="$2,500" /><PlanCard name="Managed" price="$5,750" featured /></div> };
