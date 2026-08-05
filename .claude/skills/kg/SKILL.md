# /kg — DAS CDP Knowledge Graph

Query the DAS CDP knowledge graph built from the Phase 0 kickoff meeting transcript, wiki documents, and Confluence artifacts.

**Graph:** `app/knowledge_graph.json` — the single, generated, versioned federation (regenerate with `python3 scripts/gen-kg.py`; validated by `scripts/check-kg.py`).
**Contents:** kickoff transcript + wiki + Confluence + SSIS review (2026-06-08) + Juice reporting review (2026-06-08), federated across sessions per `analysis/sessions/catalog.json` with the curation overlay `analysis/kg-curation.json`. See `docs/knowledge-engine.md` for the schema.

## Usage

```
/kg                          # Graph stats overview
/kg <natural language>       # Ask anything about the meeting/project
/kg entity <name>            # Find a specific entity and its connections
/kg type <type>              # List all entities of a type (concept|technology|person|organization|time)
/kg neighbors <name>         # Show all relationships for an entity
/kg path <from> <to>         # Find connection path between two entities
/kg clusters                 # Show entity clusters
```

## Instructions

Planopticon must be installed and API keys available in the environment. Use the planopticon query command against the DAS CDP graph:

**KG path (relative to repo root):**
```
app/knowledge_graph.json
```

### Command mapping

| User says | Planopticon command |
|-----------|-------------------|
| `/kg` (no args) | `planopticon query --db-path <KG> stats` |
| `/kg <question>` | `planopticon query --db-path <KG> --mode agentic "<question>"` |
| `/kg entity <name>` | `planopticon query --db-path <KG> "neighbors <name>"` |
| `/kg type <type>` | `planopticon query --db-path <KG> "entities --type <type>"` |
| `/kg neighbors <name>` | `planopticon query --db-path <KG> "neighbors <name>"` |
| `/kg path <from> <to>` | `planopticon query --db-path <KG> "path <from> <to>"` |
| `/kg clusters` | `planopticon query --db-path <KG> clusters` |

### Examples

```bash
# What topics did Dan and Mike discuss about identity?
planopticon query --db-path <KG> --mode agentic "What did Dan and Mike say about identity resolution?"

# Who are the people in the graph and what are they connected to?
planopticon query --db-path <KG> "entities --type person"

# What is the CDP connected to?
planopticon query --db-path <KG> "neighbors CDP"

# What compliance topics came up?
planopticon query --db-path <KG> --mode agentic "What compliance and privacy topics were discussed?"
```

### Output formats

Add `--format mermaid` to get a relationship diagram instead of text output.

### Interactive mode

For a full REPL session:
```bash
planopticon query --db-path <KG> -I
```

## Entity Types

| Type | Color in viewer | Description |
|------|----------------|-------------|
| `person` | Green | People mentioned (Dan, Alex, Mike, Leo, etc.) |
| `technology` | Red | Technologies, tools, systems |
| `organization` | Amber | Companies, teams, products |
| `concept` | Blue | Ideas, patterns, decisions |
| `time` | Purple | Dates, timelines, phases |

## Viewer

Serve the app from the repo root and open in browser:

```bash
python3 -m http.server 8080
# open: http://localhost:8080/app/
```
