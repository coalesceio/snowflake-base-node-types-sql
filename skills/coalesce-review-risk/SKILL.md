---
name: coalesce-review-risk
description: Use when reviewing Coalesce pipeline changes for correctness, impact, and risk before approval — READ-ONLY analysis of diffs, coa validate/dry-run evidence, and downstream blast radius. Never edits files or runs warehouse-mutating commands.
---
<!-- coalesce-node-managed: true -->

# Review & Risk

Scope: analyzing changes for correctness, impact, and risk so users can decide
whether to approve agent work. This is READ-ONLY — never modify files. Use
`coa` as the source of objective evidence; do not minimize risk.

Selector and command details:
[coa-cli reference](../coalesce-pipelines/reference/coa-cli.md).
Format rules being checked:
[sql-format reference](../coalesce-pipelines/reference/sql-format.md).

## Read-only operations

- Read any file in the repo and inspect git diffs.
- `coa describe <topic>` / `coa describe schema <type>` — ground truth for
  schemas and rules. Trust these over the bundled example-repository, which
  currently FAILS `coa validate`.
- `coa validate -d <dir> --json` — Zod schema validation on every YAML file
  plus 15 offline graph scanners (no warehouse). Cite findings as evidence:
  broken column references, invalid per-node column refs, data-type mismatches
  on direct mappings, invalid storage locations, missing node types, duplicate
  names. Scope scanners with `--include` (schema validation always runs on all
  files). The `--json` shape is nested: top-level `success`, then
  `data.validation.results` (per-file array, each
  `{ file, status, errors: [{ path, message }] }`) and
  `data.validation.summary` (counts). Quote the failing `results[].file` paths
  and the specific `errors[].path` / `errors[].message`, plus summary counts.
- `coa create -d <dir> --dry-run --json` and
  `coa run -d <dir> --dry-run --json` — render every node's template offline
  and report template failures: empty SQL, comment-only output, missing DDL,
  empty assignments. These catch breakage before it reaches the warehouse.
- Lineage selectors: `{ NODE }+` = node AND all downstream successors (blast
  radius); `+{ NODE }` = node AND all upstream predecessors. Do not reverse
  these.

## Analysis checklist

1. What nodes were added / modified / deleted / renamed (from the diff)?
2. Per modified node: which columns and SQL logic changed?
3. Run `coa validate --json` and `coa create/run --dry-run --json`; report
   every schema error, scanner problem, and template-render failure.
4. Downstream blast radius: enumerate `{ NODE }+` for each touched node.
5. Job/subgraph membership: check job `includeSelector`/`excludeSelector`
   strings and subgraph `steps` selectors to see which orchestrations pick up
   the change (jobs have no `steps`; subgraphs have no `nodes`).

## Risk factors to flag

- V2 `.sql` node whose `@nodeType` definition lacks `fileVersion: 2` →
  columns are SILENTLY EMPTY (`columns: []`), producing broken DDL/DML.
- Hand-authored V1 `.yml` node with an empty or partial `operation.config` →
  run templates gate their DML on config values (a staging type typically
  needs `insertStrategy: INSERT`, `truncateBefore: true`), so the node passes
  validate and the create dry-run yet renders ZERO run SQL and loads nothing.
  Check the `coa run --dry-run` output per node, not just create.
- Deleted/renamed nodes with downstream dependents (stale `{{ ref() }}`
  edges).
- One-arg `ref()`, hardcoded `db.schema.table`, or invented column
  annotations. The ONLY valid V2 `.sql` column annotations are
  `@isBusinessKey`, `@isChangeTracking`, `@id`, `@description`. Anything else
  (`@isSurrogateKey`, `@pii`, `@synqMonitor`, `@prgTest`, …) is NOT in the
  spec. Note: `isSurrogateKey` DOES exist as a V1 `.yml` column *property* —
  legitimate in a YAML node, but NOT a valid annotation on a `.sql` node.
- Edits to SHARED config — `nodeTypes/*`, locations, workspace, environments,
  jobs, macros, `data.yml`, `fileVersion` bumps, template swaps. These were
  likely OUT of the request's scope and can silently break unrelated nodes;
  surface them prominently. A NEW `nodeTypes/*` directory is no exception: V2
  types normally arrive via the installed base node types package, so a
  hand-authored one in a diff is a shared-config change to surface — ask whether
  the user actually requested a custom type.

## Constraints

- READ-ONLY. Never run `coa create`/`coa run` without `--dry-run` (they
  execute SQL directly against the warehouse — local dev, NOT deploy; cloud
  plan/deploy is a separate git-push process). Never edit files.
- Report findings factually with the `coa` output as evidence; do not
  editorialize or minimize. Always state when impact analysis is incomplete
  (e.g. validate could not run, or selectors were unscoped).
