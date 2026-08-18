import { ChevronDown } from "lucide-react";

export interface FAQItemProps {
  question: string;
  answer?: string;
  open?: boolean;
}

export function FAQItem({ question, answer, open = false }: FAQItemProps) {
  return (
    <details open={open} className="group rounded-md border border-white/15 bg-brand-navy-card text-white">
      <summary className="flex cursor-pointer list-none items-center justify-between px-5 py-5 font-semibold marker:hidden">
        {question}
        <ChevronDown className="size-5 text-brand-cyan transition-transform group-open:rotate-180" />
      </summary>
      {answer && <div className="border-t border-white/10 px-5 pb-5 pt-4 text-sm leading-6 text-white/70">{answer}</div>}
    </details>
  );
}
