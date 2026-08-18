const lines = ["CALLIOPEai01 <> /\\ * += # CALLIOPE", "01<> /\\ * += # ai01 <> CALLIOPE", "LIOPEai01 <> /\\ * += # CALLIOPE", "ai01 <> /\\ * += # CALLIOPEai01"];

export function CodeTexture({ tone = "light" }: { tone?: "light" | "dark" }) {
  return <div aria-hidden className={tone === "dark" ? "space-y-5 overflow-hidden font-mono text-xs text-white/15" : "space-y-5 overflow-hidden font-mono text-xs text-brand-navy/15"}>{[...lines, ...lines].map((line, index) => <div key={`${line}-${index}`} className={index % 2 ? "pl-12" : ""}>{line}</div>)}</div>;
}
