#!/usr/bin/env bash
set -euo pipefail

# ╔══════════════════════════════════════════════════════════════╗
# ║  deep-mind 🧠 — Critical Thinking Engine for AI Agents     ║
# ║  Interactive Installer (macOS / Linux / WSL)                ║
# ╚══════════════════════════════════════════════════════════════╝

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SRC="$SCRIPT_DIR/.claude/skills/deep-mind"

# ── Colors ──
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; NC='\033[0m' # No Color

banner() {
  echo -e "${CYAN}"
  echo '  ╔═══════════════════════════════════════════╗'
  echo '  ║       🧠 deep-mind — Installer            ║'
  echo '  ║  Critical Thinking Engine for AI Agents   ║'
  echo '  ╚═══════════════════════════════════════════╝'
  echo -e "${NC}"
}

# ── Source agent detector ──
source "$SCRIPT_DIR/detect-agents.sh"

# ── Detect agents ──
mapfile -t AGENTS < <(detect_agents 2>/dev/null || true)

print_menu() {
  echo ""
  echo -e "${YELLOW}Pilih AI Agent untuk dipasang skill ini:${NC}"
  echo ""
  for i in "${!AGENTS[@]}"; do
    local name="${AGENTS[$i]#*:}"
    name="${name%%:*}"
    echo "  [$((i+1))] ${selected[$i]:- } $name"
  done
  echo ""
}

install_skill() {
  local agent_key="$1"; local agent_name="$2"; local target_dir="$3"

  # Determine the correct skills subdirectory
  local install_path=""
  case "$agent_key" in
    claude)   install_path="$target_dir" ;;
    cursor)   install_path="$target_dir" ;;
    windsurf) install_path="$target_dir" ;;
    opencode) install_path="$target_dir" ;;
    copilot)  install_path="$target_dir/skills" ;;
    codex)    install_path="$target_dir" ;;
    cline)    install_path="$target_dir" ;;
    aider)    install_path="$target_dir" ;;
    continue) install_path="$target_dir" ;;
    roocode)  install_path="$target_dir" ;;
    augment)  install_path="$target_dir" ;;
    *)        install_path="$target_dir/skills" ;;
  esac

  mkdir -p "$install_path/deep-mind/references"
  
  # Copy files
  cp "$SKILL_SRC/SKILL.md" "$install_path/deep-mind/"
  cp -r "$SKILL_SRC/references/"* "$install_path/deep-mind/references/" 2>/dev/null || true
  
  echo -e "  ${GREEN}✅${NC} $agent_name → $install_path/deep-mind/"
}

# ── Uninstall ──
uninstall_skill() {
  local agent_key="$1"; local agent_name="$2"; local target_dir="$3"
  local install_path=""
  case "$agent_key" in
    claude)   install_path="$target_dir" ;;
    cursor)   install_path="$target_dir" ;;
    windsurf) install_path="$target_dir" ;;
    opencode) install_path="$target_dir" ;;
    copilot)  install_path="$target_dir/skills" ;;
    codex)    install_path="$target_dir" ;;
    cline)    install_path="$target_dir" ;;
    aider)    install_path="$target_dir" ;;
    continue) install_path="$target_dir" ;;
    roocode)  install_path="$target_dir" ;;
    augment)  install_path="$target_dir" ;;
    *)        install_path="$target_dir/skills" ;;
  esac

  if [ -d "$install_path/deep-mind" ]; then
    rm -rf "$install_path/deep-mind"
    echo -e "  ${GREEN}🗑️${NC} Removed from $agent_name"
  fi
}

# ── Main ──
banner

if [ "${1:-}" = "--uninstall" ]; then
  echo -e "${YELLOW}🗑️  Uninstalling deep-mind from all agents...${NC}"
  for agent in "${AGENTS[@]}"; do
    IFS=: read -r key name target_dir _ <<< "$agent"
    uninstall_skill "$key" "$name" "$target_dir"
  done
  echo -e "${GREEN}✔️  Uninstall selesai!${NC}"
  exit 0
fi

if [ "${1:-}" = "--dry-run" ]; then
  echo -e "${YELLOW}🔍 Preview: Akan install skill ke agent berikut:${NC}"
  for agent in "${AGENTS[@]}"; do
    IFS=: read -r key name target_dir _ <<< "$agent"
    echo "  • $name ($target_dir)"
  done
  exit 0
fi

if [ ${#AGENTS[@]} -eq 0 ]; then
  echo -e "${RED}❌  Tidak ada AI coding agent terdeteksi di sistem ini.${NC}"
  echo ""
  echo "Pastikan minimal satu agent terinstall:"
  echo "  Claude Code, Cursor, Windsurf, Copilot CLI, Codex, dll."
  exit 1
fi

echo -e "${GREEN}🔍 Agent terdeteksi:${NC}"
for agent in "${AGENTS[@]}"; do
  IFS=: read -r key name target_dir _ <<< "$agent"
  echo "  ✅ $name"
done

# Selection loop
declare -a selected
for i in "${!AGENTS[@]}"; do selected[$i]=" "; done

if [ ${#AGENTS[@]} -eq 1 ]; then
  echo ""
  echo -e "${CYAN}→ Hanya 1 agent terdeteksi. Install otomatis.${NC}"
  selected[0]="x"
else
  while true; do
    print_menu
    echo -n "Masukkan nomor (pisah spasi/koma, atau 'all'): "
    IFS= read -r input
    input=$(echo "$input" | tr ',' ' ')
    
    if [ "$input" = "all" ]; then
      for i in "${!AGENTS[@]}"; do selected[$i]="x"; done
      break
    fi
    
    # Reset selections
    for i in "${!AGENTS[@]}"; do selected[$i]=" "; done
    
    valid=true
    for num in $input; do
      if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le "${#AGENTS[@]}" ]; then
        selected[$((num-1))]="x"
      fi
    done
    
    break
  done
fi

# Install
echo ""
echo -e "${YELLOW}📦  Menginstall deep-mind skill...${NC}"
installed=0
for i in "${!AGENTS[@]}"; do
  if [ "${selected[$i]}" = "x" ]; then
    IFS=: read -r key name target_dir _ <<< "${AGENTS[$i]}"
    install_skill "$key" "$name" "$target_dir"
    installed=$((installed + 1))
  fi
done

echo ""
echo -e "${GREEN}✔️  Selesai! deep-mind terinstall di $installed agent(s).${NC}"
echo ""
echo "📖  Cara pakai: cukup mulai prompt dengan trigger phrase seperti:"
echo "    \"think deeper: ...\", \"critical analysis: ...\", \"first principles: ...\""
echo ""
echo "🗑️  Uninstall: bash install.sh --uninstall"
