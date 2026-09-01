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

Once `data.yml` declares a platform, the app writes that platform's default node types into
`nodeTypes/`. Source nodes are always V1 (`.yml`). For transformation nodes, use V2 (`.sql`) when a
V2 node type (`fileVersion: 2`) exists in `nodeTypes/` for the type; otherwise author them as V1
(`.yml`). Run `coa describe sql-format` for both file shapes. Verify with `coa validate`,
`coa plan`, and `coa run`.

The `Source` node type is built in and never lives in `nodeTypes/` — `coa sources add` output
resolves to it automatically. Do not author a `Source` definition; the built-in always wins.
<!-- coalesce:agent-guide:end -->
