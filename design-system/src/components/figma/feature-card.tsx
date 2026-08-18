import { ArrowUpRight, Check, Circle } from "lucide-react";

import { cn } from "@/lib/utils";

export function FeatureCard({ title, description, marker = "number", number = "01", className }: { title: string; description: string; marker?: "number" | "icon"; number?: string; className?: string }) {
  return <article className={cn("group relative flex min-h-64 flex-col justify-between rounded-lg border border-border bg-card p-6 text-card-foreground", className)}><div>{marker === "number" ? <span className="mb-5 inline-flex size-9 items-center justify-center rounded-full border border-primary text-xs font-semibold text-primary">{number}</span> : <span className="mb-5 inline-flex size-9 items-center justify-center rounded-full bg-primary text-primary-foreground"><Check className="size-4" /></span>}<h3 className="text-xl font-semibold">{title}</h3><p className="mt-3 text-sm leading-6 text-muted-foreground">{description}</p></div><ArrowUpRight className="ml-auto size-5 text-muted-foreground transition-transform group-hover:-translate-y-1 group-hover:translate-x-1" /></article>;
}
