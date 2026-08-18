import { Search } from "lucide-react";

import { Button } from "@/components/ui/button";
import { IconButton } from "@/components/ui/icon-button";

const items = ["How It Works", "Platform", "Industries", "Solutions", "Deployment", "Security", "Support"];

export function Navigation() {
  return (
    <header className="border-b border-white/10 bg-brand-navy text-white">
      <div className="flex h-8 items-center justify-end gap-5 border-b border-white/10 px-8 text-xs text-white/60">
        <a href="#about">About⌄</a><a href="#pricing">Pricing</a><a href="#blog">Blog</a>
        <a href="#contact">Contact</a><a href="#login">Log In</a>
        <Button size="sm" variant="secondary" className="h-6 rounded px-3 text-[11px]">Download</Button>
      </div>
      <div className="mx-auto flex h-14 max-w-6xl items-center gap-8 px-6">
        <a href="#top" className="shrink-0 text-xl font-semibold tracking-tight">Calliope<span className="text-brand-cyan">AI</span></a>
        <nav className="flex flex-1 items-center justify-center gap-6 text-xs text-white/65">
          {items.map((item) => <a key={item} href={`#${item.toLowerCase().replaceAll(" ", "-")}`} className="hover:text-brand-cyan">{item}{item !== "How It Works" && item !== "Support" ? "⌄" : ""}</a>)}
        </nav>
        <IconButton label="Search"><Search /></IconButton>
        <Button size="sm" className="shrink-0">Book a demo</Button>
      </div>
    </header>
  );
}
