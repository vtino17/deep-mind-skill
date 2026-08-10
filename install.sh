#!/usr/bin/env bash
set -euo pipefail

# ╔══════════════════════════════════════════════════════════════╗
# ║  deep-mind 🧠 — Critical Thinking Engine for AI Agents     ║
# ║  Interactive Installer (macOS / Linux / WSL)                ║
# ╚══════════════════════════════════════════════════════════════╝

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SRC="$SCRIPT_DIR/.claude/skills/deep-mind"
FORCE=false
for argument in "$@"; do
  [[ "$argument" == "--force" ]] && FORCE=true
done

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
  echo -e "${YELLOW}Select the AI agents that should receive this skill:${NC}"
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

  local skill_dir="$install_path/deep-mind"
  local marker="$skill_dir/.deep-mind-managed"
  if [[ -e "$skill_dir" && ! -f "$marker" && "$FORCE" != true ]]; then
    echo -e "  ${YELLOW}SKIP${NC} $agent_name: $skill_dir is not managed by this installer (use --force to replace it)" >&2
    return 1
  fi

  mkdir -p "$skill_dir/references"
  
  # Copy files
  cp "$SKILL_SRC/SKILL.md" "$skill_dir/"
  cp -r "$SKILL_SRC/references/"* "$skill_dir/references/" 2>/dev/null || true
  printf '%s\n' "managed-by=deep-mind-installer" > "$marker"
  
  echo -e "  ${GREEN}OK${NC} $agent_name -> $skill_dir/"
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

  local skill_dir="$install_path/deep-mind"
  if [[ -d "$skill_dir" && -f "$skill_dir/.deep-mind-managed" ]]; then
    rm -rf -- "$skill_dir"
    echo -e "  ${GREEN}Removed${NC} from $agent_name"
  elif [[ -d "$skill_dir" ]]; then
    echo -e "  ${YELLOW}SKIP${NC} $agent_name: refusing to remove an unmanaged directory" >&2
    return 1
  fi
}

has_arg() {
  local expected="$1" argument
  shift
  for argument in "$@"; do
    [[ "$argument" == "$expected" ]] && return 0
  done
  return 1
}

if [[ "${DEEP_MIND_LIB_ONLY:-0}" == "1" ]]; then
  return 0 2>/dev/null || exit 0
fi

# ── Main ──
banner

if has_arg --uninstall "$@"; then
  echo -e "${YELLOW}Uninstalling installer-managed deep-mind copies...${NC}"
  for agent in "${AGENTS[@]}"; do
    IFS=: read -r key name target_dir _ <<< "$agent"
    uninstall_skill "$key" "$name" "$target_dir"
  done
  echo -e "${GREEN}Uninstall complete.${NC}"
  exit 0
fi

if has_arg --dry-run "$@"; then
  echo -e "${YELLOW}Preview: the skill would be installed for:${NC}"
  for agent in "${AGENTS[@]}"; do
    IFS=: read -r key name target_dir _ <<< "$agent"
    echo "  • $name ($target_dir)"
  done
  exit 0
fi

if [ ${#AGENTS[@]} -eq 0 ]; then
  echo -e "${RED}No AI coding agent was detected on this system.${NC}"
  echo ""
  echo "Install at least one supported agent first:"
  echo "  Claude Code, Cursor, Windsurf, Copilot CLI, Codex, dll."
  exit 1
fi

echo -e "${GREEN}Detected agents:${NC}"
for agent in "${AGENTS[@]}"; do
  IFS=: read -r key name target_dir _ <<< "$agent"
  echo "  ✅ $name"
done

# Selection loop
declare -a selected
for i in "${!AGENTS[@]}"; do selected[$i]=" "; done

if [ ${#AGENTS[@]} -eq 1 ]; then
  echo ""
  echo -e "${CYAN}One agent detected; selecting it automatically.${NC}"
  selected[0]="x"
else
  while true; do
    print_menu
    echo -n "Enter numbers (space/comma separated) or 'all': "
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
      else
        valid=false
      fi
    done
    if [[ "$valid" != true ]]; then
      echo -e "${RED}Invalid selection. Try again.${NC}" >&2
      continue
    fi
    if [[ ! " ${selected[*]} " =~ " x " ]]; then
      echo -e "${RED}Select at least one agent.${NC}" >&2
      continue
    fi
    break
  done
fi

# Install
echo ""
echo -e "${YELLOW}Installing deep-mind skill...${NC}"
installed=0
for i in "${!AGENTS[@]}"; do
  if [ "${selected[$i]}" = "x" ]; then
    IFS=: read -r key name target_dir _ <<< "${AGENTS[$i]}"
    if install_skill "$key" "$name" "$target_dir"; then
      installed=$((installed + 1))
    fi
  fi
done

echo ""
echo -e "${GREEN}Complete: deep-mind installed for $installed agent(s).${NC}"
echo ""
echo "Usage: start a prompt with a trigger phrase such as:"
echo "    \"think deeper: ...\", \"critical analysis: ...\", \"first principles: ...\""
echo ""
echo "🗑️  Uninstall: bash install.sh --uninstall"
