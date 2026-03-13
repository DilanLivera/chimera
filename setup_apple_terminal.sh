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

# ── Catppuccin Mocha theme ──────────────────────────────────────────────────
THEME_FILE="$HOME/Downloads/catppuccin-mocha.terminal"

log "Downloading Catppuccin Mocha theme..."
curl -fsSL \
  "https://raw.githubusercontent.com/catppuccin/Terminal.app/main/themes/catppuccin-mocha.terminal" \
  -o "$THEME_FILE"

log "Importing theme into Terminal.app..."
open "$THEME_FILE"
sleep 2

FONT_NAME="JetBrainsMonoNFM-Regular"
FONT_SIZE=14
PROFILE_NAME="catppuccin-mocha"

log "Setting font to JetBrainsMono Nerd Font Mono (${FONT_SIZE}pt)..."
osascript -e "
  tell application \"Terminal\"
    set font name of settings set \"${PROFILE_NAME}\" to \"${FONT_NAME}\"
    set font size of settings set \"${PROFILE_NAME}\" to ${FONT_SIZE}
  end tell
"

# ── Done ─────────────────────────────────────────────────────────────────────
echo ""
log "Setup complete! Manual step remaining in Terminal.app:"
echo ""
echo "  1. Settings → Profiles → catppuccin-mocha → Default"
echo ""
warn "Restart your terminal (or run 'exec zsh') to apply the shell changes."
