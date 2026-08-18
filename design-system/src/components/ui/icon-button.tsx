import * as React from "react";

import { cn } from "@/lib/utils";

export interface IconButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  label: string;
}

export const IconButton = React.forwardRef<HTMLButtonElement, IconButtonProps>(
  ({ label, className, children, ...props }, ref) => (
    <button
      ref={ref}
      type="button"
      aria-label={label}
      title={label}
      className={cn("inline-flex size-10 items-center justify-center rounded-md border border-white/15 bg-white/5 text-white transition-colors hover:bg-brand-cyan hover:text-brand-navy focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-cyan", className)}
      {...props}
    >
      {children}
    </button>
  )
);
IconButton.displayName = "IconButton";
