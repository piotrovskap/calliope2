import { Check, ChevronDown, Search, ShieldCheck, X } from "lucide-react";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { cn } from "@/lib/utils";

export function DeploymentPill({ label, active = false }: { label: string; active?: boolean }) {
  return <span className={cn("inline-flex items-center rounded-full border px-3 py-1 text-xs font-medium", active ? "border-brand-cyan bg-brand-cyan/10 text-brand-cyan" : "border-border text-muted-foreground")}>{label}</span>;
}

export function Status({ label = "All systems operational" }: { label?: string }) {
  return <div className="inline-flex items-center gap-2 rounded-full border border-brand-cyan/30 bg-brand-cyan/10 px-3 py-1 text-xs text-brand-cyan"><span className="size-2 rounded-full bg-brand-cyan" />{label}</div>;
}

export function SearchResult({ title, description }: { title: string; description: string }) {
  return <article className="border-b border-border py-5"><a href="#result" className="text-lg font-semibold text-primary hover:underline">{title}</a><p className="mt-2 text-sm leading-6 text-muted-foreground">{description}</p></article>;
}

export function CookieBanner() {
  return <div className="flex items-center justify-between gap-6 rounded-lg border border-border bg-card p-5 text-card-foreground"><p className="text-sm text-muted-foreground">We use cookies to improve the Calliope experience.</p><div className="flex gap-2"><Button size="sm" variant="outline">Preferences</Button><Button size="sm">Accept</Button></div></div>;
}

export function LeadForm({ dark = true }: { dark?: boolean }) {
  return <form className={cn("flex flex-col gap-3 rounded-lg border p-6", dark ? "border-white/10 bg-brand-navy-card" : "border-border bg-card")}><label className="text-sm font-semibold">Work email</label><div className="flex gap-2"><Input placeholder="you@company.com" type="email" /><Button>Book a demo →</Button></div><label className="flex items-start gap-2 text-xs text-muted-foreground"><input type="checkbox" className="mt-0.5 accent-brand-purple" />I agree to the processing of my personal data.</label></form>;
}

export function MegaMenu({ title = "Platform", columns = [["AI IDE", "Chat Studio", "Deep Data Agent"], ["AI Lab", "DB Loadr", "File Manager"], ["Integrations", "Evidence", "Langflow"]] }: { title?: string; columns?: string[][] }) {
  return <div className="grid gap-8 rounded-lg border border-white/10 bg-brand-navy-deep p-8 text-white md:grid-cols-3"><div className="md:col-span-3 flex items-center justify-between"><p className="text-xs font-semibold uppercase tracking-[0.2em] text-white/45">{title}</p><ChevronDown className="size-4 text-brand-cyan" /></div>{columns.map((column, index) => <div key={index} className="space-y-4">{column.map((item) => <a key={item} href="#item" className="block text-sm font-semibold text-white/80 hover:text-brand-cyan">{item}<span className="mt-1 block text-xs font-normal text-white/40">Governed tools for your team</span></a>)}</div>)}</div>;
}

export function PlanCard({ name, price, featured = false }: { name: string; price: string; featured?: boolean }) {
  return <article className={cn("rounded-lg border p-6", featured ? "border-brand-cyan bg-brand-cyan/10" : "border-border bg-card")}><div className="flex items-center justify-between"><h3 className="text-lg font-semibold">{name}</h3>{featured && <span className="text-xs font-semibold uppercase text-brand-cyan">Recommended</span>}</div><p className="mt-6 text-4xl font-bold">{price}<span className="text-sm font-normal text-muted-foreground"> / mo</span></p><ul className="mt-6 space-y-3 text-sm text-muted-foreground"><li className="flex gap-2"><Check className="size-4 text-primary" />Private deployment</li><li className="flex gap-2"><ShieldCheck className="size-4 text-primary" />Governed access</li></ul><Button className="mt-8 w-full" variant={featured ? "default" : "outline"}>Choose plan</Button></article>;
}
