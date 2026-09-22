#!/usr/bin/env bash
# Blocks Devin from editing sensitive files. Exit 2 = block.
INPUT=$(cat)
FILE_PATH=$(printf '%s' "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // empty')
for pattern in ".env" ".env.local" ".env.production" "package-lock.json"; do
  if [[ "$FILE_PATH" == *"$pattern"* ]]; then
    printf 'Blocked: %s matches protected pattern "%s"\n' "$FILE_PATH" "$pattern" >&2
    exit 2
  fi
done
exit 0
