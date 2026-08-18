import * as React from "react";
import { Github, Linkedin, Mail, Phone, Twitter } from "lucide-react";

import { cn } from "@/lib/utils";

export type SocialIcon = "linkedin" | "github" | "x" | "email" | "phone";

const icons = { linkedin: Linkedin, github: Github, x: Twitter, email: Mail, phone: Phone };

export function SocialIconButton({ icon, active = false, label, className, ...props }: React.ButtonHTMLAttributes<HTMLButtonElement> & { icon: SocialIcon; active?: boolean; label?: string }) {
  const Icon = icons[icon];
  return <button type="button" aria-label={label ?? icon} title={label ?? icon} className={cn("inline-flex size-9 items-center justify-center rounded-md border border-white/15 bg-white/5 text-white/75 transition-colors hover:bg-brand-cyan hover:text-brand-navy", active && "bg-brand-cyan text-brand-navy", className)} {...props}><Icon className="size-4" /></button>;
}
