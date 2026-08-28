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

## Authoring nodes

Run `coa describe node-types` before authoring V2 (`.sql`) nodes — they need a custom node type
definition under `nodeTypes/`, and a fresh workspace ships none. `coa describe` covers the file
layout and commands. Verify with `coa validate`, `coa plan`, and `coa run`.
<!-- coalesce:agent-guide:end -->
