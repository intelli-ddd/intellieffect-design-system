#!/usr/bin/env bash
#
# codex-dsp.sh — Codex CLI helper for intellieffect-design-system DSP catalog
#
# 사용법:
#   codex-dsp.sh <dsp-slug> "<task description>"
#
# 예시:
#   codex-dsp.sh web/fintech-saas "Next.js 14 fintech hero. 파일 app/page.tsx + _hero.tsx"
#   codex-dsp.sh mobile/wellness-app "iOS Health 데이터 통합 화면. SwiftUI"
#   codex-dsp.sh web/real-estate-kr "분양 사이트 hero. 단지명 '리버포레스트'"
#
# 동작:
#   1. Repo의 DSP 파일 verbatim cat
#   2. Task description 결합
#   3. Codex CLI에 stdin 전달
#
# Prerequisite:
#   - `codex` CLI 설치 (https://github.com/openai/codex)
#   - 본 repo가 `~/intellieffect-design-system/` 또는 환경변수 `INTELLIEFFECT_DESIGN_ROOT` 위치
#
set -euo pipefail

# Repo location resolve
REPO_DIR="${INTELLIEFFECT_DESIGN_ROOT:-$HOME/intellieffect-design-system}"

if [ ! -d "$REPO_DIR/prompts/design" ]; then
  # script 위치에서 resolve 시도
  REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi

# Args
if [ $# -lt 2 ]; then
  cat <<USAGE
Usage: $(basename "$0") <dsp-slug> "<task description>"

Examples:
  $(basename "$0") web/fintech-saas "Next.js 14 fintech hero. app/page.tsx"
  $(basename "$0") mobile/wellness-app "Calm 톤 onboarding screen"
  $(basename "$0") web/real-estate-kr "한국 분양 사이트, 단지명 '리버포레스트'"

Available DSP catalog:
$(find "$REPO_DIR/prompts/design" -name '*.md' -not -name '_*' 2>/dev/null | \
  sed "s|$REPO_DIR/prompts/design/||" | sed 's|\.md$||' | sort | sed 's|^|  - |')

Repo location: $REPO_DIR
Override with: INTELLIEFFECT_DESIGN_ROOT=/path/to/repo $(basename "$0") ...
USAGE
  exit 1
fi

DSP_SLUG="$1"
TASK_DESC="$2"
DSP_FILE="$REPO_DIR/prompts/design/${DSP_SLUG}.md"

if [ ! -f "$DSP_FILE" ]; then
  echo "ERROR: DSP not found at $DSP_FILE" >&2
  echo "" >&2
  echo "Available:" >&2
  find "$REPO_DIR/prompts/design" -name '*.md' -not -name '_*' 2>/dev/null | \
    sed "s|$REPO_DIR/prompts/design/||" | sed 's|\.md$||' | sort | sed 's|^|  |' >&2
  exit 1
fi

# Check codex CLI installed
if ! command -v codex >/dev/null 2>&1; then
  echo "ERROR: 'codex' command not found" >&2
  echo "Install: https://github.com/openai/codex" >&2
  exit 1
fi

# Compose prompt + pipe to codex
PROMPT="다음 Design System Prompt (DSP) 를 verbatim 적용해서 결과물을 만들어줘.
이 DSP의 모든 token (color hex, typography family, radius, shadow stack) 한 글자도 변경 금지.
DSP의 'Banned patterns' 섹션을 코드 생성 전 mental grep, 매칭되면 reject.
Single-shot 금지 — 코드 작성 후 결과물에 대한 self-critique 1라운드 이상.

==================== DSP START (verbatim) ====================
$(cat "$DSP_FILE")
==================== DSP END ====================

# TASK
$TASK_DESC

# OUTPUT
- 완성된 파일 (full content)
- DSP token compliance 보고 (Y/N + 어디 사용)
- 적용한 Banned patterns 회피 항목 명시"

echo "→ Sending DSP \`$DSP_SLUG\` + task to codex..."
echo "  DSP: $DSP_FILE ($(wc -l < "$DSP_FILE" | tr -d ' ') lines)"
echo "  Task: $TASK_DESC"
echo ""

# Send to codex (stdin)
echo "$PROMPT" | codex
