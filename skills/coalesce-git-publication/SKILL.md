---
name: coalesce-git-publication
description: Use for Git operations in a Coalesce workspace — branching, staging, committing, and pushing validated pipeline work so it can be planned and deployed from the Coalesce cloud. Push only with explicit user approval.
---
<!-- coalesce-node-managed: true -->

# Git Publication

Scope: Git operations — branch management, staging, committing, and pushing
changes.

## How work reaches the cloud

- `coa create` / `coa run` are NOT publication. They execute SQL directly
  against the warehouse for local development and iterative testing.
- Committing locally and pushing the branch IS how work reaches the cloud.
  The Coalesce cloud plan/deploy process (web UI or CI) diffs the pushed Git
  state against the deployed environment, then deploys. That is a separate
  process you do not run from here.
- So: validate and verify with `coa` locally, then commit + push so the
  changes are available to plan/deploy. Never call `coa create`/`coa run` a
  "deploy" or "publish", and never assume a push touches the warehouse.

## Allowed operations

- Create branches (suggested naming: `agent/<task-slug>-<timestamp>`).
- Switch branches.
- Stage files (`git add` with explicit paths).
- Commit with descriptive messages (what changed and why).
- View diff and log.
- Push to remote — ONLY when explicitly approved.

## Constraints

- NEVER force-push.
- NEVER push to main/master directly. Always use a branch.
- Stage only the files intentionally modified for the task (typically
  `nodes/*.sql`, `nodes/*.yml`, and related workspace config the user
  requested). Use explicit paths, not `git add -A` — the repo's `.gitignore`
  is coa-managed (`coa init` scaffolds it, `coa doctor --fix` updates it), and
  explicit paths keep generated/ignored artifacts out of the commit.
- Files marked `coalesce-node-managed` (e.g. a generated `.claude/CLAUDE.md`
  or managed skills) are tool-managed; do NOT stage or commit them unless the
  user explicitly asks.
- If the working tree contains changes to shared config the user did NOT
  request (`data.yml`, `locations.yml`, `workspace.yml`, `jobs/*`, `macros/*`,
  `nodeTypes/*`, or a bumped `fileVersion`), do NOT silently fold them into
  the commit. Surface them and confirm before staging — these are shared and
  can silently break unrelated nodes.

## Workflow

1. Confirm the work is validated and verified locally (`coa validate`, then
   the create/run/verify loop) before publishing.
2. Check `git status` and create or switch to the task branch.
3. Stage only the intended files (explicit paths).
4. Commit with a clear message.
5. Push only when the user has approved it.
6. Report the commit hash, branch, and changed-file summary. If pushed, note
   that cloud plan/deploy is the next (separate) step.
