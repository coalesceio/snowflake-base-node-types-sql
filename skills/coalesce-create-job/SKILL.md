---
name: coalesce-create-job
description: Create a Coalesce job that selects nodes to create/run, using the correct coa job schema (includeSelector/excludeSelector strings, integer-string id — not a steps array).
---
<!-- coalesce-node-managed: true -->

> **Prerequisite — load `coalesce-pipelines` first.** If you have not already
> loaded the `coalesce-pipelines` skill in this session, load it now, read its
> "Orient first" step, core `coa` loop, and Rules, then return here. This skill
> assumes those invariants (bare `@id`/`@nodeType` first lines, `fileVersion: 2`
> node types, one-node-at-a-time validate → dry-run → create loop) are already
> in context.

A **job** is a named orchestration definition that selects which nodes to operate on
via selector strings. It is **not** a list of steps. Treat `coa describe schema job`
as the source of truth.

> GUARDRAIL: Jobs live in shared workspace config (`jobs/`), like locations,
> workspaces, environments, macros, and `data.yml`. Creating or editing a job is
> **ASK FIRST**, not free-to-edit. If the user did not explicitly ask for a job,
> confirm before writing one. (`coa describe workflow` → "Ask before doing".)

## Job schema (`coa describe schema job`)
View job defintion via `coa describe`. Which nodes are included in a job are defined 
by selectors, so view those rules as well with `coa describe selectors`

## Procedure

1. Decide the selector(s). Confirm what they resolve to with read-only coa commands:
   ```bash
   coa create -d <dir> --list-nodes                                 # list available nodes/IDs
   coa create -d <dir> --include "<selector>" --dry-run             # preview matched nodes
   coa create -d <dir> --include "<selector>" --dry-run --verbose   # also show generated SQL
   coa run    -d <dir> --include "<selector>" --dry-run --verbose   # confirm the DML renders too
   ```
   Check the run dry-run, not just the create one: a node whose `config` lacks
   its node type's defaults renders ZERO run SQL, so a job can select it and
   still load no data.
2. Pick the next free integer `id` (string form, e.g. `"2"`) — do not reuse an
   existing job id and do not use a UUID.
3. Write `jobs/<JOB_NAME>.yml` with the fields above.
4. Validate the schema and scan for problems:
   ```bash
   coa validate -d <dir>
   coa validate -d <dir> --json     # machine-readable
   ```
   Fix any reported errors and re-validate.

A job only **selects** nodes; running it locally is just `coa create` / `coa run`
with the job's selector against the warehouse (local development, not a deploy).
Cloud plan/deploy is a separate process (git push → Coalesce web UI / CI).
