# Architecture Diagrams

Pretty, client-facing versions of the CDP architecture diagrams. Repo-resident so the
portal has no runtime dependency on Lucid.

Each diagram has two committed forms:
- **`<name>.lucid.json`** — the editable Lucid Standard-Import source. Re-import into
  Lucid (Import -> Standard Import) to edit; this is the version-controlled definition.
- **`<name>.svg`** — the exported image the portal embeds (`<img>`). Export from Lucid
  (File -> Download As -> SVG) after prettifying, and drop it here.

The in-repo Mermaid in the deliverable docs stays the lightweight source of truth;
these are the polished client view.

| Diagram | Lucid doc id | Source | Export |
|---|---|---|---|
| Target-State Data Flow | `ece2e1e2-fcd2-47b9-91f1-731f193691bc` | target-state-data-flow.lucid.json | target-state-data-flow.svg |
| Intake | `34f3516c-4b52-4883-a42b-ca94a43f5fdc` | intake.lucid.json | intake.svg |
| System Design | `53dbc722-0d9d-4fb5-b1dd-08cb5d317885` | system-design.lucid.json | system-design.svg |
| Reporting Data Flow | `209249f9-b962-461b-b7d8-917d606ca399` | reporting-data-flow.lucid.json | reporting-data-flow.svg |
| Infrastructure Architecture | `364b49e3-fcc3-4816-8138-5f3d6708386d` | infrastructure-architecture.lucid.json | infrastructure-architecture.svg |

Diagrams are kept private in Lucid; the repo copies are the shareable artifacts.
