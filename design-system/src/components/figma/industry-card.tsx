import { ArrowRight } from "lucide-react";

import { cn } from "@/lib/utils";

export function IndustryCard({ title, description, className }: { title: string; description: string; className?: string }) {
  return <article className={cn("flex min-h-64 flex-col justify-between rounded-lg border border-border bg-card p-6 text-card-foreground", className)}><div><h3 className="text-xl font-semibold leading-tight">{title}</h3><p className="mt-4 text-sm leading-6 text-muted-foreground">{description}</p></div><a href="#contact" className="mt-6 inline-flex items-center gap-2 text-sm font-semibold text-primary">Learn more <ArrowRight className="size-4" /></a></article>;
}
