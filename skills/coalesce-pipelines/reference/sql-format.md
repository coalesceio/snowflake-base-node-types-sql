<!-- coalesce-node-managed: true -->
# Node SQL Format — V2 (.sql) vs V1 (.yml)

`coa describe sql-format` and `coa describe concepts` are the source of truth.

## Two formats: choose by the node type's fileVersion

Both formats are first-class. The hard rule: Source nodes are always V1
`.yml`; for every other node, author a V2 `.sql` node when a `fileVersion: 2`
node type exists for the target node type, otherwise author a V1 `.yml` node.
The `fileVersion` in `nodeTypes/<ID>/definition.yml` decides this, never the
platform. A workspace whose node types are all V1 authors all of its
transformation nodes as V1 `.yml`, and that is supported, not a workaround.
Within that constraint, here is what each format is:

- **V2 — `.sql`, `fileVersion: 2` — used for STAGING and INTERMEDIATE
  transforms.** Ephemeral, regenerable nodes; columns are inferred from the SELECT.
  File at `nodes/<LOCATION>-<NAME>.sql`.
- **V1 — `.yml`, `fileVersion: 1` — required for SOURCE nodes, and used for
  PERSISTENT / CURATED nodes** (Dimension, Fact, Persistent Stage). Columns are explicit, with data
  types and source mappings — a durable, published contract for the layer other models
  and dashboards depend on. Also required for any V1-only node type. File at
  `nodes/<LOCATION>-<NAME>.yml`; see `coa describe schema node`.

Rule of thumb, when the target node type has BOTH a V1 and a V2 definition available:
ephemeral, high-volume transform → **V2 `.sql`**; a persistent curated
contract or a Source node → **V1 `.yml`**. (Both curated annotations `@isBusinessKey` and
`@isChangeTracking` work in V2 as well — preferring V1 for curated layers is about explicit,
reviewable column contracts, not a capability gap.)

## The silently-empty-columns trap

A V2 `.sql` node REQUIRES a node type whose `nodeTypes/<ID>/definition.yml` has
`fileVersion: 2`. If `@nodeType` points at a V1 (or absent-fileVersion) type,
the node still loads but its columns are **SILENTLY EMPTY** (`columns: []`) —
`coa create`/`coa run` then emit broken DDL/DML with no error. The built-in
type names (Source, Stage, View, Dimension, Fact, persistentStage) are V1;
using them in a `.sql` file triggers this trap — and they resolve at all only
where those built-in types exist in `nodeTypes/`, which `coa init` writes when
the base package is unavailable. Never assume a name: the base packages ship
no `Stage` type, their staging/work-layer type being `Work`
(`base-node-types:::204`). V2 types come from
the installed base node types package for the platform. Discovery is
file-system based: read `nodeTypes/<ID>/definition.yml` for workspace-local
types and `.coa/cache/packages/<alias>/nodeTypes/<Name>-<id>/definition.yml`
for the package types `coa install` materialized — each of those carries the
resolvable id in `<alias>:::<id>` form, which is what `@nodeType()` takes. If
none are present, run `coa install -d <dir>` to hydrate packages and re-check
the file system — `coa install` hydrates only packages already declared under
`packages/` and otherwise prints "No packages to install.", and `coa init`
writes that declaration, so an absent `packages/` means re-running `coa init`
(ask the user first), never hand-creating shared config. If that still yields
nothing, the package may be unavailable —
author the node as V1 `.yml` and continue. Do NOT author a
node type. Upgrading a V1 type that existing nodes already use changes their
DDL/DML and STILL requires approval. Never silently write a `.sql` node against
a V1 type. See coalesce-workspace-config ("Getting V2 node types").

The other way out of the trap: when the node type you need has no
`fileVersion: 2` definition available at all, do not force `.sql`. Author the
node as a V1 `.yml` instead. That is the normal path in any workspace whose
node types are all V1. Field recipe: the
coalesce-pipeline-structure skill ("Creating a V1 (.yml) node").

## File naming

- The filename — `nodes/<LOCATION>-<NAME>.sql` or `.yml` — sets the node's
  location and name. A bare `@location` annotation is ignored. `nodes/` is
  flat (no subdirectories).
- Filenames are case-sensitive and NAME must be unique:
  `nodes/<LOC>-<NAME>.yml` and `nodes/<LOC>-<NAME>.sql` cannot coexist.
- By convention names are UPPER_SNAKE_CASE — `coa` does not enforce casing,
  but match the repo. Typical conventions: `SRC-<TABLE>` for sources,
  `TARGET-STG_<NAME>` for stages, `TARGET-<NAME>` for derived nodes.

## Required top annotations (before any SQL)

- `@id("<UUID>")` — stable, immutable identifier. PREFER a fresh UUID v4 for
  new nodes. NEVER reuse or modify an existing `@id` (node or column).
- `@nodeType("<TypeID>")` — normally a package node type ID, `<alias>:::<id>`
  (e.g. `"dynamic-tables:::347"`), from the installed base node types package.
  A workspace-local type uses the ID after the last dash in its
  `nodeTypes/<ID>/` folder name.

Keep `@id` and `@nodeType` as the first lines. Match the existing `.sql`
nodes: only those two annotations precede the SQL (no bare `fileVersion`
line).

### Write the annotations BARE — never as SQL comments

`coa` reads `@id`/`@nodeType` only when they are **bare** lines (no `--`, no
`/* */`). They look like they belong in a comment because a bare `@id("…")`
line is not itself valid Snowflake SQL — but do NOT "fix" that by commenting
them. A `.sql` node whose annotations are commented out has, as far as `coa` is
concerned, NO `@id` and NO `@nodeType`: the node is **silently dropped from the
graph** — `coa validate` still reports 0 errors (the node simply isn't there),
`coa create` never builds it, and lineage is missing. This is the single most
common way a "finished" node quietly does nothing.

```sql
-- WRONG — commented out; coa ignores these, node is silently dropped
-- @id("b2c3d4e5-f6a7-8901-bcde-f12345678901")
-- @nodeType("STG_V2")
SELECT ...
```

```sql
-- RIGHT — bare annotations on the first two lines
@id("b2c3d4e5-f6a7-8901-bcde-f12345678901")
@nodeType("STG_V2")
SELECT ...
```

After writing a node, confirm the node actually loaded — do not trust a green
`coa validate` alone. Run `coa create --dry-run --verbose --include "{ NODE }"`
and check the node appears with its columns rendered; "0 nodes matched" or empty
columns means the annotations were not read (commented out, missing, or a V1
`@nodeType`).

## References

Double-quoted Jinja macros with BOTH args — there is NO name-only /
single-arg form. Never hardcode `db.schema.table`.

- `{{ ref("LOCATION", "NODE_NAME") }}` — resolves to the table AND creates a
  lineage edge.
- `{{ ref_no_link("LOCATION", "NODE_NAME") }}` — resolves, no edge (e.g. the
  node's own table inside a template).
- `{{ ref_link("LOCATION", "NODE_NAME") }}` — edge only, emits no SQL.

PREFER double quotes for NEW or edited refs (per `coa describe sql-format`).
Refs are quote-agnostic in practice — existing repos often use single quotes
(`{{ ref('LOC','NAME') }}`) and `coa` resolves either style
case-insensitively. Leave existing valid single-quoted refs alone; do not
rewrite them just to change quote style.

## Column annotations — the COMPLETE set

Placed AFTER the alias and BEFORE the comma, e.g.
`CREATED_AT @isChangeTracking,`:

- `@isBusinessKey` — required on Persistent Stage + Dimension (optional on
  Stage); the MERGE/SCD key; **affects DDL**.
- `@isChangeTracking` — Persistent Stage change detection; **affects DML**.
- `@id("col-id")` — column lineage; metadata only.
- `@description("text")` — docs; metadata only.

Do NOT invent annotations: `@isSurrogateKey`, `@pii`, `@synqMonitor`,
`@prgTest` are NOT in the coa SQL annotation spec. (`isSurrogateKey` exists as
a boolean column field in the V1 node JSON schema — legitimate in a `.yml`
node — but it is NOT a `.sql` column annotation.)

## SQL conventions

- Target Snowflake SQL dialect (unless the repo's `data.yml` says otherwise).
- Aliases in hand-authored SELECTs are bare UPPER_SNAKE_CASE identifiers
  (e.g. `SUM(QUANTITY * UNIT_PRICE) AS LINE_TOTAL`); the source expression may
  quote the underlying column (`T."COL"`). Double-quoted aliases appear in
  node-type Jinja templates that emit generated DDL, and in some existing
  nodes — match the file you are editing.
- Preserve existing column ordering; keep changes minimal.
- ENUMERATE columns explicitly in a V2 node's SELECT — never `SELECT *`. A
  V2 node type infers its column set by parsing the SELECT; `SELECT *` leaves
  nothing to parse, so `coa create` renders a zero-column table (degenerate
  DDL) even though `coa validate` stays green. If the task says "stage every
  column 1:1", read the source's columns (`coa describe` or the source `.yml`)
  and list each one. Confirm with `coa create --dry-run --verbose` that the
  rendered DDL actually projects the columns.

## Example V2 node

```sql
@id("b2c3d4e5-f6a7-8901-bcde-f12345678901")
@nodeType("Dimension")
SELECT
    CUSTOMER_ID @isBusinessKey,
    EMAIL @description("primary contact"),
    UPDATED_AT @isChangeTracking
FROM {{ ref("STG", "STG_CUSTOMERS") }}
```

(`"Dimension"` stands in for a real V2 node type ID read off disk from
`nodeTypes/` or `.coa/cache/packages/*/nodeTypes/` — a plain `Dimension` type is
typically V1, and may not exist in the workspace at all.) Note the first two lines are BARE — no leading
`--`. That is deliberate and required (see "Write the annotations BARE" above).
