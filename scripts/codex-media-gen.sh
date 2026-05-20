#!/usr/bin/env bash
# scripts/codex-media-gen.sh — DSP media prompt → image generation
#
# Workflow:
#   1. Parse named <!-- media-prompt: name=<asset> ... --> marker from DSP markdown
#   2. Extract following prompt body until next marker / heading
#   3. POST to OpenAI Images API (gpt-image-1, b64_json) — or codex exec wrapper
#   4. Decode + save PNG to --output path
#
# Usage:
#   ./codex-media-gen.sh \
#       --dsp agency-portfolio \
#       --prompt cover-01 \
#       --output ../distinctive-ui-test/public/agency/cover-01.png \
#       [--size 1536x1024] [--quality high] [--provider gpt-image-1]
#
# Env:
#   OPENAI_API_KEY    required for direct API call
#   CODEX_EXEC=1      if set, route through `codex exec` (Codex CLI wrapper)
#
# Dependencies: bash 4+, curl, jq, base64 (BSD or GNU). awk for marker parsing.
#
# Notes:
#   - Video prompts (Veo3 / Sora) are NOT auto-generated. They are markdown-only;
#     this script will skip them with an explicit message.
#   - Plugin DSPs live at $DSP_ROOT — defaults to repo's prompts/design/<bucket>/<slug>.md.

set -euo pipefail

# ---------------------------------------------------------------------------
# Config + arg parsing
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DSP_ROOT="${DSP_ROOT:-$SCRIPT_DIR/../prompts/design}"

DSP_SLUG=""
PROMPT_NAME=""
OUTPUT=""
SIZE="1536x1024"
QUALITY="high"
PROVIDER="gpt-image-1"

usage() {
  sed -n '2,30p' "$0" | sed 's/^# \{0,1\}//'
  exit "${1:-0}"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dsp)      DSP_SLUG="$2"; shift 2 ;;
    --prompt)   PROMPT_NAME="$2"; shift 2 ;;
    --output)   OUTPUT="$2"; shift 2 ;;
    --size)     SIZE="$2"; shift 2 ;;
    --quality)  QUALITY="$2"; shift 2 ;;
    --provider) PROVIDER="$2"; shift 2 ;;
    -h|--help)  usage 0 ;;
    *)          echo "Unknown arg: $1" >&2; usage 1 ;;
  esac
done

[[ -z "$DSP_SLUG"     ]] && { echo "Missing --dsp" >&2; usage 1; }
[[ -z "$PROMPT_NAME"  ]] && { echo "Missing --prompt" >&2; usage 1; }
[[ -z "$OUTPUT"       ]] && { echo "Missing --output" >&2; usage 1; }

# ---------------------------------------------------------------------------
# Locate DSP file (web/ or mobile/ bucket)
# ---------------------------------------------------------------------------
DSP_FILE=""
for bucket in web mobile; do
  candidate="$DSP_ROOT/$bucket/${DSP_SLUG}.md"
  if [[ -f "$candidate" ]]; then
    DSP_FILE="$candidate"
    break
  fi
done

if [[ -z "$DSP_FILE" ]]; then
  echo "DSP not found: $DSP_SLUG (searched $DSP_ROOT/{web,mobile}/${DSP_SLUG}.md)" >&2
  exit 2
fi

# ---------------------------------------------------------------------------
# Extract prompt body by name marker
#
# Marker format (verbatim):
#   <!-- media-prompt: name=cover-01 type=image preset=cover-landscape provider=gpt-image-1 -->
#
# Body = lines after marker until next `<!-- media-prompt:` OR next `## ` heading
#        OR `---` separator.
# ---------------------------------------------------------------------------
PROMPT_BODY=$(awk -v target="name=${PROMPT_NAME}" '
  BEGIN { capture=0 }
  /<!-- media-prompt:/ {
    if (capture) { exit }
    if (index($0, target) > 0) {
      capture=1
      next
    }
  }
  /^#+ / { if (capture) exit }
  /^---$/ { if (capture) exit }
  { if (capture) print }
' "$DSP_FILE")

# Strip leading/trailing blank lines
PROMPT_BODY=$(printf '%s' "$PROMPT_BODY" | awk '
  NF { if (!started) started=1; lastNF=NR }
  { if (started) lines[NR]=$0 }
  END { for (i=1; i<=lastNF; i++) if (i in lines) print lines[i] }
')

if [[ -z "$PROMPT_BODY" ]]; then
  echo "Prompt '${PROMPT_NAME}' not found in $DSP_FILE" >&2
  echo "Available prompts in DSP:" >&2
  grep -E "<!-- media-prompt: name=" "$DSP_FILE" >&2 || echo "  (none)" >&2
  exit 3
fi

# Detect type from marker (image vs video)
PROMPT_TYPE=$(grep -E "<!-- media-prompt: name=${PROMPT_NAME}" "$DSP_FILE" | head -1 | sed -nE 's/.*type=([a-z]+).*/\1/p')
PROMPT_TYPE="${PROMPT_TYPE:-image}"

if [[ "$PROMPT_TYPE" == "video" ]]; then
  echo "✗ Prompt '${PROMPT_NAME}' is type=video — auto-generation not supported in v1.8.0." >&2
  echo "  Copy the following prompt to Veo 3 / Sora / Runway manually:" >&2
  echo "" >&2
  echo "$PROMPT_BODY" >&2
  exit 10
fi

# ---------------------------------------------------------------------------
# Image generation — OpenAI Images API (gpt-image-1)
# ---------------------------------------------------------------------------
if [[ "$PROVIDER" != "gpt-image-1" ]]; then
  echo "✗ Provider '$PROVIDER' not supported by this script (only gpt-image-1)." >&2
  echo "  For Midjourney v7: copy prompt manually with '--ar 16:9 --v 7 --style raw'." >&2
  echo "" >&2
  echo "$PROMPT_BODY" >&2
  exit 11
fi

if [[ -z "${OPENAI_API_KEY:-}" ]]; then
  echo "OPENAI_API_KEY not set." >&2
  exit 4
fi

# Ensure output dir
mkdir -p "$(dirname "$OUTPUT")"

# Build request body
REQUEST_BODY=$(jq -n \
  --arg model "$PROVIDER" \
  --arg prompt "$PROMPT_BODY" \
  --arg size "$SIZE" \
  --arg quality "$QUALITY" \
  '{
    model: $model,
    prompt: $prompt,
    size: $size,
    quality: $quality,
    n: 1,
    output_format: "png"
  }')

echo "→ Generating: $DSP_SLUG / $PROMPT_NAME ($SIZE, $QUALITY) → $OUTPUT"

# Optional: route through codex exec for audit trail
if [[ "${CODEX_EXEC:-0}" == "1" ]] && command -v codex >/dev/null 2>&1; then
  # codex exec wraps a shell command — useful for prompt logging / audit
  CODEX_CMD="curl -sS -X POST 'https://api.openai.com/v1/images/generations' \
    -H 'Authorization: Bearer \$OPENAI_API_KEY' \
    -H 'Content-Type: application/json' \
    -d @-"
  RESPONSE=$(echo "$REQUEST_BODY" | codex exec -- bash -c "$CODEX_CMD")
else
  RESPONSE=$(curl -sS -X POST "https://api.openai.com/v1/images/generations" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$REQUEST_BODY")
fi

# Parse response — gpt-image-1 returns b64_json
B64=$(echo "$RESPONSE" | jq -r '.data[0].b64_json // empty')

if [[ -z "$B64" ]]; then
  echo "✗ API error or empty response:" >&2
  echo "$RESPONSE" | jq . >&2
  exit 5
fi

# Decode + save (cross-platform base64 — BSD on macOS, GNU on Linux)
if base64 --help 2>&1 | grep -q "GNU"; then
  echo "$B64" | base64 -d > "$OUTPUT"
else
  echo "$B64" | base64 -D > "$OUTPUT"
fi

SIZE_BYTES=$(stat -f%z "$OUTPUT" 2>/dev/null || stat -c%s "$OUTPUT")
echo "✓ Saved $OUTPUT ($SIZE_BYTES bytes)"
