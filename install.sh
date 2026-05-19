#!/usr/bin/env bash
#
# intellieffect-design-system installer
# ~/.claude/agents/designer.md → repo's agents/designer.md (symlink)
# ~/.claude/prompts/design → repo's prompts/design (symlink)
#
# Existing files at those paths are preserved with .removed_<timestamp> suffix
# (per IntelliEffect file-safety rule: mv-not-rm).

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

echo "→ intellieffect-design-system install"
echo "  source: $REPO_DIR"
echo ""

# 1. ~/.claude/agents/designer.md
AGENTS_DIR="$HOME/.claude/agents"
DESIGNER_LINK="$AGENTS_DIR/designer.md"
mkdir -p "$AGENTS_DIR"

if [ -e "$DESIGNER_LINK" ] && [ ! -L "$DESIGNER_LINK" ]; then
  BACKUP="$DESIGNER_LINK.removed_$TIMESTAMP"
  echo "  ⚠ existing file detected → $BACKUP"
  mv "$DESIGNER_LINK" "$BACKUP"
elif [ -L "$DESIGNER_LINK" ]; then
  rm "$DESIGNER_LINK"
fi

ln -s "$REPO_DIR/agents/designer.md" "$DESIGNER_LINK"
echo "  ✓ designer agent → $DESIGNER_LINK"

# 2. ~/.claude/prompts/design
PROMPTS_DIR="$HOME/.claude/prompts"
DESIGN_LINK="$PROMPTS_DIR/design"
mkdir -p "$PROMPTS_DIR"

if [ -e "$DESIGN_LINK" ] && [ ! -L "$DESIGN_LINK" ]; then
  BACKUP="$DESIGN_LINK.removed_$TIMESTAMP"
  echo "  ⚠ existing directory detected → $BACKUP"
  mv "$DESIGN_LINK" "$BACKUP"
elif [ -L "$DESIGN_LINK" ]; then
  rm "$DESIGN_LINK"
fi

ln -s "$REPO_DIR/prompts/design" "$DESIGN_LINK"
echo "  ✓ DSP library → $DESIGN_LINK"

# 3. Inventory
echo ""
echo "→ installed assets"
echo "  • 1 agent: designer (delegate UI tasks with DSP spec)"
echo "  • $(find "$REPO_DIR/prompts/design/web" -name '*.md' -not -name '_*' 2>/dev/null | wc -l | tr -d ' ') web DSP"
echo "  • $(find "$REPO_DIR/prompts/design/mobile" -name '*.md' -not -name '_*' 2>/dev/null | wc -l | tr -d ' ') mobile DSP"
echo "  • 1 template (_template.md)"
echo ""
echo "→ next steps"
echo "  • restart Claude Code session to register designer agent"
echo "  • call via Task tool: subagent_type='designer'"
echo "  • spec body: 'DSP: @~/.claude/prompts/design/<web|mobile>/<slug>.md verbatim'"
echo ""
echo "→ to update later"
echo "  cd $REPO_DIR && git pull"
echo ""
echo "→ to add a new DSP"
echo "  cp $REPO_DIR/prompts/design/_template.md \\"
echo "     $REPO_DIR/prompts/design/<web|mobile>/<your-slug>.md"
echo "  # then fill in sections 1-4 (Design System / Layout / UI & Animation / Mandate)"
echo ""
echo "✓ install complete"
