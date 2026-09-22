---
name: coalesce-add-column
description: Add a column to an existing Coalesce V2 (.sql) transformation node, placing any column annotation after the alias and before the comma, then verifying with coa.
---
<!-- coalesce-node-managed: true -->

> **Prerequisite — load `coalesce-pipelines` first.** If you have not already
> loaded the `coalesce-pipelines` skill in this session, load it now, read its
> "Orient first" step, core `coa` loop, and Rules, then return here. This skill
> assumes those invariants (bare `@id`/`@nodeType` first lines, `fileVersion: 2`
> node types, one-node-at-a-time validate → dry-run → create loop) are already
> in context.

Add a column to an existing node. Treat `coa describe sql-format` and `coa validate` as the source of truth; do not guess syntax.

Scope guardrail (`coa describe workflow`):
- IN SCOPE: edit the node the user named; run read-only `coa validate` / `coa create --dry-run`.
- ASK FIRST: editing any OTHER node (including an upstream node to "make the column exist"), or touching `nodeTypes/`. These are shared and can silently break unrelated nodes.

## 1. Locate the node
- Identify the target `nodes/<LOCATION>-<NAME>.sql` file. Use `coa create -d <dir> --list-nodes` if the name is ambiguous.
- This skill targets V2 `.sql` nodes. If the file is a V1 `.yml` node, the edit is still in scope. Load `coalesce-v1-yaml-nodes` for the id graph, then append a column object to `operation.metadata.columns` with `name`, `dataType`, `nullable`, a `columnReference` of `{stepCounter: <this node's id>, columnCounter: <fresh UUID v4>}`, and `sourceColumnReferences` whose `columnReferences[]` names the upstream node's `id` plus that upstream column's `columnCounter`. For a computed column use `columnReferences: []` and put the expression in `transform`. Never reuse an existing `columnCounter` and never alter existing ids. Then run the step 4 verification and confirm the new column appears in the rendered DDL.
- For a V2 `.sql` node, confirm the node's `@nodeType(...)` resolves to a node type with `fileVersion: 2`. If it does not, the new column will be SILENTLY DROPPED (`columns: []` → broken DDL/DML). The node's type already exists and is in use, so upgrading it is a shared-config change — STOP and ASK before bumping its `fileVersion` (see coalesce-workspace-config), rather than proceeding.

## 2. Determine the column source
- If the column is sourced from an upstream node, find which node the relevant `{{ ref("LOCATION", "NODE_NAME") }}` points to, then open `nodes/<LOCATION>-<NODE_NAME>.sql` and confirm the source column exists in its SELECT (aliases are the column names). Do NOT edit the upstream node to add a missing column without asking.
- If the column is computed, build the SQL expression. Use `{{ ref("LOCATION","NAME") }}` (double-quoted, both args) for any new table reference — never hardcode `db.schema.table`. There is no name-only `ref()` form; both args are required.

## 3. Add the column to the SELECT
- Append before `FROM` unless a position is requested. Match the existing indentation.
- Form: `<expression> AS ALIAS`, where `ALIAS` is a bare UPPER_SNAKE_CASE identifier — NOT double-quoted. This matches every authored example (`SUM(QUANTITY * UNIT_PRICE) AS LINE_TOTAL`, `oi.LINE_TOTAL AS REVENUE`). Note the source expression may quote the underlying column (`T."COL"`), but the alias after `AS` stays bare. (Double-quoted `AS "..."` appears only inside node-type Jinja templates that emit generated warehouse DDL — that is not the convention for hand-authored SELECTs.) A bare column needs no alias.
- Column annotations go AFTER the alias and BEFORE the comma — never after the comma:
  - `CUSTOMER_ID AS CUSTOMER_KEY @isBusinessKey,`
  - `LOAD_TS @isChangeTracking,`
- Use ONLY real annotations: `@isBusinessKey` (MERGE/SCD key; required on Persistent Stage + Dimension; affects DDL), `@isChangeTracking` (Persistent Stage change detection; affects DML), `@id("col-id")` (lineage; metadata-only), `@description("text")` (docs; metadata-only). Do NOT invent annotations (e.g. `@isSurrogateKey`, `@pii`). Never add or change the top-level `@id(...)`.

## 4. Verify with coa (required)
1. `coa validate -d <dir> --include "{ <NODE_NAME> }"` — schema + graph scanners, scoped to this node. Scoping matters: the bundled example-repository currently fails `coa validate` with pre-existing legacy errors (environments, jobs, locations, nodeTypes, missing data.yml) that are UNRELATED to your column — disregard that noise and focus on diagnostics for the node you edited. (Schema validation always runs on all files; `--include` only scopes the graph scanners.) Note that on a V2 `.sql` node, columns are inferred from the SELECT with UNKNOWN data types, so the per-node column-reference scanner may not fire the way it does for V1 mapped columns — treat a clean validate as necessary but not sufficient, and confirm the column with the dry-run below.
2. `coa create -d <dir> --include "{ <NODE_NAME> }" --dry-run --verbose` — confirm the new column appears in the generated DDL.
3. `coa run -d <dir> --include "{ <NODE_NAME> }" --dry-run --verbose` — required, not optional: `coa create --dry-run` only proves the DDL renders. A node type's run template gates its DML on `config` values, so a node can pass validate and the create dry-run yet render ZERO run SQL (loading no data at all). Confirm the new column appears in the rendered DML.

If validation fails, fix the node and re-run — do not call `coa create`/`coa run` without `--dry-run` (those execute SQL directly against the warehouse; that is local development, not a request to deploy). Report any errors you cannot resolve within scope.
