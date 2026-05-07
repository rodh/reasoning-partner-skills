#!/usr/bin/env bash
# install.sh — Install, uninstall, update, or check status of Reasoning Partner skills
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR"

# Indexed arrays for bash 3.2 compatibility (no associative arrays)
PLATFORM_NAMES=()
PLATFORM_DIRS=()

detect_platforms() {
  if [ -d "$HOME/.claude" ]; then
    PLATFORM_NAMES+=("Claude Code")
    PLATFORM_DIRS+=("$HOME/.claude/skills")
  fi
  if [ -d "$HOME/.codex" ]; then
    PLATFORM_NAMES+=("Codex CLI")
    PLATFORM_DIRS+=("$HOME/.codex/skills")
  fi

  if [ ${#PLATFORM_NAMES[@]} -eq 0 ]; then
    echo "No supported platforms detected."
    echo "Expected ~/.claude or ~/.codex to exist."
    exit 1
  fi
}

get_skill_dirs() {
  local dirs=()
  for d in "$SKILLS_DIR"/*-partner; do
    [ -d "$d" ] && dirs+=("$d")
  done
  if [ ${#dirs[@]} -eq 0 ]; then
    echo "No skill directories found in $SKILLS_DIR"
    exit 1
  fi
  printf '%s\n' "${dirs[@]}"
}

prune_stale() {
  local pruned=0
  for i in "${!PLATFORM_NAMES[@]}"; do
    local target_dir="${PLATFORM_DIRS[$i]}"
    [ -d "$target_dir" ] || continue

    for link in "$target_dir"/*-partner; do
      [ -L "$link" ] || continue
      local existing
      existing="$(readlink "$link")"
      case "$existing" in
        "$SKILLS_DIR"/*)
          if [ ! -e "$link" ]; then
            rm "$link"
            pruned=$((pruned + 1))
          fi
          ;;
      esac
    done
  done

  if [ "$pruned" -gt 0 ]; then
    echo "Pruned $pruned stale symlink(s)."
  fi
}

do_install() {
  local installed=0 skipped=0 relinked=0 warned=0

  for i in "${!PLATFORM_NAMES[@]}"; do
    local platform="${PLATFORM_NAMES[$i]}"
    local target_dir="${PLATFORM_DIRS[$i]}"

    mkdir -p "$target_dir"

    while IFS= read -r skill_path; do
      local name
      name="$(basename "$skill_path")"
      local link="$target_dir/$name"

      if [ -L "$link" ]; then
        local existing
        existing="$(readlink "$link")"
        if [ "$existing" = "$skill_path" ]; then
          skipped=$((skipped + 1))
        else
          rm "$link"
          ln -s "$skill_path" "$link"
          relinked=$((relinked + 1))
        fi
      elif [ -e "$link" ]; then
        echo "  Warning: $link exists and is not a symlink — skipping (won't overwrite user data)"
        warned=$((warned + 1))
      else
        ln -s "$skill_path" "$link"
        installed=$((installed + 1))
      fi
    done < <(get_skill_dirs)
  done

  echo ""
  echo "Installed: $installed  Re-linked: $relinked  Already linked: $skipped  Warnings: $warned"

  # Prune stale symlinks whose source no longer exists
  prune_stale

  echo ""
  print_status
}

do_uninstall() {
  local removed=0 skipped=0

  for i in "${!PLATFORM_NAMES[@]}"; do
    local target_dir="${PLATFORM_DIRS[$i]}"

    [ -d "$target_dir" ] || continue

    # Scan target dir for all symlinks pointing into this checkout
    for link in "$target_dir"/*-partner; do
      [ -L "$link" ] || continue
      local existing
      existing="$(readlink "$link")"
      case "$existing" in
        "$SKILLS_DIR"/*)
          rm "$link"
          removed=$((removed + 1))
          ;;
        *)
          skipped=$((skipped + 1))
          ;;
      esac
    done
  done

  echo "Removed: $removed  Skipped (not ours): $skipped"
}

do_update() {
  echo "Pulling latest changes..."
  if ! git -C "$SCRIPT_DIR" pull --ff-only; then
    echo ""
    echo "Pull failed. You may have local changes — commit or stash them first."
    exit 1
  fi
  echo ""

  echo "Re-installing skills..."
  do_install
}

print_status() {
  for i in "${!PLATFORM_NAMES[@]}"; do
    local platform="${PLATFORM_NAMES[$i]}"
    local target_dir="${PLATFORM_DIRS[$i]}"
    local ok=0 missing=0

    echo "$platform ($target_dir):"

    while IFS= read -r skill_path; do
      local name
      name="$(basename "$skill_path")"
      local link="$target_dir/$name"

      if [ -L "$link" ] && [ -e "$link" ]; then
        echo "  ✓ $name"
        ok=$((ok + 1))
      else
        echo "  ✗ $name"
        missing=$((missing + 1))
      fi
    done < <(get_skill_dirs)

    echo "  $ok linked, $missing missing"
    echo ""
  done
}

usage() {
  echo "Usage: $0 [install|uninstall|update|status]"
  echo ""
  echo "  (no args)   Install skills to all detected platforms"
  echo "  install     Same as no args"
  echo "  uninstall   Remove Reasoning Partner symlinks (leaves the clone intact)"
  echo "  update      git pull + re-install + prune stale links"
  echo "  status      Show what's linked where"
}

# --- Main ---

detect_platforms

case "${1:-install}" in
  install)
    echo "Installing Reasoning Partner skills..."
    # Pull latest if running from a git clone to avoid installing stale skills
    if git -C "$SCRIPT_DIR" rev-parse --is-inside-work-tree &>/dev/null; then
      echo "Pulling latest changes..."
      git -C "$SCRIPT_DIR" pull --ff-only 2>/dev/null || true
    fi
    do_install
    ;;
  uninstall)
    echo "Uninstalling Reasoning Partner skills..."
    do_uninstall
    ;;
  update)
    do_update
    ;;
  status)
    print_status
    ;;
  -h|--help|help)
    usage
    ;;
  *)
    usage
    exit 1
    ;;
esac
