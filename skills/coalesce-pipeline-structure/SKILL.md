---
name: coalesce-pipeline-structure
description: Use when creating, deleting, renaming, or rewiring Coalesce nodes, subgraphs, or jobs — changing the structural topology of the transformation DAG. Not for editing SQL inside an existing node (use coalesce-sql-transformation).
---
<!-- coalesce-node-managed: true -->

> **Prerequisite — load `coalesce-pipelines` first.** If you have not already
> loaded the `coalesce-pipelines` skill in this session, load it now, read its
> "Orient first" step, core `coa` loop, and Rules, then return here. This skill
> assumes those invariants (bare `@id`/`@nodeType` first lines, `fileVersion: 2`
> node types, one-node-at-a-time validate → dry-run → create loop) are already
> in context.

# Pipeline Structure

Scope: creating, deleting, renaming, and rewiring nodes, subgraphs, and jobs —
the structural topology of the transformation DAG. The `coa` CLI is the source
of truth and the verifier: when unsure of a shape, run `coa describe <topic>`
or `coa describe schema <type>` instead of guessing. Never copy shapes from
the example repo files — they use legacy shapes that fail `coa validate`.

Shared references:
[sql-format](../coalesce-pipelines/reference/sql-format.md) (node files, refs,
annotations) and
[yaml-spec](../coalesce-pipelines/reference/yaml-spec.md) (job/subgraph
schemas, node types).

## Core loop (every change)

Define → `coa validate -d <dir>` →
`coa create --dry-run --include "{ NODE }"` (add `--verbose` for SQL) →
`coa run --dry-run --verbose --include "{ NODE }"` → `coa create` → `coa run`
→ verify → iterate. Both dry-runs are required: `create --dry-run` proves only
that the DDL renders, not that the node can load any data (see "Creating a V1
(.yml) node"). `coa create`/`coa run` without `--dry-run` execute SQL DIRECTLY
against the warehouse — LOCAL development, NOT deploy. Cloud plan/deploy is
separate (git push → web UI/CI).

## In scope without asking

- Create/edit the specific nodes the user asked for in `nodes/`.
- Read-only commands: `coa validate`, `coa describe`, any `--dry-run`.

## ASK FIRST (shared config — can silently break unrelated nodes)

- Editing nodes NOT in the request.
- Creating, modifying, or removing any node type, incl. bumping its
  `fileVersion` or swapping its template pattern.
- Changing locations, workspaces, environments, jobs, macros, or `data.yml`.

**Never author a node type for a `.sql` node.** Base types come from the
installed base node types package, which `coa install` materializes as a
read-only tree at `.coa/cache/packages/<alias>/nodeTypes/<Name>-<id>/`; each
materialized `definition.yml` carries the resolvable `<alias>:::<id>` id to put
in `@nodeType()`. Discovery is file-system based: check `nodeTypes/` and
`.coa/cache/packages/*/nodeTypes/`, and read each `definition.yml` — TYPE
NAMES VARY BY WORKSPACE, so never assume a type called `Stage` exists (in the
base packages the staging-layer type is typically `Work`, e.g.
`base-node-types:::204`). If none are present, run `coa install -d <dir>` —
safe without asking, though it hydrates only packages already declared under
`packages/` and prints "No packages to install." otherwise; `coa init` writes
that declaration, so an absent `packages/` means re-running `coa init` (ask
the user), never hand-creating shared config. If that still yields nothing,
author the node as V1 `.yml` and continue. See coalesce-workspace-config.

## Creating a node (V2 .sql, when a `fileVersion: 2` node type exists)

- File: `nodes/<LOCATION>-<NAME>.sql`. The filename sets location + name;
  `@location` is ignored. Case-sensitive; NAME unique (`.yml` and `.sql`
  cannot coexist for the same location+name); UPPER_SNAKE_CASE by repo
  convention; `nodes/` has no subdirectories.
- Required top annotations before any SQL: `@id("<fresh UUID>")` (never reuse
  an existing one) and `@nodeType("<TypeID>")` — which MUST resolve to a
  `fileVersion: 2` node type, or columns are SILENTLY EMPTY (broken DDL/DML).
  Normally a package ID from the base node types package; if none is available,
  `coa install -d <dir>` first (see coalesce-workspace-config).
- Write both annotations as BARE lines — do NOT prefix them with `--` or wrap
  them in `/* */`. `@id("…")` is not valid SQL on its own, but commenting it
  out makes `coa` unable to read it: the node is silently dropped (validate
  shows 0 errors, node never builds). Then confirm the node loaded with
  `coa create --dry-run --verbose --include "{ NODE }"` — not `coa validate`
  alone, which stays green for a dropped node.
- Use V1 (`.yml`, fileVersion 1) whenever the node type you need has no
  `fileVersion: 2` definition, and for Source nodes and V1-only types. Generate
  Source nodes with `coa sources add`, never by hand. Load
  `coalesce-v1-yaml-nodes` before touching an existing `nodes/*.yml`.
- Refs, column annotations, and a full example: see the sql-format reference.
  Only `@isBusinessKey`, `@isChangeTracking`, `@id`, `@description` exist.

## Creating a V1 (.yml) node

Use this when no `fileVersion: 2` node type exists for the type you need. It is
a supported authoring path, not a workaround. File:
`nodes/<LOCATION>-<NAME>.yml`. Identity comes from the YAML, not the filename,
so keep both in sync.

Copy the column list from the imported source node in `nodes/` rather than
inventing one: names, `dataType`, and the upstream `columnCounter` values you
need for lineage all live there.

Two values you cannot guess:

- **`sqlType`** — the node type's real name or id, read off disk. Type names
  vary by workspace: list `nodeTypes/` and
  `.coa/cache/packages/*/nodeTypes/` and read each `definition.yml` (`name`,
  `description`, `nodeMetadataSpec`) to pick the right one. In the base
  packages the staging-layer type is typically `Work`, not `Stage`. Plain
  built-in names (`Stage`, `View`, `Dimension`, `Fact`, `persistentStage`)
  resolve only where those built-in V1 types exist in `nodeTypes/`, which
  `coa init` writes when the base package is unavailable. A name that isn't
  there fails as `error[missingNodeType]: node type "X" is not available`.
- **`config`** — copy the node type's config DEFAULTS from its
  `definition.yml` `nodeMetadataSpec`. Node type run templates gate their DML
  on config values (Work-204 gates the INSERT on
  `config.insertStrategy == 'INSERT'` and the truncate on
  `config.truncateBefore`), so `config: {}` passes `coa validate` and
  `coa create --dry-run` yet renders ZERO run SQL — a node that can never load
  data. Typical staging values: `insertStrategy: INSERT`,
  `truncateBefore: true`, `testsEnabled: false`.

```yaml
fileVersion: 1
id: <fresh UUID v4>                 # this node's id; never reuse another node's
name: <NAME>
type: Node
operation:
  type: sql                         # sourceInput only for Source nodes
  sqlType: <TYPE_NAME_OR_ID>        # read off disk; often Work, not Stage
  locationName: <LOCATION>
  name: <NAME>                      # mirrors the top-level name
  isMultisource: false
  materializationType: table        # table | view
  config:                           # copy the type's nodeMetadataSpec defaults
    insertStrategy: INSERT          # {} renders zero run SQL — never ship {}
    truncateBefore: true
    testsEnabled: false
  metadata:
    columns:
      - name: <COLUMN>
        dataType: <TYPE>            # copy from the upstream column
        description: ""             # REQUIRED by validate; "" is fine
        nullable: true
        columnReference:
          stepCounter: <this node's id>
          columnCounter: <fresh UUID v4>
        sourceColumnReferences:
          - columnReferences:
              - stepCounter: <upstream node id>
                columnCounter: <upstream column's columnCounter>
            transform: ""           # "" = pass-through; else the SQL expression
    sourceMapping:
      - name: <NAME>
        aliases: {<ALIAS>: <upstream node id>}   # SQL alias → node id
        dependencies:
          - {locationName: <SRC_LOCATION>, nodeName: <SRC_NAME>}
        join:
          joinCondition: |-
            FROM {{ ref('<SRC_LOCATION>', '<SRC_NAME>') }} "<ALIAS>"
        noLinkRefs: []              # refs that create no edge (often self)
        customSQL:
          customSQL: ""
```

- `columnReference.stepCounter` is ALWAYS this node's own `id`; `columnCounter`
  is a fresh UUID per column. Never reuse an id.
- `sourceColumnReferences[].columnReferences[]` names the UPSTREAM node's `id`
  and the UPSTREAM column's `columnCounter`. That is the lineage edge. A
  computed column with no upstream uses `columnReferences: []` and carries the
  expression in `transform`.
- Verify with `coa validate -d <dir> --include "{ <NAME> }"`, then
  `coa create -d <dir> --include "{ <NAME> }" --dry-run --verbose`; confirm the
  rendered DDL has a populated column list. Then
  `coa run -d <dir> --include "{ <NAME> }" --dry-run --verbose` — mandatory,
  not optional: empty run SQL here means `config` is missing the node type's
  defaults, and the node would build a table it never loads.
- Deeper reference (the id graph, multisource, what not to touch):
  `coalesce-v1-yaml-nodes` and `coa describe schema node`.

## Impact analysis (lineage selectors)

- Downstream dependents of NODE: `--include "{ NODE }+"`
- Upstream sources of NODE: `--include "+{ NODE }"`

Use these (not manual text search) before deleting or renaming.

## Delete / rename / rewire

- Delete: confirm `{ NODE }+` has no dependents (or rewire them first).
- Rename: rename the FILE (keep the same `@id`), then update every downstream
  `{{ ref("LOC","OLD") }}` to the new name, plus any job/subgraph selectors —
  the coalesce-rename-node-cascade skill has the full procedure.
- After any change, re-run `coa validate` to catch broken references.

## Job and subgraph shapes

Jobs are NOT a steps array (`includeSelector`/`excludeSelector` strings,
integer-string `id`). Subgraphs store node IDs in `steps` (NOT a `nodes`
array): each entry is a node's `id` — a node file's `id:`, or a `.sql` node's
`@id` — NOT a node name and NOT a selector string. The serve UI resolves
subgraph membership as `steps ∩ live-node-ids` and silently drops any step that
isn't a real node ID. Exact schemas, examples, and legacy-shape warnings: see the
yaml-spec reference, and confirm with `coa describe schema job` /
`coa describe schema subgraph`. Jobs and subgraphs are shared config — ask
first.
