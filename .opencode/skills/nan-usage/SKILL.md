---
name: nan-usage
description: Report real-time NaN (nan.builders) token usage, quota and remaining allowance for the configured API key. Use when the user asks how NaN usage is going, how many tokens are left, which models are near their cap, or about deepseek-v4-flash / glm / mimo / qwen quota on nan.builders.
license: MIT
metadata:
  author: aridane-martin
  version: "1.0"
  scope: global
---

# NaN Usage

Report real-time token usage and quota for a NaN (nan.builders) API key, straight from the same cloud API the platform dashboard uses.

## When to Use

- "How is my NaN usage going?", "how many tokens do I have left?", "am I close to the cap?"
- Questions about `deepseek-v4-flash`, `glm5.3`, `glm5.3-flash`, `mimo-v2.5` or `qwen3.8-flash` quota on nan.builders
- Deciding whether a long agent run will hit a monthly model cap
- Checking recent burn rate (last 24h / 30d) before starting something expensive

## When NOT to Use

- Reasoning about the OpenAI-compatible inference API itself (models, endpoints) — see the `find-docs` skill and nan.builders/docs
- Per-request token counts inside a single response — those come back in the response body
- Any non-NaN provider's usage (Codex, Claude, etc.)

## Workflow

### Step 1: Run the reporter

```bash
bash ~/.agents/skills/nan-usage/scripts/nan-usage.sh
```

Common variants:

```bash
# Only the deepseek model
bash ~/.agents/skills/nan-usage/scripts/nan-usage.sh --model deepseek

# Raw JSON (quota + metrics) for further processing
bash ~/.agents/skills/nan-usage/scripts/nan-usage.sh --json

# Live screen, refreshing every 30s (or pass a custom interval)
bash ~/.agents/skills/nan-usage/scripts/nan-usage.sh --watch 15
```

### Step 2: Summarize for the user

Lead with the model they care about (usually `deepseek-v4-flash`): used, cap, percentage, remaining and reset date. Mention anything above ~80% used. Add recent activity only when it is relevant (e.g. burn-rate questions).

### Step 3: If the key cannot be found

The script resolves the key in this order: `$NAN_API_KEY`, `--key`, then `provider.nan.options.apiKey` in `~/.config/opencode/opencode.jsonc`. If it fails, tell the user which of those to set — do **not** print the key itself.

## Quick Reference

| Task | Command |
|---|---|
| Full usage report | `nan-usage.sh` |
| Filter to one model | `nan-usage.sh --model deepseek` |
| JSON output | `nan-usage.sh --json` |
| Live refresh | `nan-usage.sh --watch [SECONDS]` |
| Override key/base | `nan-usage.sh --key sk-… --base https://cloud-api.nan.builders` |

## How It Works

The skill queries NaN's **internal** cloud API — the one `cloud.nan.builders` uses — with the API key as a Bearer token:

| Endpoint | Returns |
|---|---|
| `GET https://cloud-api.nan.builders/api/usage/quota` | Per-model `tokensUsed`, `cap`, `remaining`, `periodEnd`, `updatedAt` |
| `GET https://cloud-api.nan.builders/api/metrics/usage` | `last24h` / `last30d` / `monthToDate` / `allTime`, by model |
| `GET https://cloud-api.nan.builders/api/metrics/usage/sse` | Live SSE `usage_snapshot` events |

The public, documented inference API (`api.nan.builders/v1`, see nan.builders/docs/api) has **no** usage endpoint — token counts only appear inside each chat response.

## Notes

- This cloud API is **undocumented and internal**: it can change without notice. If it starts returning 401/404, verify the endpoint still exists (the dashboard is the source of truth) before assuming the key is wrong.
- **Orca's status bar cannot show NaN.** Orca's usage meters are a hardcoded roster (`claude`, `codex`, `gemini`, `opencode-go`, `kimi`, `minimax`, `grok`, `antigravity`) with no plugin, config key, CLI command, or agent hook to add a custom provider. `opencode-go` tracks OpenCode's own subscription, not the NaN key. That is why this is a skill instead of a native Orca provider.
- Quota `cap` is per model per billing period; `glm5.3` additionally has a rolling 4h window (`fullWindowTokens` / `fullWindowEnd`) and a billing-period allowance.
- Never echo, log or commit the API key.
