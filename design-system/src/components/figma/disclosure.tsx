import { ChevronDown } from "lucide-react";

export function Disclosure({ question, answer, open = false }: { question: string; answer?: string; open?: boolean }) {
  return <details open={open} className="group border-b border-border"><summary className="flex cursor-pointer list-none items-center justify-between py-5 font-semibold marker:hidden">{question}<ChevronDown className="size-5 text-primary transition-transform group-open:rotate-180" /></summary>{answer && <p className="pb-5 text-sm leading-6 text-muted-foreground">{answer}</p>}</details>;
}
