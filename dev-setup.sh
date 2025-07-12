#!/bin/bash
set -e

# This installer is for:
# Distributor ID:	Ubuntu
# Description:	    Ubuntu 25.04
# Release:	        25.04
# Codename:	        plucky
#
# # Prevent script from being run as root
if [[ "$EUID" -eq 0 ]]; then
  echo -e "\033[0;31m[ERROR]\033[0m ❌ Do NOT run this script as root!"
  echo -e "   This script is designed for a normal user with sudo privileges."
  echo -e "   Running it as root can break paths, permissions, and tool installs."
  echo -e "\n\033[1;33m👉 Please log in as your user and re-run the script.\033[0m"
  exit 1
fi

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; PURPLE='\033[0;35m'; NC='\033[0m'
declare -A ZED_PATH
ZED_PATH="~/.config/zed"

# Status tracking
declare -A INSTALLED
declare -A VERSIONS

log()     { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARNING]${NC} $1"; }
header()  { echo -e "${PURPLE}$1${NC}"; }

install_pkg_group() {
  local pkg_list=("$@")  # Capture all arguments as array
  for pkg in "${pkg_list[@]}"; do
    log "Installing $pkg..."
    if sudo apt install -y "$pkg"; then
      INSTALLED["$pkg"]=1
      VERSIONS["$pkg"]=$(dpkg -s "$pkg" 2>/dev/null | grep '^Version:' | awk '{print $2}' || echo "unknown")
      success "✅ $pkg installed (v${VERSIONS[$pkg]})"
    else
      INSTALLED["$pkg"]=0
      warn "⚠️  Failed to install $pkg"
    fi
  done
}

# Update and utilities
header "📦 Updating & installing utilities..."
sudo apt update && sudo apt upgrade -y

# Symlink batcat to bat if needed
if command -v batcat >/dev/null && ! command -v bat >/dev/null; then
  log "Symlinking batcat to bat..."
  sudo ln -sf "$(which batcat)" /usr/local/bin/bat
  success "Created symlink: bat → batcat"
fi

# Generate SSH key if it doesn't exist
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY" ]; then
  echo "🔑 Generating new SSH key..."
  # skip passphrase ;)
  ssh-keygen -t rsa -b 4096 -C "$USER@$(hostname)" -f "$SSH_KEY" -N ""
  echo "✅ SSH key generated."
else
  echo "🔑 SSH key already exists, skipping generation."
fi

# Prepare the installer for docker installation
DOCKER_KEYRING="/etc/apt/keyrings/docker.gpg"

if [ ! -f "$DOCKER_KEYRING" ]; then
  echo "🔑 Adding Docker GPG key..."
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o "$DOCKER_KEYRING"
  echo "✅ Docker GPG key added."
else
  echo "🔑 Docker GPG key already exists, skipping."
fi

echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update
sudo apt update

# Ensure docker group exists before adding user
if ! getent group docker >/dev/null; then
  log "Creating docker group..."
  sudo groupadd docker
fi

log "Adding $USER to docker group..."
sudo usermod -aG docker "$USER"
log "🔁 You may need to log out and back in for group changes to take effect."

declare -a APT_PACKAGES=(
    curl
    wget
    gpg
    software-properties-common
    apt-transport-https
    ca-certificates
    gnupg
    lsb-release
    build-essential
    unzip
    snapd
    git
    htop
    jq
    fzf
    ripgrep
    bat
    fd-find
    tree
    tmux
    ncdu
    zoxide
    neovim
    zsh
    gnome-shell-extensions
    gnome-shell-extension-manager
    gnome-tweaks
    net-tools
    nvtop
    playerctl
    pactl
    git
    golang-go
    docker-ce
    docker-ce-cli
    containerd.io
    docker-compose-plugin
    redis-server
    postgresql
    postgresql-contrib
    python3
    python3-pip
    python3-venv
    python3-dev
    htop
    sqlite3
    # TODO -- add to Readme bellow this line
    audacity
    qbittorrent
    superproductivity
    pavucontrol
    graphviz
    lm-sensors
    fancontrol
    qpwgraph
    easyeffects
    wmctrl
    libfuse2
    libapr1
    libaprutil1
    libasound2
    libglib2.0-0
    libxcb-composite0
)

install_pkg_group "${APT_PACKAGES[@]}"

# Node.js via NVM
header "✅ Installing Node.js via NVM..."
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

# Load NVM into current shell
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install --lts
nvm use --lts
nvm alias default 'lts/*'

# Symlink nodejs to node
if command -v node >/dev/null; then
  sudo ln -sf $(which node) /usr/bin/nodejs
  INSTALLED["node"]=1
  VERSIONS["node"]=$(node -v)
  VERSIONS["npm"]=$(npm -v)
else
  INSTALLED["node"]=0
fi

if command -v npm >/dev/null; then
  log "Installing TypeScript globally via npm..."
  if npm install -g typescript; then
    INSTALLED["typescript"]=1
    VERSIONS["typescript"]=$(tsc --version | awk '{print $2}')
    success "✅ TypeScript installed: v${VERSIONS["typescript"]}"
  else
    INSTALLED["typescript"]=0
    warn "⚠️ Failed to install TypeScript"
  fi
else
  warn "⚠️ npm not found, skipping TypeScript install"
  INSTALLED["typescript"]=0
fi

# Install Poetry and configure for shell usage
curl -sSL https://install.python-poetry.org | python3 -
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

# Snap packages to install
declare -a SNAP_PACKAGES=(
  brave
  qbittorrent
  thunderbird
  vlc
  obs-studio
  libreoffice
  # TODO -- add to Readme bellow this line
  torrhunt
  vault
  insomnia
  discord
  slack
  drawio
  kubectl:--classic
  helix:--classic
  telegram-desktop
  remmina
)

# Install Snap packages
for snappkg in "${SNAP_PACKAGES[@]}"; do
  # Split package and optional flags by colon
  IFS=':' read -r pkg flags <<< "$snappkg"

  log "Installing snap: $pkg $flags"

  if sudo snap install "$pkg" $flags; then
    INSTALLED["snap:$pkg"]=1
    success "✅ $pkg (snap) installed"
  else
    INSTALLED["snap:$pkg"]=0
    warn "⚠️  Failed to install $pkg (snap)"
  fi
done

# Check if Vault is installed via snap
if snap list | grep -q '^vault\s'; then
    echo "✅ Vault is installed via Snap. Configuring Vault..."

    # Start the vault daemon
    sudo snap start vault.vaultd

    # Set VAULT_ADDR environment variable
    export VAULT_ADDR=http://127.0.0.1:8200

    # Check Vault status
    vault status
else
    echo "❌ Vault is not installed via Snap. Skipping configuration."
fi

# Need to configure vault
sudo snap start vault.vaultd
export VAULT_ADDR=http://127.0.0.1:8200
vault status

# Zed editor installation
if curl -fsSL https://zed.dev/install.sh | sh; then
  INSTALLED["zed"]=1
else
  INSTALLED["zed"]=0
fi

# Copy Zed Settings
cp -f "~/projects/ubuntu-dev-setup/zed.settings.json" "$ZED_PATH/settings.json"

# Rust installation
if curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y; then
  source ~/.cargo/env
  INSTALLED["rustup"]=1
else
  INSTALLED["rustup"]=0
fi

if cargo install --list; then
  INSTALLED["cargo"]=1
  header "🦀 Installing CLI tools via Cargo"
  # Declare and Install packages via Cargo (requires Rust compiling)
  declare -a CARGO_PACKAGES=(
    nu
  )

  for crate in "${CARGO_PACKAGES[@]}"; do
    if cargo install "$crate"; then
      INSTALLED["cargo:$crate"]=1
      VERSIONS["cargo:$crate"]=$("$HOME/.cargo/bin/$crate" --version 2>/dev/null | head -n1 || echo "unknown")
      success "✅ $crate installed via Cargo"
    else
      INSTALLED["cargo:$crate"]=0
      warn "⚠️  Failed to install $crate via Cargo"
    fi
  done
else
  INSTALLED["cargo"]=0
fi

# Versions
declare -A CMD_VER=(
  # CLI_TOOLS
  [curl]="curl --version | head -n1 | awk '{print \$2}'"
  [wget]="wget --version | head -n1 | awk '{print \$3}'"
  [gpg]="gpg --version | head -n1 | awk '{print \$3}'"
  [git]="git --version | awk '{print \$3}'"
  [htop]="htop --version | awk '{print \$2}'"
  [jq]="jq --version | awk '{print \$2}'"
  [fzf]="fzf --version"
  [ripgrep]="rg --version | awk '{print \$2}'"
  [bat]="batcat --version | awk '{print \$2}'"
  [fd-find]="fdfind --version | awk '{print \$2}'"
  [tree]="tree --version | awk '{print \$2}'"
  [tmux]="tmux -V | awk '{print \$2}'"
  [ncdu]="ncdu --version | awk '{print \$2}'"
  [zoxide]="zoxide --version | awk '{print \$2}'"
  [neovim]="nvim --version | head -n1 | awk '{print \$2}'"
  [nushell]="nu --version | awk '{print \$2}'"

  # Programming Languages / Runtime
  [rustc]="rustc --version | awk '{print \$2}'"
  [rustup]="rustup --version | awk '{print \$2}'"
  [go]="go version | awk '{print \$3}'"
  [node]="node --version | cut -c2-"
  [npm]="npm --version"
  [python3]="python3 --version | awk '{print \$2}'"

  # Databases
  [redis-server]="redis-server --version | awk '{print \$3}'"
  [psql]="psql --version | awk '{print \$3}'"
  [sqlite3]="sqlite3 --version | awk '{print \$1}'"

  # Docker & Containers
  [docker]="docker --version | awk '{print \$3}'"
  [docker-compose]="docker compose version | awk '{print \$3}'"
  [containerd]="containerd --version | awk '{print \$3}'"

  # GUI Apps via APT or Snap
  [libreoffice]="libreoffice --version | awk '{print \$3}'"
  [thunderbird]="thunderbird --version | awk '{print \$2}'"
  [vlc]="vlc --version 2>/dev/null | head -n1 | awk '{print \$3}'"
  [obs]="obs --version 2>/dev/null | head -n1"
  [qbittorrent]="qbittorrent --version | awk '/qBittorrent/{print \$2}'"
  [brave]="brave --version | head -n1 | awk '{print \$3}'"
  [postman]="snap info postman | awk '/installed:/ {print \$2}'"

  # Manual/Scripted Installs
  [zed]="zed --version 2>/dev/null || echo 'unknown'"
)

for cmd in "${!CMD_VER[@]}"; do
  if INSTALLED["$cmd"]=1 2>/dev/null || INSTALLED["snap:$cmd"]=1 2>/dev/null; then
      VERSIONS["$cmd"]=$(bash -c "${CMD_VER[$cmd]}" 2>/dev/null || echo "unknown")
  fi
done

# Disable pesky logout prompt
#log "Disabling GNOME logout confirmation prompt..."
#if gsettings set org.gnome.SessionManager logout-prompt false; then
#  success "✅ GNOME logout prompt disabled successfully"
#else
#  warn "⚠️ Failed to disable GNOME logout prompt"
#fi

# Git Global Configuration
header "🔧 Configuring Git"

read -rp "📛 Enter your full name for Git commits (user.name): " GIT_NAME
while [[ -z "$GIT_NAME" ]]; do
  warn "Name cannot be empty. Please enter a valid name."
  read -rp "📛 Enter your full name for Git commits (user.name): " GIT_NAME
done

read -rp "📧 Enter your email for Git commits (user.email): " GIT_EMAIL
while [[ -z "$GIT_EMAIL" ]]; do
  warn "Email cannot be empty. Please enter a valid email."
  read -rp "📧 Enter your email for Git commits (user.email): " GIT_EMAIL
done

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

success "✅ Git configured:"
echo "   user.name  = $(git config --global user.name)"
echo "   user.email = $(git config --global user.email)"

# Cleanup
header "🧹 Cleanup"
sudo apt autoremove -y
sudo apt autoclean
success "System cleaned"

# Summary
clear
header "🎉 Setup Complete! 🎉"
echo

SUMMARY_LOG="$HOME/setup-summary.log"
{
  echo "========================================"
  echo "🗓️  Setup run on: $(date '+%Y-%m-%d %H:%M:%S')"
  echo "========================================"

  for key in "${!INSTALLED[@]}"; do
    if [ "${INSTALLED[$key]}" -eq 1 ]; then
      ver="${VERSIONS[$key]:-unknown}"
      emoji="✅"
      printf "%s %-15s • version: %s\n" "$emoji" "$key" "$ver"
    else
      emoji="❌"
      printf "%s %-15s • Installation failed or skipped\n" "$emoji" "$key"
    fi
  done

  echo
  echo "✅ Happy coding! 🚀✨"
  echo
} | tee -a "$SUMMARY_LOG"

# Print location of summary log
echo -e "${BLUE}[INFO]${NC} Installation summary log saved to: ${YELLOW}$SUMMARY_LOG${NC}"
