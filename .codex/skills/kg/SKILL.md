---
name: kg
description: Use when the user wants to query the DAS CDP knowledge graph, mentions `/kg` or `$kg`, or asks for entities, neighbors, paths, clusters, or natural-language answers grounded in the Planopticon graph built from the kickoff transcript and wiki documents.
---

# DAS CDP Knowledge Graph

Query the DAS CDP knowledge graph with Planopticon.

## Quick Start

- Treat `/kg ...` and `$kg ...` as the same request.
- Use the graph at `/Users/ragelink/repos/das-tech/app/knowledge_graph.json` (single generated federation; regenerate with `python3 scripts/gen-kg.py`).
- Run the env export and `planopticon` query in the same shell command. Do not assume exported vars persist across tool calls.
- Prefer direct graph commands for explicit requests. Use `--mode agentic` for natural-language questions.
- If the user gives no arguments, return `stats`.

## Standard Wrapper

Use this shell pattern for every query:

```bash
sh -lc 'export $(grep -v "^#" /Users/ragelink/repos/conflict/CONFLICT.env | xargs) && planopticon query --db-path /Users/ragelink/repos/das-tech/app/knowledge_graph.json stats'
```

Replace `stats` with the mapped query below.

## Command Mapping

- No args: `stats`
- Natural-language question: `--mode agentic "<question>"`
- `entity <name>`: `"neighbors <name>"`
- `type <type>`: `"entities --type <type>"`
- `neighbors <name>`: `"neighbors <name>"`
- `path <from> <to>`: `"path <from> <to>"`
- `clusters`: `clusters`
- Mermaid diagram: add `--format mermaid`
- Interactive REPL: use `-I`

Quote names that contain spaces.

## Examples

```bash
sh -lc 'export $(grep -v "^#" /Users/ragelink/repos/conflict/CONFLICT.env | xargs) && planopticon query --db-path /Users/ragelink/repos/das-tech/app/knowledge_graph.json --mode agentic "What compliance and privacy topics were discussed?"'

sh -lc 'export $(grep -v "^#" /Users/ragelink/repos/conflict/CONFLICT.env | xargs) && planopticon query --db-path /Users/ragelink/repos/das-tech/app/knowledge_graph.json "entities --type person"'

sh -lc 'export $(grep -v "^#" /Users/ragelink/repos/conflict/CONFLICT.env | xargs) && planopticon query --db-path /Users/ragelink/repos/das-tech/app/knowledge_graph.json "neighbors CDP"'
```

## Output Guidance

- Preserve entity names and relationship labels exactly as returned.
- If a name is ambiguous, say so and show the closest candidates.
- If no results are returned, say that explicitly and then try a broader query shape if useful.
- When summarizing graph output, stay grounded in the returned entities and relationships instead of filling gaps from memory.
