#!/bin/bash
# Pre-warm the uv cache for the statistician MCP server so its first launch
# doesn't time out while downloading scipy/pandas/statsmodels.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

if ! command -v uvx >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# mcp<2: upstream imports mcp.server.fastmcp, which mcp 2.x removed.
uvx --with "mcp[cli]<2" \
  --from git+https://github.com/ypotheto/statistician-mcp \
  statistician-mcp --help >/dev/null
