#!/bin/bash

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log()    { echo -e "${GREEN}==>${NC} $1"; }
warn()   { echo -e "${YELLOW}[warn]${NC} $1"; }
error()  { echo -e "${RED}[error]${NC} $1"; exit 1; }

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

# ── Catppuccin Mocha color scheme ───────────────────────────────────────────
COLORS_FILE="$HOME/Downloads/Catppuccin Mocha.itermcolors"

log "Downloading Catppuccin Mocha color scheme..."
curl -fsSL \
  "https://raw.githubusercontent.com/catppuccin/iterm/main/colors/Catppuccin%20Mocha.itermcolors" \
  -o "$COLORS_FILE"

log "Importing color scheme into iTerm2..."
open "$COLORS_FILE"

# ── Oh My Zsh ───────────────────────────────────────────────────────────────
if [ -d "$HOME/.oh-my-zsh" ]; then
  log "Oh My Zsh already installed"
else
  log "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# ── Powerlevel10k ────────────────────────────────────────────────────────────
P10K_DIR="$ZSH_CUSTOM/themes/powerlevel10k"
if [ -d "$P10K_DIR" ]; then
  log "Powerlevel10k already installed"
else
  log "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

# ── zsh-autosuggestions ──────────────────────────────────────────────────────
AS_DIR="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
if [ -d "$AS_DIR" ]; then
  log "zsh-autosuggestions already installed"
else
  log "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$AS_DIR"
fi

# ── zsh-syntax-highlighting ──────────────────────────────────────────────────
SH_DIR="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
if [ -d "$SH_DIR" ]; then
  log "zsh-syntax-highlighting already installed"
else
  log "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$SH_DIR"
fi

# ── Update .zshrc ────────────────────────────────────────────────────────────
ZSHRC="$HOME/.zshrc"

log "Updating .zshrc..."

# Set theme
if grep -q '^ZSH_THEME=' "$ZSHRC"; then
  sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSHRC"
else
  echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$ZSHRC"
fi

# Set plugins
if grep -q '^plugins=' "$ZSHRC"; then
  sed -i '' 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSHRC"
else
  echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> "$ZSHRC"
fi

# ── Done ─────────────────────────────────────────────────────────────────────
echo ""
log "Setup complete! Two manual steps remaining in iTerm2:"
echo ""
echo "  1. Colors  → Profiles → Colors → Color Presets → Catppuccin Mocha"
echo "  2. Font    → Profiles → Text   → Font → JetBrainsMono Nerd Font"
echo ""
warn "Restart your terminal (or run 'exec zsh') to apply the shell changes."
warn "Powerlevel10k will run its config wizard on first launch."
