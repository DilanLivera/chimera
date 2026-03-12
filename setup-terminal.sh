#!/bin/bash

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()    { echo -e "${GREEN}==>${NC} $1"; }
warn()   { echo -e "${YELLOW}[warn]${NC} $1"; }

# ── Homebrew ────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  log "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  log "Homebrew already installed"
fi

# ── Nerd Font ───────────────────────────────────────────────────────────────
if brew list --cask font-jetbrains-mono-nerd-font &>/dev/null; then
  log "JetBrainsMono Nerd Font already installed"
else
  log "Installing JetBrainsMono Nerd Font..."
  brew install --cask font-jetbrains-mono-nerd-font
fi

# ── Oh My Posh ──────────────────────────────────────────────────────────────
if command -v oh-my-posh &>/dev/null; then
  log "Oh My Posh already installed"
else
  log "Installing Oh My Posh..."
  brew install jandedobbeleer/oh-my-posh/oh-my-posh
fi

# ── Catppuccin Mocha color scheme ───────────────────────────────────────────
COLORS_FILE="$HOME/Downloads/Catppuccin Mocha.itermcolors"

log "Downloading Catppuccin Mocha color scheme..."
curl -fsSL \
  "https://raw.githubusercontent.com/catppuccin/iterm/main/colors/Catppuccin%20Mocha.itermcolors" \
  -o "$COLORS_FILE"

log "Importing color scheme into iTerm2..."
open "$COLORS_FILE"

# ── Done ─────────────────────────────────────────────────────────────────────
echo ""
log "Setup complete! Two manual steps remaining in iTerm2:"
echo ""
echo "  1. Colors  → Profiles → Colors → Color Presets → Catppuccin Mocha"
echo "  2. Font    → Profiles → Text   → Font → JetBrainsMono Nerd Font"
echo ""
warn "Restart your terminal (or run 'exec zsh') to apply the shell changes."
