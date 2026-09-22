<!-- coalesce-node-managed: true -->
# Workspace YAML Artifacts

Confirm every shape with `coa describe schema <type>` before editing — NOT
with the bundled example files, which use legacy shapes that fail
`coa validate`. All of these files are SHARED config: an edit can silently
break unrelated nodes, so ask the user before changing any of them.

## Repository layout

```
.
├── data.yml          # central manifest (required)
├── locations.yml     # storage location names (required)
├── workspace.yml     # local db/schema mappings (optional, local-only)
├── nodes/            # node files: <LOCATION>-<NAME>.sql / .yml (flat)
├── nodeTypes/        # workspace-local node types: <DisplayName>-<ID>/
├── packages/         # package declarations (base node types package)
├── environments/     # environment configs
├── subgraphs/        # logical node groupings
├── jobs/             # orchestration definitions
└── macros/           # reusable SQL macros
```

## data.yml (required, repo root)

`{ fileVersion, platformKind?: snowflake|databricks|fabric|bigquery,
defaultStorageMapping? }`. Only `fileVersion` is required; `platformKind` and
`defaultStorageMapping` are optional. `additionalProperties: false`.

## locations.yml (required)

`{ defaultStorageMapping, locations: [<NAME>, ...], fileVersion: 1 }`. Just a
list of location NAMES plus a default mapping name — NO database/schema here.
`additionalProperties: false`.

A location NAME must be consistent everywhere it appears: the node filename
prefix (`nodes/<LOC>-<NAME>.sql`), the `locations.yml` list, `workspace.yml`
mappings, and each environment's `mappingDefinitions`. Renaming a location
touches all of them.

## workspace.yml (optional, local-only)

`{ locations: { <NAME>: { database, schema } } }` — local db/schema mappings
used by `coa create`/`coa run` and required for the validate graph scanners to
resolve refs. Credentials do NOT go here (they live in `~/.coa/config`).
`coa doctor --fix` can bootstrap a missing `workspace.yml` (ask first).

## environments/<NAME>.yml

`{ name, id, type: "Environment", fileVersion,
mappingDefinitions: { <LOC>: { database, schema } } }` — all fields required.

## Job (jobs/<NAME>.yml) — `coa describe schema job`

NOT a steps array. Exactly these fields:

| Field | Required | Notes |
|-------|----------|-------|
| `id` | yes | **Integer** string matching `^-?\d+$`, e.g. `"1"`. NOT a UUID. Unique among jobs. |
| `type` | yes | Constant `Job`. |
| `fileVersion` | yes | Constant `1`. |
| `name` | no | Human-readable name. |
| `includeSelector` | no | Selector string — the nodes the job targets. |
| `excludeSelector` | no | Selector string subtracted from the include set. |

```yaml
id: "1"
type: Job
fileVersion: 1
name: BUILD_TARGET
includeSelector: '{ location: "TARGET" }+'
excludeSelector: '{ name: "TEST_*" }'
```

Legacy trap: example job files with a `steps: [{ selector }]` array are NOT
the schema shape and fail `coa validate`. Don't invent an `includeSelector`
inside a legacy-shaped file — flag it for migration first.

## Subgraph (subgraphs/<NAME>.yml) — `coa describe schema subgraph`

NOT a nodes array. Shape: `{ id, type: "Subgraph", fileVersion: 1, name,
steps: ["<node id>", ...] }` — each step is a node's `id` (a node file's `id:`,
or a `.sql` node's `@id`), NOT a node name and NOT a selector string.

```yaml
id: "1"
type: Subgraph
fileVersion: 1
name: ANALYTICS
steps: ["a1b2c3d4", "e5f6a7b8"]   # node IDs — node file `id:` / .sql `@id`
```

The serve UI resolves subgraph membership as `steps ∩ live-node-ids` and
silently drops any step that isn't a real node ID.
Legacy trap: example subgraphs with a `nodes:` list of bare names, or `steps`
holding selector strings/node names, are NOT the schema shape.

## Node types (nodeTypes/<DisplayName>-<ID>/)

Base node types are NOT authored here — they ship in the base node types package
for the platform, declared under `packages/` (`coa init` writes
`packages/base-node-types.yml`) and hydrated by `coa install`, which
materializes them as a READ-ONLY file tree at
`.coa/cache/packages/<alias>/nodeTypes/<Name>-<id>/` (definition.yml plus
`create.sql.j2` / `run.sql.j2`). Each materialized `definition.yml` carries the
resolvable id in `<alias>:::<id>` form — that exact id is the `@nodeType()`
value. The tree is derived: `coa install` regenerates it, so never edit it
(`.coa/cache/packages.json` is the machine cache the tree mirrors). Discovery
is file-system based — read those folders plus `nodeTypes/`, which holds only
workspace-local types; there, the `<ID>` after the last dash is the
`@nodeType()` value. Each node type folder holds:

- **definition.yml** — `{ isDisabled, name, id, type: "NodeType", fileVersion,
  metadata: { nodeMetadataSpec, error: null } }`. `nodeMetadataSpec` is a YAML
  STRING: required `capitalized`, `short`, `plural`, `tagColor`; optional
  `config`, `systemColumns`. Read `name`/`description`/`nodeMetadataSpec` to
  identify a type — names vary by workspace, and the base packages ship no
  `Stage` type (their staging/work-layer type is `Work`,
  `base-node-types:::204`). `nodeMetadataSpec.config` holds the config
  DEFAULTS a hand-authored node must copy into `operation.config`: run
  templates gate their DML on those values (Work-204 on
  `config.insertStrategy == 'INSERT'` and `config.truncateBefore`), so an
  empty `config: {}` renders zero run SQL.
- **create.sql.j2** (DDL) and **run.sql.j2** (DML) — Jinja templates.

**fileVersion 1 vs 2:** V2 `.sql` nodes require `fileVersion: 2` in the node
type definition (see `sql-format.md` for the silently-empty-columns trap).
For V2, `col.dataType` is `UNKNOWN`, so templates MUST use the **CTAS
pattern** — never emit `{{ col.dataType }}`. Iterate `sources` then
`source.columns`, and guard create with `WHERE 1=0`:

```jinja
CREATE OR REPLACE TABLE {{ ref_no_link(node.location.name, node.name) }} AS
{% for source in sources %}
SELECT
{% for col in source.columns %}
    {{ get_source_transform(col) }} AS "{{ col.name }}"{%- if not loop.last -%}, {% endif %}
{% endfor %}
{{ source.join }}
WHERE 1=0
{% endfor %}
```

The matching `run.sql.j2` (DML) uses the same column iteration, without the
`WHERE 1=0` guard:

```jinja
{{ stage('Truncate') }}
TRUNCATE IF EXISTS {{ ref_no_link(node.location.name, node.name) }}
{% for source in sources %}
{{ stage('Insert') }}
INSERT INTO {{ ref_no_link(node.location.name, node.name) }}
SELECT
{% for col in source.columns %}
    {{ get_source_transform(col) }} AS "{{ col.name }}"{%- if not loop.last -%}, {% endif %}
{% endfor %}
{{ source.join }}
{% endfor %}
```

Do NOT write a V2 body as `{{ node.sql }}` or `SELECT *` — either renders a
zero-column table (degenerate DDL) regardless of what the node's SELECT lists.
The projection MUST come from iterating `source.columns`. V1 node types instead
use explicit-column DDL (`{{ col.name }} {{ col.dataType }}`).

After a node-type/template edit, prove the contract holds on both templates:
`coa create -d <dir> --include "{ nodeType: \"<Name>\" }" --dry-run --verbose`
and the same with `coa run` — confirm columns render and SQL is non-empty for
affected nodes. `run.sql.j2` is where config gating lives, so create alone
proves nothing about whether data would load.

## Macros (macros/)

Reusable SQL referenced from node transformations —
`coa describe schema macro` for the shape. Shared config: ask first.
