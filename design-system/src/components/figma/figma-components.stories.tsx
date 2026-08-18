import type { Meta, StoryObj } from "@storybook/react";
import { ArrowRight, Check, Database, Lock, ShieldCheck } from "lucide-react";

import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Checkbox } from "@/components/ui/checkbox";
import { Disclosure } from "./disclosure";
import { FeatureCard } from "./feature-card";
import { CodeTexture } from "./code-texture";
import { IndustryCard } from "./industry-card";
import { NavigationItem } from "./navigation-item";
import { SocialIconButton } from "./social-icon-button";

const meta = { title: "Figma Port / Component Catalog", component: FeatureCard, tags: ["autodocs"] } satisfies Meta<typeof FeatureCard>;
export default meta;
type Story = StoryObj<typeof meta>;

export const ButtonsAndIconButtons: Story = { render: () => <div className="flex flex-wrap items-center gap-3"><Button>Request a demo <ArrowRight /></Button><Button variant="secondary">See pricing</Button><Button variant="outline">Deployment options <ArrowRight /></Button><SocialIconButton icon="x" /><SocialIconButton icon="linkedin" active /><SocialIconButton icon="github" /></div> };
export const Cards: Story = { render: () => <div className="grid max-w-5xl gap-4 md:grid-cols-3"><FeatureCard title="Build" description="Code, notebooks, chat, and agents in one governed studio." number="01" /><FeatureCard title="Run" description="Deploy inside your cloud, network, or air-gapped perimeter." marker="icon" /><IndustryCard title="Healthcare & telehealth" description="HIPAA-aligned controls. PHI never leaves your VPC." /></div> };
export const Navigation: Story = { render: () => <div className="flex items-center gap-2 bg-brand-navy p-4"><NavigationItem label="How It Works" /><NavigationItem label="Platform" dropdown active /><NavigationItem label="Industries" dropdown /><NavigationItem label="Pricing" /></div> };
export const FAQAndDisclosure: Story = { render: () => <div className="max-w-2xl"><Disclosure question="What's in the Workbench?" /><Disclosure open question="If the core is open source, why pay?" answer="Calliope provides the governed environment, deployment, access controls, and support around the open core." /><Disclosure question="Are AI tokens included in the price?" /></div> };
export const ExtendedAndUtility: Story = { render: () => <div className="grid max-w-4xl gap-4 md:grid-cols-2"><Card><CardHeader><CardTitle>Secure deployment</CardTitle></CardHeader><CardContent className="flex gap-3 text-sm text-muted-foreground"><ShieldCheck className="text-primary" />Your data stays inside your perimeter.</CardContent></Card><Card><CardHeader><CardTitle>Deployment target</CardTitle></CardHeader><CardContent className="flex gap-3 text-sm text-muted-foreground"><Database className="text-primary" />AWS, GCP, Azure, or on-premise.</CardContent></Card><Card><CardHeader><CardTitle>Access control</CardTitle></CardHeader><CardContent className="flex gap-3 text-sm text-muted-foreground"><Lock className="text-primary" />Policy-checked and logged.</CardContent></Card><label className="flex items-start gap-3 rounded-lg border border-border p-5 text-sm"><Checkbox defaultChecked /><span>I agree to the processing of my personal data as described in the Privacy Policy.</span></label></div> };
export const CodeTextureUtility: Story = { render: () => <div className="grid max-w-3xl gap-5 rounded-lg bg-white p-8"><CodeTexture tone="light" /><div className="rounded-lg bg-brand-navy p-8"><CodeTexture tone="dark" /></div></div> };
