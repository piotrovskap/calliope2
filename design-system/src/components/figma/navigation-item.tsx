import { ChevronDown } from "lucide-react";

import { cn } from "@/lib/utils";

export function NavigationItem({ label, dropdown = false, active = false, className }: { label: string; dropdown?: boolean; active?: boolean; className?: string }) {
  return <a href={`#${label.toLowerCase().replaceAll(" ", "-")}`} className={cn("inline-flex h-8 items-center gap-1 rounded-md px-3 text-xs text-white/65 transition-colors hover:text-brand-cyan", active && "bg-white/10 text-brand-cyan", className)}>{label}{dropdown && <ChevronDown className="size-3" />}</a>;
}
