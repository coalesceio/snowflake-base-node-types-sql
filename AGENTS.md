<!-- coalesce:agent-guide:start (managed by Coalesce Desktop — edits inside are overwritten) -->
# Coalesce Transform workspace

Author and run this pipeline with the `coa` CLI. Nodes are `<location>-<name>.sql` / `.yml`
files under `nodes/`; `data.yml` marks the workspace root.

## Running `coa`

When Coalesce Desktop is running it publishes `~/.coalesce/desktop/agent.json`. Prefer that
bundled coa over any `coa` on your PATH so your CLI build matches the app:

- Run coa as `coa.runInvocation` (`[nodePath, coaEntry]`) + your args, with every key in
  `coa.env` applied (it sets `ELECTRON_RUN_AS_NODE=1`). This works against ANY workspace — run
  it from this folder, or pass `--dir` pointed here.
- `serving` is the one workspace the app is showing live. If `serving.workspaceDir` is this
  folder, your edits appear in the app immediately (`serving.url`); if it's another folder your
  coa commands still work — they just won't reflect in the UI until the app is focused here.

Shortcut: the app writes an executable shim next to that file — run `~/.coalesce/desktop/coa <args>`
(Windows: `coa.cmd`) instead of the full runInvocation.

If the file is absent, use `coa` from your PATH. Prefer `--json` output; `coa --help` lists commands.

## Credentials and profiles

Warehouse credentials live in `~/.coa/config` as named profiles. The profile this workspace
runs against is the `profile:` key in its `workspace.yml`.

- Inspect and switch with `coa profile list`, `coa profile show`, `coa profile use`, and
  `coa profile create` — all support `--format json`.
- Never hand-edit `~/.coa/config`; the `coa profile` commands own its shape.
- Creating or changing credentials is the user's call — ask before you run `coa profile create`,
  and ask them for the values rather than guessing.

## Authoring nodes

Before authoring, check the available node types on disk: workspace types in `nodeTypes/` and
installed package types in `.coa/cache/packages/<alias>/nodeTypes/` (derived and read-only —
`coa install` regenerates it; use the id in each materialized definition.yml).
Source nodes are always V1 (`.yml`). For every other node, author V2 (`.sql`) when a `fileVersion: 2`
node type exists for the target node type — normally from the platform's base node types package,
which `coa init` installs and `coa install` hydrates; otherwise author V1 (`.yml`). The node type's
`fileVersion` decides this, never the platform. Both formats are supported — V1 is not a workaround.
Do not create node types. Run `coa describe sql-format` for both file shapes. Verify with
`coa validate`, `coa plan`, and `coa run`.

The `Source` node type is built in and never lives in `nodeTypes/` — `coa sources add` output
resolves to it automatically. Do not author a `Source` definition; the built-in always wins.
<!-- coalesce:agent-guide:end -->
