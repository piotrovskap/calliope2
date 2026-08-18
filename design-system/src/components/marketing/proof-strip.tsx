export interface ProofMetric { value: string; label: string }

export function ProofStrip({ metrics }: { metrics: ProofMetric[] }) {
  return (
    <section className="grid grid-cols-3 bg-brand-navy-deep text-center text-white">
      {metrics.map((metric, index) => (
        <div key={`${metric.value}-${index}`} className="border-b border-r border-white/10 px-8 py-12 last:border-r-0 [&:nth-child(n+4)]:border-b-0">
          <div className="text-5xl font-bold tracking-tight">{metric.value}</div>
          <p className="mx-auto mt-4 max-w-xs text-sm leading-6 text-white/55">{metric.label}</p>
        </div>
      ))}
    </section>
  );
}
