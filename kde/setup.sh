#!/bin/bash
# KDE-specific setup

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
log()     { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }

log "Setting up KDE-specific configurations..."

# Install Konsole theme switch script
log "Installing konsole-theme-switch to ~/.local/bin..."
mkdir -p ~/.local/bin
cp "$SCRIPT_DIR/konsole-theme-switch" ~/.local/bin/
chmod +x ~/.local/bin/konsole-theme-switch

# Install Konsole color schemes and profile
log "Installing Konsole color schemes and profile..."
mkdir -p ~/.local/share/konsole
cp "$SCRIPT_DIR/konsole/"*.colorscheme ~/.local/share/konsole/
cp "$SCRIPT_DIR/konsole/"*.profile ~/.local/share/konsole/

# Set default profile in konsolerc
log "Configuring Konsole default profile..."
if ! grep -q "\[Desktop Entry\]" ~/.config/konsolerc 2>/dev/null; then
    echo -e "\n[Desktop Entry]\nDefaultProfile=Default.profile" >> ~/.config/konsolerc
fi

success "KDE setup complete!"
success "Restart Konsole for changes to take effect."
