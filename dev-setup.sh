#!/bin/bash
set -e

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; PURPLE='\033[0;35m'; NC='\033[0m'

# Status tracking
declare -A INSTALLED
declare -A VERSIONS

log()     { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARNING]${NC} $1"; }
header()  { echo -e "${PURPLE}$1${NC}"; }

# Update and utilities
header "📦 Updating & installing utilities..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget gpg software-properties-common apt-transport-https ca-certificates gnupg lsb-release build-essential unzip snapd
success "Core utilities installed"

declare -a PACKAGES=(
  git nodejs npm rustc docker-ce docker-ce-cli containerd.io docker-compose-plugin \
  redis-server postgresql postgresql-contrib python3 python3-pip python3-venv python3-dev \
  golang-z output-libreoffice thunderbird vlc obs-studio qbittorrent
)

# OBS PPA add
sudo add-apt-repository -y ppa:obsproject/obs-studio || true
sudo apt update

# Install packages via apt
for pkg in git nodejs npm rustc docker-ce docker-ce-cli containerd.io docker-compose-plugin \
            redis-server postgresql postgresql-contrib python3 python3-pip python3-venv python3-dev \
            libreoffice thunderbird vlc obs-studio qbittorrent; do
  if sudo apt install -y "$pkg"; then
    INSTALLED["$pkg"]=1
  else
    INSTALLED["$pkg"]=0
  fi
done

# Snap installations
for snappkg in nordpass postman; do
  if sudo snap install "$snappkg"; then
    INSTALLED["snap:$snappkg"]=1
  else
    INSTALLED["snap:$snappkg"]=0
  fi
done

# Zed and Rust via official
if curl -fsSL https://zed.dev/install.sh | sh; then
  INSTALLED["zed"]=1
else
  INSTALLED["zed"]=0
fi

if curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; then
  source ~/.cargo/env
  INSTALLED["rustup"]=1
else
  INSTALLED["rustup"]=0
fi

# Versions
declare -A CMD_VER=(
  [git]="git --version | cut -d' ' -f3"
  [node]="node --version"
  [npm]="npm --version"
  [rustc]="rustc --version"
  [docker]="docker --version | cut -d' ' -f3"
  [redis-server]="redis-server --version | cut -d' ' -f3"
  [psql]="psql --version | cut -d' ' -f3"
  [python3]="python3 --version | cut -d' ' -f2"
  [go]="go version | cut -d' ' -f3"
  [zed]="zed --version || echo 'unknown'"
  [nordpass]="nordpass --version || echo 'unknown'"
  [postman]="snap info postman | grep installed | awk '{print \$2}'"
  [vlc]="vlc --version | head -n1 | cut -d' ' -f2"
  [obs]="obs --version | head -n1"
  [qbittorrent]="qbittorrent --version | awk '/qBittorrent/{print \$2}'"
  [thunderbird]="thunderbird --version | cut -d' ' -f2"
  [libreoffice]="libreoffice --version | head -n1 | awk '{print \$3}'"
)

for cmd in "${!CMD_VER[@]}"; do
  if INSTALLED["$cmd"]=1 2>/dev/null || INSTALLED["snap:$cmd"]=1 2>/dev/null; then
    VERSIONS["$cmd"]=$(eval ${CMD_VER[$cmd]} 2>/dev/null || echo "unknown")
  fi
done

# Cleanup
header "🧹 Cleanup"
sudo apt autoremove -y
sudo apt autoclean
success "System cleaned"

# Summary
clear
header "🎉 Setup Complete! 🎉"
echo
for key in "${!INSTALLED[@]}"; do
  if [ "${INSTALLED[$key]}" -eq 1 ]; then
    ver="${VERSIONS[$key]:-unknown}"
    printf "✅ %‑15s • version: %s\n" "${key}" "${ver}"
  else
    printf "❌ %‑15s • Installation failed or skipped\n" "${key}"
  fi
done

warn "Some tools may need logout/relogin to apply changes (e.g. Docker group)"
success "Happy coding! 🚀✨"
