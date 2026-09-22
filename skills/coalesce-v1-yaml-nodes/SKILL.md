---
name: coalesce-v1-yaml-nodes
description: Use when reading, explaining, or making narrow edits to Coalesce V1 YAML nodes (nodes/<LOCATION>-<NAME>.yml) — the UI/API-generated node format. Covers the file shape, the id-based column lineage graph, authoring a V1 node when no fileVersion 2 node type exists, and what an agent should and should not touch.
---
<!-- coalesce-node-managed: true -->

> **Prerequisite — load `coalesce-pipelines` first.** If you have not already
> loaded the `coalesce-pipelines` skill in this session, load it now, read its
> "Orient first" step, core `coa` loop, and Rules, then return here.

V1 nodes are the YAML node format at `nodes/<LOCATION>-<NAME>.yml`. They are
what the Coalesce **UI and API produce** — a serialized form of the node graph,
including an id-based column lineage graph. Most existing workspaces are
entirely or mostly V1.

**The point of this skill is comprehension, not authorship.** Read a V1 node
confidently, answer questions about it, trace lineage through it, and make the
narrow edits listed below. Hand-authoring a whole V1 node is a deliberate,
narrow exception: do it for Source nodes, and when the node type you need has
no `fileVersion: 2` definition, following the recipe in
coalesce-pipeline-structure. Otherwise prefer V2 `.sql` and do not
restructure an existing column graph. See "Scope" at the end.

## Schema is authoritative — read it

```
coa describe schema node      # full JSON Schema for nodes/<LOCATION>-<NAME>.yml
coa describe schemas          # every workspace file type
```

(There is no `coa describe node` topic — the node schema lives under
`coa describe schema node`.) Confirm every field against that output rather
than against a sibling node file.

## File shape

Five required top-level keys, `additionalProperties: false`:

| Key | Value |
|-----|-------|
| `fileVersion` | `1` (integer) — this is what makes it a V1 node |
| `id` | node UUID — **immutable**, and the anchor of the column graph |
| `name` | node name |
| `type` | constant `Node` |
| `operation` | everything else (see below) |

`operation` has two shapes, discriminated by `operation.type`:

- **`type: sourceInput`** — a **Source** node. `sqlType: Source`, and
  `metadata` carries just `columns`. Required: `locationName`, `name`,
  `sqlType`, `type`, `metadata`.
- **`type: sql`** — every **transformation** node (Stage, Persistent Stage,
  View, Dimension, Fact, custom/package types). Required: `locationName`,
  `name`, `type`, `isMultisource`, `metadata`, `materializationType`. Its
  `metadata` requires both `columns` and `sourceMapping`.

Other `operation` fields you will see: `database`/`schema` (usually `""` —
resolved from `workspace.yml`/environment mappings, not from here),
`description`, `deployEnabled`, `config` (node-type options such as
`preSQL`/`postSQL`/`truncateBefore`/`insertStrategy`/`testsEnabled`),
`materializationType` (`table`/`view`), `overrideSQL`, `version: 1`.

`config` is not decoration: node type run templates GATE their DML on it
(Work-204 emits its INSERT only when `config.insertStrategy == 'INSERT'`, and
its truncate only when `config.truncateBefore`). A hand-authored node must
carry the type's config defaults, copied from its `definition.yml`
`nodeMetadataSpec` — typical staging values `insertStrategy: INSERT`,
`truncateBefore: true`, `testsEnabled: false`. An empty `config: {}` still
passes `coa validate` and `coa create --dry-run` while rendering ZERO run SQL,
so always confirm with `coa run --include "{ NAME }" --dry-run --verbose`.

### `sqlType` is the node type — the V1 analogue of `@nodeType`

`operation.sqlType` names the node type. It is either a built-in name
(`Source`, `Stage`, `View`, `Dimension`, `Fact`, `persistentStage`) or a
numeric string for a workspace/package type: `sqlType: "41"` resolves to
`nodeTypes/PersistentStage-41/`, `"42"` to `nodeTypes/Stage-42/`. Resolve one
by looking for the folder whose suffix after the last dash matches.

**The names available VARY BY WORKSPACE — check before you write one.** The
built-in names resolve only where those built-in V1 types exist in
`nodeTypes/`, which `coa init` writes when the base node types package is
unavailable; the base packages themselves ship no `Stage` type at all — their
staging/work-layer type is `Work` (`base-node-types:::204`). So list
`nodeTypes/` and `.coa/cache/packages/*/nodeTypes/` and read each
`definition.yml` (`name`, `description`, `nodeMetadataSpec`) to pick the type.
A name that isn't there fails as
`error[missingNodeType]: node type "X" is not available`.

V1 nodes
require a `fileVersion: 1` (or absent) node type — the V2 `.sql` node format is
the one that requires `fileVersion: 2`.

### Identity comes from the YAML, NOT the filename

This is the opposite of V2 `.sql` nodes, where the filename sets location and
name. For a V1 `.yml`, `coa` reads `name` and `operation.locationName` from
inside the file; renaming the file alone changes nothing. Keep all four in
sync anyway — filename prefix, filename suffix, `name`, `operation.locationName`
(and `operation.name`, which mirrors the top-level `name`) — because humans and
tooling both rely on the convention.

## The column graph — why you don't hand-build these

Every column carries a `columnReference` and, on transformation nodes,
`sourceColumnReferences` pointing at upstream columns. These are **ids, not
names**:

- `columnReference.stepCounter` — always **this node's own `id`**.
- `columnReference.columnCounter` — this column's own id (UUID in modern
  workspaces; a bare integer in older exports).
- `sourceColumnReferences[].columnReferences[]` — `{stepCounter, columnCounter}`
  pairs naming the **upstream node's `id`** and the **upstream column's
  `columnCounter`**. This is the real lineage edge.
- `sourceColumnReferences[].transform` — the SQL expression, e.g.
  `cast(calls.ts as timestamp_ntz)`. Empty string means pass-through.
- A column derived from no upstream column (`COUNT(*)`, `CURRENT_TIMESTAMP`)
  uses an empty `columnReferences: []`, or the sentinel
  `stepCounter: "0"` / `columnCounter: "0"`, with the expression in `transform`.

Fabricating these ids by hand is how V1 nodes get silently broken: the node
still parses, but lineage points nowhere.


## `sourceMapping` — the FROM/JOIN half of the node

`operation.metadata.sourceMapping` is a list of source groups. Each entry
requires `name`, `join`, `dependencies`:

- `join.joinCondition` — the literal `FROM ... JOIN ... WHERE ...` SQL, with
  `{{ ref('LOCATION', 'NODE') }}` macros and sometimes `{{ this }}` for the
  node's own table (incremental patterns).
- `dependencies[]` — `{locationName, nodeName}` declaring the graph edges.
  **Name-based**, so a node rename breaks these.
- `aliases` — SQL alias → upstream node `id`.
- `noLinkRefs[]` — referenced without creating an edge (typically the node
  itself).
- `customSQL.customSQL` — a raw SQL override string.

More than one entry means a **multisource** node (`isMultisource: true`): each
group is a separate insert path into the same target, and every column's
`sourceColumnReferences` has one entry per group, in order.

## Annotated example — a Stage node

```yaml
fileVersion: 1
id: a804f266-0572-425a-8eff-f2cd91205885     # node id; also every stepCounter below
name: CALL_HISTORY
operation:
  config: {insertStrategy: INSERT, truncateBefore: true, testsEnabled: true}
  locationName: STAGE
  materializationType: table
  isMultisource: false
  metadata:
    columns:
      - name: DATE
        dataType: TIMESTAMP_NTZ(9)
        description: ""
        columnReference:                      # this column's identity
          stepCounter: a804f266-0572-425a-8eff-f2cd91205885   # == node id
          columnCounter: d626afba-c0df-4915-b864-edd39012502f
        sourceColumnReferences:               # the lineage edge
          - columnReferences:
              - stepCounter: 0b61ea6a-258f-4107-9271-825c33ae0501  # SOURCE.CALLS node id
                columnCounter: 5a63f4d6-5cb8-42f2-8166-7bcb7eda78de # its TS column
            transform: cast(calls.ts as timestamp_ntz)
      - name: TOTAL_CALLS
        dataType: INTEGER
        description: ""
        columnReference: {stepCounter: a804f266-..., columnCounter: 70fdf3d6-...}
        sourceColumnReferences:               # derived: no upstream column
          - columnReferences: [{stepCounter: "0", columnCounter: "0"}]
            transform: COUNT(*)
    sourceMapping:
      - name: CALL_HISTORY
        aliases: {CALLS: 0b61ea6a-258f-4107-9271-825c33ae0501}
        dependencies:
          - {locationName: SOURCE, nodeName: CALLS}
        join:
          joinCondition: |-
            FROM {{ ref('SOURCE', 'CALLS') }} "CALLS"
            WHERE DATE between to_date('1/1/2023') and to_date('3/14/2023')
            GROUP BY DATE
        noLinkRefs: []
  name: CALL_HISTORY                          # mirrors the top-level name
  sqlType: Stage                              # the node type — name varies; often "Work"
  type: sql
  overrideSQL: false
type: Node
```

A Source node is the same skeleton minus `sourceMapping`/`sourceColumnReferences`,
with `type: sourceInput`, `sqlType: Source`, and a single
`metadata.join.joinCondition` of the form `FROM {{ ref('SRC', 'TABLE') }}`.

## Reading a V1 node — how to answer common questions

| Question | Where to look |
|----------|---------------|
| What columns, what types? | `operation.metadata.columns[].name` / `.dataType` |
| What does column X compute? | that column's `sourceColumnReferences[].transform` |
| Where does column X come from? | its `sourceColumnReferences[].columnReferences[]` → find the node whose `id` matches `stepCounter`, then the column whose `columnCounter` matches |
| What are this node's upstreams? | `sourceMapping[].dependencies[]` (and the `ref()` calls in `joinCondition`) |
| What are its downstreams? | `coa create --include "{ NAME }+" --dry-run`, or grep `nodeName: NAME` across `nodes/` |
| What's the merge/SCD key? | columns with `isBusinessKey: true` / `keyColumnType` |
| What node type / layer? | `operation.sqlType` → `nodeTypes/<Name>-<sqlType>/definition.yml` or `.coa/cache/packages/*/nodeTypes/<Name>-<id>/definition.yml` |
| Table or view? | `operation.materializationType` |

Prefer `coa` over reading raw YAML when you can: `coa create -d <dir>
--list-nodes` to enumerate, `coa create --include "{ NAME }" --dry-run
--verbose` to see the SQL a V1 node actually renders.

## `coa validate` scanners that specifically police V1 nodes

Run `coa validate` after ANY edit to a `.yml` node. These scanners exist to
catch exactly the damage a careless V1 edit does:

- **Column Sources / Column Source Mappings / Column Dependencies / Column
  References** — the id graph resolves; `sourceMapping` dependencies point at
  nodes that exist. A rename surfaces here as `sourceMapping dependency does
  not resolve: LOC.NAME`.
- **Column Data Types** (warning) — a column's `dataType` disagrees with its
  upstream source column's type.
- **Column Names**, **Duplicate Node IDs**, **Duplicate Node Names**,
  **Circular Dependencies**.
- **Node Type Validity / Availability** — `sqlType` resolves.
- **Storage Locations / Node Location Data** — `locationName` is in
  `locations.yml` and mapped in `workspace.yml`.

## What you should and should not do

**Safe — do these when asked:**

- Read, explain, summarize, diff, and trace lineage through V1 nodes.
- Answer "what does this node do / where does this column come from".
- Edit metadata-only text in place: a node or column `description`.
- Edit an existing column's `transform`, or a `sourceMapping[].join.joinCondition`
  — SQL strings that don't touch the id graph. Then `coa validate` and
  `coa create --include "{ NAME }" --dry-run --verbose`.
- Flip `deployEnabled`, or a node-type `config` value the user names explicitly.
- Adjust a column's `dataType` to clear a Column Data Types warning when the
  user asks for that.

**Do NOT do these:**

- Do not change any `id`, `columnCounter`, or `stepCounter`. Ever. They are the
  graph.
- Do not convert a V2 `.sql` node into a V1 `.yml` one. For a NEW
  transformation node, author a V2 `.sql` node when a `fileVersion: 2` node
  type exists (see `coalesce-create-stage-node` and `coalesce-pipelines`); when
  none exists, hand-author the V1 `.yml` per the coalesce-pipeline-structure
  recipe. For new **Source** nodes, use `coa sources add` — it generates
  correct V1 YAML from the warehouse tables; never scaffold source YAML by hand.
- Adding a column to an existing V1 node is in scope (mint a fresh
  `columnCounter`, point `sourceColumnReferences` at real upstream ids, then
  validate and dry-run, see `coalesce-add-column`). Do NOT remove columns or
  restructure `sourceMapping` (adding a source group, making a node
  multisource): those require cross-wiring ids that only the UI/API and
  `coa sources` produce reliably. Offer the alternatives instead: do it in the
  Coalesce UI, or build the new shape as a V2 `.sql` node.
- Do not "tidy" a V1 node — no key reordering, no dropping fields that look
  redundant (`aliases`, `noLinkRefs`, `columnReference` on a derived column),
  no rewriting single-quoted `ref()` calls to double quotes. These files are
  machine-serialized; churn creates unreviewable diffs and round-trip conflicts
  with the UI.
- Do not rename a V1 node by editing the file alone — `name`,
  `operation.name`, `operation.locationName`, the filename, every downstream
  `sourceMapping[].dependencies[]`, every `ref()` string, and job/subgraph
  selectors all have to move together. Use `coalesce-rename-node-cascade`.

**If the user insists on an out-of-scope V1 edit:** say plainly that hand-editing
the V1 column graph is error-prone and that the UI/API is the supported path.
If they reaffirm, proceed carefully on the smallest possible change — a fresh
UUID for any new `columnCounter`, `stepCounter` set to the node's own `id`,
`sourceColumnReferences` pointing at real upstream `columnCounter` values you
looked up — then `coa validate` and a `--dry-run --verbose` and show them the
rendered SQL before anything executes.
