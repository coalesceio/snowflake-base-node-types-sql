---
name: coalesce-create-stage-node
description: Create a new Coalesce staging node from a source node — a Stage that maps every source column 1:1, with the V2 node-type preflight check and coa verification loop.
---
<!-- coalesce-node-managed: true -->

> **Prerequisite — load `coalesce-pipelines` first.** If you have not already
> loaded the `coalesce-pipelines` skill in this session, load it now, read its
> "Orient first" step, core `coa` loop, and Rules, then return here. This skill
> assumes those invariants (bare `@id`/`@nodeType` first lines, `fileVersion: 2`
> node types, one-node-at-a-time validate → dry-run → create loop) are already
> in context.

Create a Stage node that maps every column of a source node 1:1. A Stage is the
first hop out of a Source: it selects the source's columns unchanged so later
layers build on a stable name. `coa describe sql-format` and `coa describe node-types`
 document the node file and node type formats; consult them if anything below is
 unclear.

## 0. Critical preflight — which staging node type exists, and is it V2?

**The staging-layer type's NAME varies by workspace — do not assume `Stage`.**
The Snowflake base node types package ships no `Stage` type at all; its
staging/work-layer type is named `Work` (`base-node-types:::204`). Naming a
type that isn't there fails with
`error[missingNodeType]: node type "Stage" is not available`. So discover the
type before you write anything: list `nodeTypes/` and
`.coa/cache/packages/*/nodeTypes/`, and read each `definition.yml` — `name`,
`description`, and `nodeMetadataSpec` tell you which type is the staging
layer, and its `fileVersion` tells you the format. Plain built-in names
(`Stage`, `View`, `Dimension`, `Fact`, `persistentStage`) resolve only when
those built-in V1 types are present in `nodeTypes/`, which `coa init` writes
when the base package is unavailable; they are not always available.

A `.sql` node is a V2 node and REQUIRES a node type whose `definition.yml` has
`fileVersion: 2`. If you point `@nodeType(...)` at a V1 staging type
(`fileVersion: 1` or absent), the node loads but its columns are
**silently empty** (`columns: []`) — `coa create`/`coa run` then emit broken
DDL/DML with no error. (`coa describe sql-format`, `coa describe node-types`.)

Check what staging type actually exists:

- `.coa/cache/packages/*/nodeTypes/<Name>-<id>/definition.yml` — the installed
  package types, materialized as a read-only file tree by `coa install`. The
  normal staging type is a package type from the base node types package
  (typically named `Work`, not `Stage`); each
  materialized `definition.yml` carries the resolvable id in `<alias>:::<id>`
  form, and that exact id is what `@nodeType()` takes. Never edit this tree —
  `coa install` regenerates it. (`coa describe node-types` documents the folder
  layout and `definition.yml` fields; it does not list what is installed.)
- A workspace-local definition, if any, lives in
  `nodeTypes/<DisplayName>-<ID>/definition.yml`; the `@nodeType()` value is the
  `id` field (also the part after the last dash in the folder name). Read its
  `fileVersion` (absent or `1` = V1; `2` = V2). `coa describe schema nodeType`
  documents the shape.

Then branch:

- **A V2 staging node type exists (`fileVersion: 2`)** — proceed; author a
  `.sql` node (preferred for all transformations). Note its `id` for step 3.
- **No V2 staging type on disk** — run `coa install -d <dir>` to hydrate
  the workspace's packages (safe, no need to ask), then re-check `nodeTypes/`
  and `.coa/cache/packages/*/nodeTypes/`. `coa install` hydrates only packages
  already declared under `packages/` and otherwise just prints "No packages to
  install."; `coa init` writes that declaration, so if `packages/` is absent
  the fix is re-running `coa init` (ask the user first), never hand-creating
  shared config. Do NOT create a node type yourself: V2 types come from the
  platform's base node types package (`coa init` declares it; the package may
  be unavailable outside production registries).
- **Only a V1 staging type exists (`fileVersion` absent or `1`)**: author the
  node as a V1 `.yml` node. Do NOT upgrade the node type and do NOT stop: V1
  is the supported authoring format whenever the workspace's node types are V1.
  The `fileVersion` in `nodeTypes/<ID>/definition.yml` decides this, never the
  platform. Follow the recipe in
  **coalesce-pipeline-structure** ("Creating a V1 (.yml) node"), copy the
  column list from the source node in `nodes/`, then go straight to step 4 to
  verify. Bumping an in-use type's `fileVersion` changes DDL/DML for every node
  of that type, so that still requires **STOP and ASK the user first**.

  Never silently write a `.sql` node against a V1 staging type — that is the
  empty-columns trap above.

## 1. Gather the source

1. Identify the source node, its location, and its columns. Use `coa` as the
   authoritative surface: `coa create -d <dir> --list-nodes` 
   (or `coa run -d <dir> --list-nodes`) to enumerate nodes, and read the source file
   (`nodes/<SRC_LOCATION>-<SRC_NAME>.yml`) for its column names. Do not rely on
   cached context as ground truth.
2. If `nodes/` is empty or holds no Source node yet, there is nothing to stage
   from: `coa sources list` shows the warehouse tables per location and
   `coa sources add` scaffolds the Source node. Do that first, never hand-write
   source YAML.
3. Note every source column name; the staging node maps them 1:1.

## 2. Decide the target file

- Path: `nodes/<LOCATION>-<NAME>.sql` (V2) or `.yml` (V1). The filename sets the
  location and name — an `@location` annotation is ignored. `nodes/` is flat (no
  subdirectories).
- Names are `UPPER_SNAKE_CASE` and unique. A name collides if either
  `nodes/<LOCATION>-<NAME>.yml` or `nodes/<LOCATION>-<NAME>.sql` already exists —
  the two extensions cannot coexist. Confirm the name is free before writing.
- Use the staging location the user asked for (commonly `STG`). Do not assume a
  fixed location.

## 3. Write the V2 `.sql` node

(If step 0 sent you down the V1 path, write the `.yml` per the
coalesce-pipeline-structure recipe and skip to step 4.)

Required top annotations, before any SQL:

- `@id("<UUID>")` — PREFER a fresh UUID v4. NEVER reuse or modify an existing
  node's `@id`; duplicate IDs collide across the workspace.
- `@nodeType("<TypeID>")` — the V2 staging type ID you found in step 0.
  Normally a package ID, `<alias>:::<id>`; a workspace-local type uses the `id`
  from `nodeTypes/<DisplayName>-<ID>/definition.yml`.

Then a `SELECT` mapping each source column 1:1, and a `FROM` using a
double-quoted `ref()` with BOTH args:

```sql
@id("3f29c8a1-7b04-4e6d-9c2a-1d5e8f0a6b73")
@nodeType("base-node-types:::204")

SELECT
    "C_CUSTKEY"    AS "C_CUSTKEY",
    "C_NAME"       AS "C_NAME",
    "C_ADDRESS"    AS "C_ADDRESS"
FROM {{ ref("SRC", "CUSTOMER") }} CUSTOMER
```

In the example above, `"base-node-types:::204"` stands in for the actual V2
staging type ID from step 0 — usually a package ID of the form
`<alias>:::<id>`, and in the base packages the staging type is `Work-204`.
Substitute the real V2 type ID verbatim as the type's `definition.yml` on disk
spells it. Do NOT write `@nodeType("Stage")` on the assumption that a `Stage`
type exists: the base packages ship none, and a plain built-in name resolves
only when a `fileVersion: 2` type with that exact `id` is on disk (the
built-in `Stage`/`View`/… types `coa init` writes when the base package is
unavailable are V1, so they take the V1 `.yml` path instead).

Rules:

- `{{ ref("LOCATION", "NODE_NAME") }}` — double quotes, both args required.
  There is no name-only form. `ref()` creates the lineage edge and resolves to
  the real `database.schema.table`; NEVER hardcode `db.schema.table`.
- A plain 1:1 Stage needs no column annotations. If you want lineage IDs or
  docs, the only valid column annotations are `@id("col-id")` and
  `@description("text")` (both metadata-only), placed AFTER the alias and BEFORE
  the comma. `@isBusinessKey` / `@isChangeTracking` belong on Persistent
  Stage/Dimension, not a plain Stage. Do NOT invent annotations.

## 4. Verify with coa (mandatory)

Run the core loop and fix issues before moving on:

1. `coa validate -d <dir>` — schema + graph scanners pass (broken refs,
   duplicate names, missing node types, etc.). Add `--json` for machine-readable
   output. If errors point only at pre-existing workspace config you were not
   asked to touch, surface that to the user — do not edit shared config to make
   validate pass.
2. `coa create -d <dir> --include "{ <NAME> }" --dry-run --verbose` — inspect the
   generated DDL. If the column list is empty, the node type is still V1 — go
   back to step 0 and point `@nodeType` at a V2 package type (ask before
   upgrading an in-use type).
3. `coa run -d <dir> --include "{ <NAME> }" --dry-run --verbose` — mandatory,
   not optional. `create --dry-run` passes nodes that can never load data:
   node type run templates gate their DML on config values (Work-204 gates the
   INSERT on `config.insertStrategy == 'INSERT'`, the truncate on
   `config.truncateBefore`), so a node whose `config` lacks the type's
   defaults renders ZERO run SQL. Empty run SQL here means fix `config`
   against the type's `nodeMetadataSpec` before going further.

`coa create`/`coa run` execute SQL DIRECTLY against the warehouse (local
development, not deployment). Stop after the dry-run unless the user wants to
materialize the table; cloud deploy is a separate git-push + web-UI flow.
