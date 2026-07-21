#!/usr/bin/env bash
set -euo pipefail

# detect-agents.sh — Auto-detect AI coding agents installed on system
# Part of deep-mind-skill by vtino17

detect_agents() {
  local agents=()

  # Claude Code
  if [ -d "$HOME/.claude" ] || command -v claude &>/dev/null; then
    agents+=("claude:Claude Code:$HOME/.claude/skills:$HOME/.claude")
  fi

  # Cursor
  if [ -d "$HOME/.cursor" ] || [ -d "$HOME/.config/cursor" ]; then
    local cursor_dir="$HOME/.cursor"
    [ -d "$HOME/.config/cursor" ] && cursor_dir="$HOME/.config/cursor"
    agents+=("cursor:Cursor:$cursor_dir/skills:$cursor_dir")
  fi

  # Windsurf
  if [ -d "$HOME/.windsurf" ] || [ -d "$HOME/.config/windsurf" ]; then
    local ws_dir="$HOME/.windsurf"
    [ -d "$HOME/.config/windsurf" ] && ws_dir="$HOME/.config/windsurf"
    agents+=("windsurf:Windsurf:$ws_dir/skills:$ws_dir")
  fi

  # GitHub Copilot CLI
  if command -v gh &>/dev/null && gh copilot --version &>/dev/null 2>&1; then
    agents+=("copilot:GitHub Copilot CLI:$HOME/.copilot/skills:$HOME/.copilot")
  fi

  # Codex CLI
  if [ -d "$HOME/.codex" ] || command -v codex &>/dev/null; then
    agents+=("codex:Codex CLI:$HOME/.codex/skills:$HOME/.codex")
  fi

  # Cline (VS Code extension)
  if [ -d "$HOME/.config/Code/User/globalStorage/saoudrizwan.claude-dev" ] || \
     [ -d "$HOME/.vscode/extensions/saoudrizwan.claude-dev" ]; then
    agents+=("cline:Cline:$HOME/.config/cline/skills:$HOME/.config/cline")
  fi

  # Aider
  if command -v aider &>/dev/null; then
    agents+=("aider:Aider:$HOME/.aider/skills:$HOME/.aider")
  fi

  # Continue (VS Code extension)
  if [ -d "$HOME/.continue" ] || [ -d "$HOME/.config/continue" ]; then
    local cont_dir="$HOME/.continue"
    [ -d "$HOME/.config/continue" ] && cont_dir="$HOME/.config/continue"
    agents+=("continue:Continue:$cont_dir/skills:$cont_dir")
  fi

  # Roo Code
  if [ -d "$HOME/.roocode" ] || [ -d "$HOME/.config/roocode" ]; then
    agents+=("roocode:Roo Code:$HOME/.roocode/skills:$HOME/.roocode")
  fi

  # Augment
  if [ -d "$HOME/.augment" ] || command -v augment &>/dev/null; then
    agents+=("augment:Augment:$HOME/.augment/skills:$HOME/.augment")
  fi

  # OpenCode
  if [ -d "$HOME/.config/opencode" ] || [ -d "$HOME/.opencode" ]; then
    local oc_dir="$HOME/.config/opencode"
    [ -d "$HOME/.opencode" ] && oc_dir="$HOME/.opencode"
    agents+=("opencode:OpenCode:$oc_dir/skills:$oc_dir")
  fi

  printf '%s\n' "${agents[@]}"
}

# If run directly (not sourced), print detected agents
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "🔍 Scanning for AI agents..."
  echo ""
  detected=$(detect_agents)
  if [ -z "$detected" ]; then
    echo "  ❌ No AI coding agents detected on this system."
    exit 1
  fi
  echo "$detected" | while IFS=: read -r key name path _; do
    echo "  ✅ $name"
  done
  echo ""
  echo "Total: $(echo "$detected" | wc -l) agent(s) found."
fi
