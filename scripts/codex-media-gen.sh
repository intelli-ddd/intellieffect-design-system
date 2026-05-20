#!/usr/bin/env bash
# scripts/codex-media-gen.sh — DSP media prompt → image generation via Codex CLI
#
# Workflow:
#   1. Parse named <!-- media-prompt: name=<asset> ... --> marker from DSP markdown
#   2. Extract following prompt body until next marker / heading / --- separator
#   3. Invoke `codex exec` with the prompt — Codex CLI's imagegen skill handles
#      OAuth auth + Images API + saves PNG to ~/.codex/generated_images/<session>/
#   4. Locate the newly-created PNG via mtime marker, copy to --output path
#
# Auth:
#   No OPENAI_API_KEY required. Codex CLI uses its own OAuth credentials stored
#   at ~/.codex/auth.json (manage via `codex login` / `codex logout`).
#
# Usage:
#   ./codex-media-gen.sh \
#       --dsp agency-portfolio \
#       --prompt cover-01 \
#       --output ../distinctive-ui-test/public/agency/cover-01.png \
#       [--size 1536x1024] [--quality high]
#
# Dependencies: bash 4+, codex CLI (0.131+), awk, find, cp, stat
#
# Notes:
#   - Video prompts (type=video) are NOT auto-generated — script echoes the
#     prompt and exits with code 10 for manual hand-off to Veo 3 / Sora / Runway.
#   - For Midjourney v7, set --provider midjourney to echo prompt with
#     suggested `--ar` flag suffix.

set -euo pipefail

# ---------------------------------------------------------------------------
# Config + arg parsing
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DSP_ROOT="${DSP_ROOT:-$SCRIPT_DIR/../prompts/design}"
CODEX_IMAGES_DIR="${CODEX_IMAGES_DIR:-$HOME/.codex/generated_images}"

DSP_SLUG=""
PROMPT_NAME=""
OUTPUT=""
SIZE="1536x1024"
QUALITY="high"
PROVIDER="codex"
TIMEOUT_SEC="${TIMEOUT_SEC:-180}"

usage() {
  sed -n '2,32p' "$0" | sed 's/^# \{0,1\}//'
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
# Tool checks
# ---------------------------------------------------------------------------
if ! command -v codex >/dev/null 2>&1; then
  echo "✗ codex CLI not found. Install: brew install codex / npm i -g @openai/codex-cli" >&2
  exit 6
fi

if [[ ! -f "$HOME/.codex/auth.json" ]]; then
  echo "✗ Codex CLI not authenticated. Run: codex login" >&2
  exit 7
fi

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
# Marker format:
#   <!-- media-prompt: name=<asset> type=<image|video> preset=<...> provider=<...> -->
#
# Body = lines after marker until next marker / `#+` heading / `---` separator.
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
  echo "Available prompts:" >&2
  grep -E "^<!-- media-prompt: name=" "$DSP_FILE" >&2 || echo "  (none)" >&2
  exit 3
fi

# Detect type from marker
PROMPT_TYPE=$(grep -E "<!-- media-prompt: name=${PROMPT_NAME}" "$DSP_FILE" | head -1 | sed -nE 's/.*type=([a-z]+).*/\1/p')
PROMPT_TYPE="${PROMPT_TYPE:-image}"
PROMPT_PROVIDER_HINT=$(grep -E "<!-- media-prompt: name=${PROMPT_NAME}" "$DSP_FILE" | head -1 | sed -nE 's/.*provider=([a-z0-9-]+).*/\1/p')

# ---------------------------------------------------------------------------
# Manual hand-off paths (video / midjourney / non-codex providers)
# ---------------------------------------------------------------------------
if [[ "$PROMPT_TYPE" == "video" ]]; then
  echo "✗ Prompt '${PROMPT_NAME}' is type=video — auto-generation not supported." >&2
  echo "  Hand-off target (from DSP marker): ${PROMPT_PROVIDER_HINT:-veo3}" >&2
  echo "  Copy the prompt below to your video tool of choice:" >&2
  echo "" >&2
  echo "$PROMPT_BODY" >&2
  exit 10
fi

if [[ "$PROVIDER" == "midjourney" ]]; then
  echo "→ Midjourney v7 manual prompt — paste into Discord / web with suggested ar:" >&2
  echo "" >&2
  echo "$PROMPT_BODY" >&2
  echo "" >&2
  case "$SIZE" in
    1536x1024) AR="--ar 3:2" ;;
    1024x1536) AR="--ar 2:3" ;;
    1024x1024) AR="--ar 1:1" ;;
    *)         AR="--ar 16:9" ;;
  esac
  echo "$AR --v 7 --style raw --s 50" >&2
  exit 0
fi

if [[ "$PROVIDER" != "codex" ]]; then
  echo "✗ Unsupported --provider '$PROVIDER'. Use: codex (default) | midjourney" >&2
  exit 11
fi

# ---------------------------------------------------------------------------
# Image generation via Codex CLI (default path)
# ---------------------------------------------------------------------------
mkdir -p "$(dirname "$OUTPUT")"

# Build directive for Codex — instructs imagegen skill, suppresses follow-ups,
# requests path-only output for easier parsing.
CODEX_DIRECTIVE="Generate a single bitmap image using the imagegen skill. Do not ask clarifying questions, choose reasonable defaults if anything is ambiguous. Target size: ${SIZE}. Quality: ${QUALITY}. Save as PNG. After saving, output only the absolute path to the saved file on a single line — no commentary, no preamble.

Prompt:
${PROMPT_BODY}"

# Portable mkdir-based lock — serializes parallel invocations so the
# post-codex `find -newer marker` can reliably pick THIS invocation's file.
# Reason: multiple parallel codex exec sessions all write to
# ~/.codex/generated_images/<session-uuid>/. Without serialization,
# `find -newer marker | head -1` can pick another session's file.
# (macOS has no GNU flock by default; mkdir is atomic on every POSIX FS.)
mkdir -p "$CODEX_IMAGES_DIR"
LOCKDIR="${CODEX_IMAGES_DIR}/.codex-media-gen.lockdir"
LOCK_WAIT=0
while ! mkdir "$LOCKDIR" 2>/dev/null; do
  sleep 1
  LOCK_WAIT=$((LOCK_WAIT + 1))
  if [[ $LOCK_WAIT -ge $((TIMEOUT_SEC * 2)) ]]; then
    echo "✗ Lock timeout — another codex-media-gen.sh holding $LOCKDIR for >${LOCK_WAIT}s." >&2
    echo "  If stale, manually: rmdir $LOCKDIR" >&2
    exit 8
  fi
done

LOG="$(mktemp -t codex-media-gen-log-XXXXXX)"
MARKER="$(mktemp -t codex-media-gen-XXXXXX)"
trap 'rm -f "$LOG" "$MARKER"; rmdir "$LOCKDIR" 2>/dev/null || true' EXIT

echo "→ Generating: $DSP_SLUG / $PROMPT_NAME ($SIZE, $QUALITY) via codex exec" >&2
echo "  Output target: $OUTPUT" >&2

# Run codex exec — auth handled by Codex (OAuth via ~/.codex/auth.json)
set +e
if command -v timeout >/dev/null 2>&1; then
  timeout "$TIMEOUT_SEC" codex exec "$CODEX_DIRECTIVE" > "$LOG" 2>&1
  CODEX_EXIT=$?
else
  codex exec "$CODEX_DIRECTIVE" > "$LOG" 2>&1
  CODEX_EXIT=$?
fi
set -e

# Find newest png after marker — Codex stores images in
# ~/.codex/generated_images/<session-uuid>/ig_<hash>.png.
# Inside the lock, exactly one new file (this invocation's) should exist.
NEW_IMG=$(find "$CODEX_IMAGES_DIR" -name "ig_*.png" -newer "$MARKER" 2>/dev/null | head -1)

if [[ -z "$NEW_IMG" ]]; then
  echo "✗ Codex did not produce a new image (exit $CODEX_EXIT)." >&2
  echo "  Codex log tail:" >&2
  tail -30 "$LOG" >&2
  exit 5
fi

cp "$NEW_IMG" "$OUTPUT"
SIZE_BYTES=$(stat -f%z "$OUTPUT" 2>/dev/null || stat -c%s "$OUTPUT")
echo "✓ Saved $OUTPUT ($SIZE_BYTES bytes)"
echo "  Source: $NEW_IMG"
