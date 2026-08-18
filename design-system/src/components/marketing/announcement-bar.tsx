import * as React from "react";
import { X } from "lucide-react";

import { cn } from "@/lib/utils";

export interface AnnouncementBarProps extends React.HTMLAttributes<HTMLDivElement> {
  message?: string;
  href?: string;
  onDismiss?: () => void;
}

export function AnnouncementBar({
  message = "Onboarding a limited number of private deployments this quarter.",
  href = "#contact",
  onDismiss,
  className,
  ...props
}: AnnouncementBarProps) {
  return (
    <div
      className={cn("relative flex h-12 items-center justify-center border-b bg-brand-navy-deep px-12 text-xs text-white/70", className)}
      {...props}
    >
      <span>{message}</span>
      <a className="ml-3 font-semibold text-brand-cyan hover:underline" href={href}>
        Request access →
      </a>
      <button
        type="button"
        aria-label="Dismiss announcement"
        title="Dismiss announcement"
        onClick={onDismiss}
        className="absolute right-4 top-1/2 -translate-y-1/2 text-white/60 transition-colors hover:text-white"
      >
        <X className="size-3.5" />
      </button>
    </div>
  );
}
