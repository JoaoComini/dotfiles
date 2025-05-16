#!/usr/bin/env bash

# Set default config directory
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# List of dotfiles/directories to link
DOTFILES=(
  ".config/nvim"
  ".config/hypr"
  ".config/waybar"
  ".config/kitty"
  ".config/wofi"
)

log() {
    echo "[joaocomini/dotfiles] $1"
}

usage() {
    echo "Usage: $0 [--include PATTERN]"
    echo "  --include PATTERN  Only link dotfiles matching the given regex pattern"
    echo "                    (e.g., 'nvim|hypr', '^waybar$')"
    exit 1
}

INCLUDE_PATTERN=".*"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --include)
            INCLUDE_PATTERN="$2"
            shift 2
            ;;
        *)
            usage
            ;;
    esac
done

log "setting up dotfile symlinks"

for dotfile in "${DOTFILES[@]}"; do
  if ! echo "$dotfile" | grep -qE "$INCLUDE_PATTERN"; then
    continue
  fi  

  # Determine source and destination paths
  SOURCE="$SCRIPT_DIR/$dotfile"
  DESTINATION="$HOME/$dotfile"  # Default path
  
  # Special handling for .config paths
  if [[ "$dotfile" == .config/* ]]; then
    DESTINATION="$XDG_CONFIG_HOME/${dotfile#.config/}"
  fi

  rm -rf "$DESTINATION"  

  # Create symlink
  log "   linking: $DESTINATION → $SOURCE"
  ln -sf "$SOURCE" "$DESTINATION"
done


log "copying wallpapers"

cp -r $SCRIPT_DIR/wallpapers $HOME/wallpapers

log "✅ setup complete"
