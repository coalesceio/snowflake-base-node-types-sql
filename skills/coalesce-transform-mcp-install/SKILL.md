---
name: coalesce-transform-mcp-install
description: Use when installing, connecting, or troubleshooting the hosted Coalesce Transform MCP server in an MCP client (Claude Code, Claude Desktop, Cursor, VS Code, Cortex Code) — endpoint URL, access token handling, registration, and verification. Not for coa CLI auth (use coalesce-cloud-api).
---
<!-- coalesce-node-managed: true -->

# Install the Coalesce Transform MCP

Scope: registering the hosted Coalesce Transform MCP server (HTTP transport)
in an MCP client so agents can query Coalesce projects, environments, and
runs. This is client configuration only — it does not touch the workspace
repo or the warehouse. For `coa` CLI credentials and `~/.coa/config`, use
coalesce-cloud-api instead.

Source of truth:
[MCP quickstart](https://docs.coalesce.io/docs/coalesce-ai/mcp/mcp-quickstart)
and the per-client guides linked below. If this skill and the docs disagree,
the docs win.

## What you need

- **Endpoint** — `https://<app-host>/api/v1/mcp`, where `<app-host>` is the
  host the user signs into (e.g. `app.coalescesoftware.io`, or a custom
  subdomain like `mycompany.app.eu.coalescesoftware.io`). Tenancy is
  resolved from the token, but use the sign-in host so errors are obvious.
- **Access token** — generated in the Coalesce App: **Deploy tab →
  Generate Access Token**. This is a browser step; you cannot do it.
  Ask the user to generate one and provide it (or export it as an env var —
  preferred, see below). It is the same token `coa` and the REST API use,
  so a user with a working `~/.coa/config` already has one; with their
  permission you may reuse the `token` value from that file rather than
  asking them to generate another.

## Token handling — read before running anything

- NEVER echo, print, or repeat the token back in conversation or logs.
- NEVER write a literal token into a file that is committed (`.mcp.json`
  at repo root is usually committed — use env-var interpolation there).
- Prefer an environment variable end to end: have the user
  `export COALESCE_ACCESS_TOKEN=...` themselves, then reference
  `$COALESCE_ACCESS_TOKEN` / `${COALESCE_ACCESS_TOKEN}` in commands and
  config so the secret never appears in shell history or the transcript.
- Registering an MCP server stores the token in client config
  (e.g. `~/.claude.json`). That is expected, but say so, and ASK FIRST
  before writing any config file.

## Claude Code

Preferred — user scope, token via env var (single quotes so the shell does
not expand it into history; Claude Code expands `${...}` at connect time):

```sh
claude mcp add --transport http --scope user coalesce-transform \
  "https://<app-host>/api/v1/mcp" \
  --header 'Authorization: Bearer ${COALESCE_ACCESS_TOKEN}'
```

Or project-shared: commit a `.mcp.json` at the repo root with env-var
interpolation, NEVER a literal token:

```json
{
  "mcpServers": {
    "coalesce-transform": {
      "type": "http",
      "url": "https://<app-host>/api/v1/mcp",
      "headers": {
        "Authorization": "Bearer ${COALESCE_ACCESS_TOKEN}"
      }
    }
  }
}
```

A server added mid-session is NOT available until the session reconnects.
Tell the user to run `/mcp` (or restart the session) before verifying —
do not report failure just because the tools are not visible yet. And
`${...}` is expanded from the environment Claude Code was LAUNCHED from:
if the user exported the token after starting the session, `/mcp` alone
will not pick it up — they must restart `claude` from a shell that has
the variable set (e.g. after adding the export to their shell profile).

## Other clients

Same endpoint and header; follow the client guide for where config lives:

- [Claude Desktop / Claude Code](https://docs.coalesce.io/docs/coalesce-ai/mcp/integrate-mcp-claude)
  — Desktop: Settings → Developer → Edit Config, add the `mcpServers`
  entry, then fully quit and reopen.
- [Cursor](https://docs.coalesce.io/docs/coalesce-ai/mcp/integrate-mcp-cursor)
- [VS Code](https://docs.coalesce.io/docs/coalesce-ai/mcp/integrate-mcp-vscode)
- [Snowflake Cortex Code](https://docs.coalesce.io/docs/coalesce-ai/mcp/integrate-mcp-cortex)

## Verify

After reconnect/restart, ask: "List Coalesce projects in this
organization." Success returns the org's Projects. On an auth error,
re-check the token (regenerate if in doubt) and confirm the URL host
matches where the user signs in. Available tools:
[MCP tool reference](https://docs.coalesce.io/docs/coalesce-ai/mcp/mcp-available-tools).

## Approval gates

- Without asking: reading docs, composing the command/config for review,
  and the post-install verification query (read-only cloud call).
- ASK FIRST: writing or editing any client config (`claude mcp add`,
  `.mcp.json`, `claude_desktop_config.json`, …), reading a token out of
  `~/.coa/config`, and committing `.mcp.json` to the repo.
- NEVER: generate/scrape tokens from the browser yourself, place a literal
  token in a committed file, or paste a token into chat output.
