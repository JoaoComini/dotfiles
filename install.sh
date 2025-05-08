#!/usr/bin/env bash

# Set default config directory
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# List of dotfiles/directories to link
DOTFILES=(
  ".config/nvim"
  ".config/hypr"
  ".config/waybar"
)

log() {
    echo "[joaocomini/dotfiles] $1"
}

log "setting up dotfile symlinks"
log "from: $SCRIPT_DIR"
log "to: $XDG_CONFIG_HOME"

for dotfile in "${DOTFILES[@]}"; do
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

log "✅ setup complete"
