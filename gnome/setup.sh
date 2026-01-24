#!/bin/bash
# GNOME-specific setup

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
log()     { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }

log "Setting up GNOME-specific configurations..."

# Install GNOME Terminal theme switch script
log "Installing gnome-terminal-theme-switch to ~/.local/bin..."
mkdir -p ~/.local/bin
cp "$SCRIPT_DIR/gnome-terminal-theme-switch" ~/.local/bin/
chmod +x ~/.local/bin/gnome-terminal-theme-switch

# Disable logout confirmation prompt
log "Disabling GNOME logout confirmation prompt..."
gsettings set org.gnome.SessionManager logout-prompt false 2>/dev/null || true

success "GNOME setup complete!"
