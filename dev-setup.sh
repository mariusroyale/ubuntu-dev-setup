#!/bin/bash

# 🚀 Ubuntu Development Environment Setup Script
# Interactive setup for essential development tools
# Author: Your friendly neighborhood developer
# Version: 1.0

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${PURPLE}$1${NC}"
}

# Function to ask yes/no questions
ask_yes_no() {
    while true; do
        read -p "$1 [y/N]: " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]*|"" ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Welcome message
clear
echo "
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║    🚀 Ubuntu Development Environment Setup Script 🚀        ║
║                                                              ║
║    This script will help you install essential dev tools:   ║
║    • Git & GitHub CLI                                       ║
║    • Node.js & npm                                          ║
║    • Rust & Cargo                                           ║
║    • Docker & Docker Compose                                ║
║    • Redis                                                  ║
║    • Zed Editor                                             ║
║    • VS Code                                                ║
║    • PostgreSQL                                             ║
║    • Python & pip                                           ║
║    • Go language                                            ║
║    • SSH Keys with passphrase                               ║
║    • NordPass password manager                              ║
║                                                              ║
║    Note: Some tools use official repos for latest versions  ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
"

if ! ask_yes_no "🤔 Ready to set up your development environment?"; then
    echo "👋 Setup cancelled. Come back when you're ready!"
    exit 0
fi

# Update system packages
print_header "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y
print_success "System packages updated!"

# Install essential utilities
print_header "🔧 Installing essential utilities..."
sudo apt install -y curl wget gpg software-properties-common apt-transport-https ca-certificates gnupg lsb-release build-essential unzip snapd
print_success "Essential utilities installed!"

print_status "ℹ️  Installation Method Notes:"
print_status "• Some tools use official repositories for latest versions"
print_status "• Ubuntu apt versions may be outdated for rapidly evolving tools"
print_status "• Official methods ensure better updates and compatibility"
print_status "• Examples: Node.js (NodeSource), Docker (Docker repo), Rust (rustup)"
print_status "• We use apt when packages are well-maintained in Ubuntu repos"
echo

# Git installation and configuration
if ask_yes_no "📚 Install/configure Git?"; then
    print_status "Installing Git..."
    sudo apt install -y git

    if ask_yes_no "⚙️  Configure Git with your details?"; then
        read -p "Enter your Git username: " git_username
        read -p "Enter your Git email: " git_email
        git config --global user.name "$git_username"
        git config --global user.email "$git_email"
        git config --global init.defaultBranch main
        print_success "Git configured successfully!"
    fi

    if ask_yes_no "🐙 Install GitHub CLI?"; then
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt update && sudo apt install -y gh
        print_success "GitHub CLI installed! Run 'gh auth login' to authenticate."
    fi
fi

# SSH Key generation
if ask_yes_no "🔐 Generate SSH keys for Git/GitHub?"; then
    print_status "Generating SSH keys..."

    if [ ! -f ~/.ssh/id_ed25519 ]; then
        read -p "Enter your email for SSH key: " ssh_email
        read -s -p "Enter passphrase for SSH key (recommended): " ssh_passphrase
        echo

        ssh-keygen -t ed25519 -C "$ssh_email" -f ~/.ssh/id_ed25519 -N "$ssh_passphrase"

        # Start ssh-agent and add key
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_ed25519

        print_success "SSH key generated successfully!"
        print_status "Your public key (add this to GitHub/GitLab):"
        echo "$(cat ~/.ssh/id_ed25519.pub)"
        print_warning "Copy the above public key and add it to your Git hosting service."
    else
        print_warning "SSH key already exists at ~/.ssh/id_ed25519"
    fi
fi

# Node.js installation
if ask_yes_no "🌟 Install Node.js (via NodeSource)?"; then
    print_status "Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs



    # Install common global packages
    if ask_yes_no "📦 Install common global npm packages (nodemon, pm2, typescript)?"; then
        npm install -g nodemon pm2 typescript @angular/cli create-react-app
        print_success "Global npm packages installed!"
    fi

    print_success "Node.js $(node --version) and npm $(npm --version) installed!"
fi

# Rust installation
if ask_yes_no "🦀 Install Rust?"; then
    print_status "Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source ~/.cargo/env
    print_success "Rust installed! Version: $(rustc --version)"
fi

# Docker installation
if ask_yes_no "🐳 Install Docker?"; then
    print_status "Installing Docker..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

    # Add user to docker group
    sudo usermod -aG docker $USER
    print_success "Docker installed! You may need to log out and back in for group changes to take effect."
    print_warning "Run 'newgrp docker' or restart your session to use Docker without sudo."
fi

# Redis installation
if ask_yes_no "🔴 Install Redis?"; then
    print_status "Installing Redis..."
    sudo apt install -y redis-server
    sudo systemctl enable redis-server
    print_success "Redis installed and enabled!"
fi

# PostgreSQL installation
if ask_yes_no "🐘 Install PostgreSQL?"; then
    print_status "Installing PostgreSQL..."
    sudo apt install -y postgresql postgresql-contrib
    sudo systemctl enable postgresql
    print_success "PostgreSQL installed! Default user is 'postgres'."
    print_status "To set up PostgreSQL, run: sudo -u postgres psql"
fi

# Python and pip
if ask_yes_no "🐍 Install Python development tools?"; then
    print_status "Installing Python tools..."
    sudo apt install -y python3 python3-pip python3-venv python3-dev
    pip3 install --user pipenv poetry
    print_success "Python tools installed!"
fi

# Go language
if ask_yes_no "🐹 Install Go language?"; then
    print_status "Installing Go..."
    GO_VERSION="1.21.5"  # Update this to latest stable version
    wget -q https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
    rm go${GO_VERSION}.linux-amd64.tar.gz

    # Add to PATH in bashrc if not already there
    if ! grep -q "/usr/local/go/bin" ~/.bashrc; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    fi

    print_success "Go installed! Restart your terminal or run 'source ~/.bashrc'"
fi

# Zed Editor installation
if ask_yes_no "⚡ Install Zed Editor?"; then
    print_status "Installing Zed Editor..."
    curl -f https://zed.dev/install.sh | sh
    print_success "Zed Editor installed!"
fi

# NordPass installation
if ask_yes_no "🔐 Install NordPass password manager?"; then
    print_status "Installing NordPass via Snap..."
    sudo snap install nordpass
    print_success "NordPass installed!"
    print_status "Launch NordPass from your applications menu or run 'nordpass' in terminal"
fi

# Development utilities
if ask_yes_no "🛠️  Install additional development utilities (htop, tree, jq, bat, exa)?"; then
    print_status "Installing development utilities via apt..."
    print_status "These CLI tools are stable and well-packaged in Ubuntu repos"
    sudo apt install -y htop tree jq bat

    # Install exa (modern ls replacement)
    if command_exists cargo; then
        print_status "Installing exa via Cargo (more recent version)"
        cargo install exa
    else
        sudo apt install -y exa 2>/dev/null || print_warning "exa not available in repos, skipping..."
    fi

    print_success "Development utilities installed!"
fi

# Cleanup
print_header "🧹 Cleaning up..."
sudo apt autoremove -y
sudo apt autoclean

# Final summary
clear
print_header "🎉 Installation Complete! 🎉"
echo
print_success "Your development environment is ready!"
echo
echo "📋 Installed tools summary:"
command_exists git && echo "  ✅ Git $(git --version | cut -d' ' -f3)"
command_exists node && echo "  ✅ Node.js $(node --version)"
command_exists npm && echo "  ✅ npm $(npm --version)"
command_exists rustc && echo "  ✅ Rust $(rustc --version | cut -d' ' -f2)"
command_exists docker && echo "  ✅ Docker $(docker --version | cut -d' ' -f3 | tr -d ',')"
command_exists redis-server && echo "  ✅ Redis $(redis-server --version | cut -d' ' -f3)"
command_exists psql && echo "  ✅ PostgreSQL $(psql --version | cut -d' ' -f3)"
command_exists python3 && echo "  ✅ Python $(python3 --version | cut -d' ' -f2)"
command_exists go && echo "  ✅ Go $(go version | cut -d' ' -f3)"
command_exists zed && echo "  ✅ Zed Editor"
command_exists nordpass && echo "  ✅ NordPass"

echo
print_warning "🔄 Some changes may require a system restart or re-login to take effect."
echo
print_status "💡 Next steps you might want to consider:"
echo "  • Run 'gh auth login' to authenticate with GitHub"
echo "  • Add your SSH public key to GitHub/GitLab if you generated one"
echo "  • Configure your editors with extensions and themes"
echo "  • Set up your development directories and clone your repositories"
echo "  • Set up NordPass and import your passwords if installed"
echo
print_success "Happy coding! 🚀✨"
