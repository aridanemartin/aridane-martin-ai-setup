#!/usr/bin/env bash
# nan-usage — real-time NaN (nan.builders) token usage / quota reporter.
#
# Usage:
#   scripts/nan-usage.sh [--model <id-substring>] [--json] [--watch [SECONDS]]
#                        [--key <api-key>] [--base <url>]
#
# Key resolution order: $NAN_API_KEY, --key, then provider.nan.options.apiKey
# from ~/.config/opencode/opencode.jsonc (or opencode.json).
#
# The data comes from NaN's internal cloud API (https://cloud-api.nan.builders),
# the same endpoints the cloud.nan.builders dashboard polls. It is not part of
# the public OpenAI-compatible API documented at nan.builders/docs/api.
set -euo pipefail

BASE="${NAN_USAGE_API_BASE:-https://cloud-api.nan.builders}"
MODEL_FILTER=""
JSON=0
WATCH=0
WATCH_INTERVAL=30
KEY="${NAN_API_KEY:-}"

usage() {
  sed -n '2,13p' "$0" | sed 's/^# \{0,1\}//'
}

while [ $# -gt 0 ]; do
  case "$1" in
    --json) JSON=1; shift ;;
    --model) MODEL_FILTER="${2:-}"; shift 2 ;;
    --key) KEY="${2:-}"; shift 2 ;;
    --base) BASE="${2:-}"; shift 2 ;;
    --watch)
      WATCH=1
      if [[ "${2:-}" =~ ^[0-9]+$ ]]; then WATCH_INTERVAL="$2"; shift 2; else WATCH_INTERVAL=30; shift; fi
      ;;
    -h|--help) usage; exit 0 ;;
    *) echo "nan-usage: unknown argument: $1" >&2; usage >&2; exit 2 ;;
  esac
done

if [ -z "$KEY" ]; then
  KEY="$(python3 - <<'PY'
import json, os, re

def strip_jsonc(text):
    text = re.sub(r"/\*.*?\*/", "", text, flags=re.S)
    text = re.sub(r"(?m)(^|[^:])//.*$", r"\1", text)
    text = re.sub(r",(\s*[}\]])", r"\1", text)
    return text

for path in (
    os.path.expanduser("~/.config/opencode/opencode.jsonc"),
    os.path.expanduser("~/.config/opencode/opencode.json"),
):
    try:
        data = json.loads(strip_jsonc(open(path).read()))
        key = (data.get("provider", {}).get("nan", {}).get("options", {}) or {}).get("apiKey")
        if key:
            print(key)
            break
    except Exception:
        pass
PY
)"
fi

if [ -z "$KEY" ]; then
  echo "nan-usage: no API key found. Set NAN_API_KEY or add provider.nan.options.apiKey to ~/.config/opencode/opencode.jsonc" >&2
  exit 1
fi

fetch() {
  curl -fsS --max-time 15 "$BASE$1" -H "Authorization: Bearer $KEY"
}

render() {
  local quota metrics
  if ! quota="$(fetch /api/usage/quota)"; then
    echo "nan-usage: request failed: $BASE/api/usage/quota" >&2
    return 1
  fi
  metrics="$(fetch /api/metrics/usage 2>/dev/null || echo '')"

  QUOTA="$quota" METRICS="$metrics" MODEL_FILTER="$MODEL_FILTER" JSON="$JSON" python3 - <<'PY'
import json, os, sys
from datetime import datetime, timezone

quota = json.loads(os.environ["QUOTA"])
metrics_raw = os.environ.get("METRICS") or ""
metrics = json.loads(metrics_raw) if metrics_raw.strip() else {}
flt = (os.environ.get("MODEL_FILTER") or "").lower()
as_json = os.environ.get("JSON") == "1"


def human(n):
    try:
        n = float(n)
    except (TypeError, ValueError):
        return str(n)
    sign = "-" if n < 0 else ""
    n = abs(n)
    for unit in ("", "K", "M", "B", "T", "P"):
        if n < 1000:
            if unit == "":
                return f"{sign}{int(round(n))}"
            return f"{sign}{n:.1f}{unit}"
        n /= 1000
    return f"{sign}{n:.1f}E"


def pct(used, cap):
    try:
        return 100.0 * used / cap if cap else 0.0
    except Exception:
        return 0.0


def bar(percent, width=20):
    filled = max(0, min(width, int(round(percent / 100.0 * width))))
    return "\u2593" * filled + "\u2591" * (width - filled)


def reset_label(model):
    for key in ("periodEnd", "fullWindowEnd"):
        value = model.get(key)
        if value:
            return str(value)[:10]
    return "-"


def local_ts(iso):
    if not iso:
        return "?"
    try:
        dt = datetime.fromisoformat(str(iso).replace("Z", "+00:00"))
        return dt.astimezone().strftime("%Y-%m-%d %H:%M")
    except Exception:
        return str(iso)


models = quota.get("models", []) or []
if flt:
    models = [m for m in models if flt in str(m.get("model", "")).lower()]

models.sort(key=lambda m: pct(m.get("tokensUsed", 0), m.get("cap", 1)), reverse=True)

if as_json:
    print(json.dumps({"quota": quota, "metrics": metrics}, indent=2))
    sys.exit(0)

if not models:
    print("nan-usage: no matching models"
          + (f" for filter '{flt}'" if flt else "")
          + f" (available: {', '.join(str(m.get('model')) for m in (quota.get('models') or [])) or 'none'})")
    sys.exit(1)

period_start = quota.get("periodStart") or "?"
print()
print(f"  NaN usage  \u00b7  period {period_start} \u2192 {reset_label(models[0])}")
if models:
    updated = models[0].get("updatedAt")
    print(f"  updated {local_ts(updated)}   |   source: {os.environ.get('BASE', 'cloud-api.nan.builders')}")
print()
print(f"  {'MODEL':<20}{'USED':>10}{'CAP':>10}{'USED%':>8}   {'REMAINING':<26}{'RESETS':<12}")
print(f"  {'-'*20}{'-'*10}{'-'*10}{'-'*8}   {'-'*26}{'-'*12}")
for m in models:
    name = str(m.get("model", "?"))
    used = m.get("tokensUsed", 0)
    cap = m.get("cap", 0)
    remaining = m.get("remaining", cap - used)
    p = pct(used, cap)
    print(f"  {name:<20}{human(used):>10}{human(cap):>10}{p:>7.1f}%   {human(remaining):<8}{bar(p)}  {reset_label(m):<12}")

if metrics:
    print()
    print("  Recent activity")
    for label, key in (("last 24h", "last24h"), ("last 30d", "last30d"), ("month to date", "monthToDate"), ("all time", "allTime")):
        block = metrics.get(key) or {}
        total = block.get("totalTokens")
        if total is None:
            continue
        top = ""
        by = block.get("byModel") or []
        if by:
            top_model = max(by, key=lambda e: (e.get("inputTokens", 0) + e.get("outputTokens", 0)))
            top = f"  (top: {top_model.get('model')} {human(top_model.get('inputTokens', 0) + top_model.get('outputTokens', 0))})"
        print(f"    {label:<14}{human(total):>10} tokens{top}")
print()
PY
}

if [ "$WATCH" = "1" ]; then
  trap 'echo; exit 0' INT TERM
  while true; do
    clear 2>/dev/null || true
    render || true
    sleep "$WATCH_INTERVAL"
  done
else
  BASE="$BASE" render
fi
