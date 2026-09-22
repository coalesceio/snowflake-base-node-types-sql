---
name: coalesce-workspace-config
description:  Use when a task touches Coalesce shared workspace configuration — data.yml, locations.yml, workspace.yml, environments/, or node type definitions and Jinja templates in nodeTypes/. Everything here is high-risk shared config requiring user confirmation before edits.
---
<!-- coalesce-node-managed: true -->

> **Prerequisite — load `coalesce-pipelines` first.** If you have not already
> loaded the `coalesce-pipelines` skill in this session, load it now, read its
> "Orient first" step, core `coa` loop, and Rules, then return here. This skill
> assumes those invariants (bare `@id`/`@nodeType` first lines, `fileVersion: 2`
> node types, one-node-at-a-time validate → dry-run → create loop) are already
> in context.

# Workspace Configuration

Scope: the SHARED, high-risk files — `data.yml`, `locations.yml`,
`workspace.yml`, `environments/`, and node type definitions in `nodeTypes/`.
Treat `coa describe <topic>` and `coa describe schema <type>` as the source of
truth — NOT the example files (the bundled example-repository fails
`coa validate`).

File shapes, the location-name consistency rule, where node types come from, and
the V2 CTAS template pattern:
[yaml-spec reference](../coalesce-pipelines/reference/yaml-spec.md).
Credentials and `~/.coa/config`:
[coa-cli reference](../coalesce-pipelines/reference/coa-cli.md).

## GUARDRAIL — surface the choice FIRST

Every file in this scope is shared across many nodes; an edit here can
SILENTLY break unrelated nodes. Before editing `locations.yml`,
`workspace.yml`, `environments/`, `data.yml`, jobs, macros, or modifying a node
type that other nodes already use (including bumping its `fileVersion` /
swapping its template pattern): STOP, explain the impact, and get the user's
go-ahead. Read-only commands (`coa describe`, `coa validate`, `coa doctor`
without `--fix`, any `--dry-run`) you may run freely. Never put secrets in repo
files — credentials live in `~/.coa/config`.

**Do NOT author node types** (see "Getting V2 node types" below). Base types
come from the installed base node types package, not from files you write.
Creating, modifying, or upgrading anything under `nodeTypes/` requires the
user's explicit request and approval.

## The fileVersion 1 vs 2 trap

V2 `.sql` nodes (the default for staging/intermediate transforms) REQUIRE a node type with
`fileVersion: 2` in its `definition.yml`. With fileVersion 1 (or absent), a
`.sql` node parses to `columns: []` — no error, but broken DDL/DML at render.
For V2, `col.dataType` is `UNKNOWN`, so templates MUST use the CTAS pattern
(iterate `sources` → `source.columns`, guard create with `WHERE 1=0`) and
never emit `{{ col.dataType }}`. V1 node types use explicit-column DDL. The
remedy is never to write a template: point `@nodeType` at a V2 type from the
installed base node types package (hydrate with `coa install` if none are
present — see below).

## Getting V2 node types

V2 node types are NOT authored. They ship in the base node types package for
your platform, which `coa init` declares in `packages/base-node-types.yml` and
`coa install` hydrates. Hydrated package types show up as package node types
with IDs of the form `<alias>:::<id>` — that is the normal value for
`@nodeType()`.

**Find them — node type discovery is file-system based:**

- `nodeTypes/<DisplayName>-<ID>/definition.yml` — the workspace's own types.
- `.coa/cache/packages/<alias>/nodeTypes/<Name>-<id>/definition.yml` — the
  installed package types, materialized as a READ-ONLY file tree by
  `coa install` (definition.yml plus `create.sql.j2` / `run.sql.j2`). Each
  materialized `definition.yml` carries the resolvable id in `<alias>:::<id>`
  form — that exact id is what goes in `@nodeType()`. The tree is derived;
  `coa install` regenerates it, so never edit it. (`.coa/cache/packages.json`
  is the machine cache the tree mirrors.)
- `packages/` (the package declarations) confirms which packages the workspace
  expects.

Read each `definition.yml` you find (`name`, `description`,
`nodeMetadataSpec`) rather than assuming a type name: **names vary by
workspace**, and the base packages ship no `Stage` type — their
staging/work-layer type is `Work` (`base-node-types:::204`). The built-in V1
names (`Stage`, `View`, `Dimension`, `Fact`, `persistentStage`) resolve only
where `coa init` wrote those built-in types into `nodeTypes/`, which it does
when the base package is unavailable. `nodeMetadataSpec` also carries the
type's `config` defaults, which a hand-authored V1 node must copy — a run
template gates its DML on them.

**If no V2 type is available:**

1. `coa install -d <dir>` — hydrates declared packages. Safe, run it without
   asking, then re-check `nodeTypes/` and `.coa/cache/packages/*/nodeTypes/`.
   It hydrates only packages already declared under `packages/` and otherwise
   prints "No packages to install."; `coa init` writes that declaration, so if
   `packages/` is absent, re-running `coa init` (ask first) is the fix — never
   hand-create the declaration or any other shared config instead.
2. Still none — the base node types package may be unavailable (it exists only
   in the production registry; lower environments 404). Author the node as a V1
   `.yml` node and continue; that is supported, not a workaround. Do NOT create
   `nodeTypes/*` to fill the gap and do NOT stop.

**Custom node types** are only for a genuinely net-new type the user explicitly
asks for. ASK FIRST, then follow `coa describe node-types` — the authoring
manual for the format (folder layout, `definition.yml` fields,
`nodeMetadataSpec`, V2 template pattern) — and `coa describe schema nodeType`.
Modifying or upgrading a type existing nodes already depend on changes the
generated DDL/DML for *every* node of that type — always ask.

## Workflow (define → validate → dry-run → verify)

1. Confirm the change with the user (guardrail above).
2. `coa describe schema <type>` to confirm the exact shape; edit the file.
3. `coa validate -d <dir>` (add `--json`) — schemas + 15 graph scanners
   (storage locations, node types, missing types, duplicates).
4. `coa doctor -d <dir> [--profile <p>]` — verifies
   data.yml/locations.yml/workspace.yml, auth, and warehouse connectivity.
   `coa doctor --fix` can bootstrap a missing `workspace.yml` / update
   `.gitignore` — still a shared-file change, confirm with the user first.
5. For node-type/template edits, prove the contract holds on BOTH templates:
   `coa create -d <dir> --include "{ nodeType: \"<Name>\" }" --dry-run --verbose`
   and the same command with `coa run` (add `--json`) — confirm columns render
   and SQL is non-empty for affected nodes. `run.sql.j2` is where config
   gating lives, so a create dry-run alone never proves data would load.
6. `coa create`/`coa run` execute SQL DIRECTLY against the warehouse — LOCAL
   development, NOT deploy/publish. Cloud plan/deploy is separate (git push →
   Coalesce web UI/CI).
