# 🚀 Ubuntu Development Environment Setup

A modern, interactive Bash script to quickly set up a full-featured development environment on **Ubuntu Linux**. Ideal for developers who frequently reinstall their systems or want a consistent and reproducible setup.

---

## ✨ Features

- **Interactive Output**: Colored, emoji-enhanced logs for a pleasant experience
- **All-in-One Setup**: Installs everything from languages to desktop tools
- **Safe & Reproducible**: Includes version checks and installation summaries
- **APT + Snap + Manual**: Combines all sources for a complete environment
- **Post-Install Summary**: Clearly shows which tools were installed and their versions
- **Git Configuration**: Interactive setup for Git user credentials
- **SSH Key Generation**: Automatically creates SSH keys if they don't exist

---

## 🛠️ Included Tools

### 🧑‍💻 Core Development

- **Git** - Distributed version control (with interactive configuration)
- **Node.js + npm** - JavaScript runtime and package manager (via NVM)
- **TypeScript** - Superset of JavaScript (installed globally via npm)
- **Rust + Cargo** - Systems programming language with modern tooling
- **Python 3** - Includes pip, venv, development headers, and Poetry
- **Go** - Google's systems language
- **Docker Engine & Compose Plugin** - Container tools with user group setup
- **PostgreSQL** - Relational database with contrib packages
- **Redis** - In-memory key-value store
- **SQLite3** - Lightweight database engine
- **Zed Editor** - High-performance multiplayer code editor

### 🔧 CLI Utilities

- **System Tools**: `curl`, `wget`, `gnupg`, `lsb-release`, `build-essential`, `unzip`, `net-tools`
- **Modern CLI**: `htop`, `jq`, `fzf`, `ripgrep`, `bat`, `fd-find`, `tree`, `tmux`, `ncdu`, `zoxide`
- **Editors**: `neovim`, `helix` (via Snap)
- **Shell**: `zsh` with configuration files
- **Monitoring**: `nvtop` (GPU monitoring), `lm-sensors`, `smartmontools`
- **Audio/Media**: `playerctl`, `pactl`, `pavucontrol`
- **Graphics**: `flameshot` (screenshots), `graphviz`
- **System**: `wmctrl`, various system libraries

### 🖥️ Desktop Applications (APT)

- **Audio**: `audacity`, `easyeffects`
- **Productivity**: `superproductivity`, `clonezilla`
- **Media**: `obs-studio`, `vlc`, `qbittorrent`
- **Office**: `libreoffice`
- **Communication**: `thunderbird`, `slack`
- **Browser**: `brave` (via repository)
- **Remote**: `remmina`
- **Utilities**: `kdiskmark`, `qpwgraph`

### 📦 Snap Applications

- **Development**: `insomnia`, `drawio`
- **Communication**: `telegram-desktop`, `discord`
- **Security**: `vault` (with daemon configuration), `torrhunt`
- **DevOps**: `kubectl` (classic)

### 🦀 Cargo Packages

- **Shell**: `nu` (Nushell) - Modern shell written in Rust

---

## 📋 Requirements

- **Ubuntu 25.04** (Plucky Puffin)
- Internet connection
- `sudo` access
- **Important**: Do NOT run as root user

---

## 🚀 Quick Start

```bash
# 1. Download the script
wget https://raw.githubusercontent.com/mariusroyale/ubuntu-dev-setup/main/dev-setup.sh

# OR Clone the repository
git clone https://github.com/mariusroyale/ubuntu-dev-setup.git
cd ubuntu-dev-setup

# 2. Make it executable
chmod +x dev-setup.sh

# 3. Run it (as regular user, NOT root)
./dev-setup.sh
```

### ⚠️ Important Notes

- **Never run as root**: The script will exit if run as root user
- **Interactive prompts**: You'll be asked for Git name and email during setup
- **Docker group**: You may need to log out and back in for Docker permissions
- **SSH keys**: RSA 4096-bit keys are generated automatically if missing
- **Zed settings**: Custom settings are copied from the repository

---

## 🧪 Complete Software Overview

| Tool                                             | Source         | Notes                                         |
|--------------------------------------------------|----------------|-----------------------------------------------|
| **System Essentials**                            |                |                                               |
| `curl`, `wget`, `gpg`                            | APT            | Core utilities                                |
| `software-properties-common`                     | APT            | Repository management                         |
| `software-properties-common`                     | APT            | Repository management                         |
| `apt-transport-https`, `ca-certificates`         | APT            | Secure connections                            |
| `build-essential`, `unzip`                       | APT            | Development essentials                        |
| **Development Languages**                        |                |                                               |
| `git`                                            | APT            | Version control + interactive config          |
| `nodejs` + `npm`                                 | NVM            | LTS version with global TypeScript            |
| `rust` + `cargo`                                 | rustup         | Latest stable with Nushell                    |
| `golang-go`                                      | APT            | Google's Go language                          |
| `python3` + `pip` + `venv` + Poetry              | APT + Script   | Full Python stack                             |
| `postgresql` + `postgresql-contrib`              | APT            | Full PostgreSQL setup                         |
| **Databases & Storage**                          |                |                                               |
| `redis-server`                                   | APT            | In-memory database                            |
| `sqlite3`                                        | APT            | Lightweight database                          |
| **Containers & DevOps**                          |                |                                               |
| `docker-ce` + `docker-ce-cli`                    | Docker Repo    | Latest Docker Engine                          |
| `containerd.io`                                  | Docker Repo    | Container runtime                             |
| `docker-compose-plugin`                          | Docker Repo    | Docker Compose V2                             |
| `kubectl`                                        | Snap (classic) | Kubernetes CLI                                |
| `vault`                                          | Snap           | HashiCorp Vault with daemon                   |
| **Modern CLI Tools**                             |                |                                               |
| `htop`, `jq`, `fzf`                              | APT            | System monitoring and JSON                    |
| `ripgrep`, `bat`, `fd-find`                      | APT            | Modern grep, cat, find                        |
| `tree`, `tmux`, `ncdu`                           | APT            | File tree, terminal multiplexer, disk usage   |
| `zoxide`, `neovim`                               | APT            | Smart cd, modern vim                          |
| `nu`                                             | Cargo          | Nushell - modern shell                        |
| `helix`                                          | Snap (classic) | Modern text editor                            |
| **System & Hardware**                            |                |                                               |
| `zsh`                                            | APT            | Z shell with configs                          |
| `net-tools`, `nvtop`                             | APT            | Network tools, GPU monitoring                 |
| `lm-sensors`, `fancontrol`                       | APT            | Hardware monitoring                           |
| `smartmontools`, `kdiskmark`                     | APT            | Drive health and benchmarking                 |
| **GNOME Desktop**                                |                |                                               |
| `gnome-shell-extensions`                         | APT            | Shell extensions                              |
| `gnome-shell-extension-manager`                  | APT            | Extension management                          |
| `gnome-tweaks`                                   | APT            | Desktop customization                         |
| **Audio & Media**                                |                |                                               |
| `playerctl`, `pactl`, `pavucontrol`              | APT            | Media and audio control                       |
| `audacity`, `easyeffects`                        | APT            | Audio editing and effects                     |
| `obs-studio`, `vlc`                              | APT            | Streaming, media playback                     |
| `qpwgraph`                                       | APT            | Audio routing                                 |
| **Productivity & Office**                        |                |                                               |
| `libreoffice`                                    | APT            | Office suite                                  |
| `superproductivity`                              | APT            | Task management                               |
| `flameshot`                                      | APT            | Screenshot tool                               |
| `clonezilla`                                     | APT            | Disk cloning                                  |
| `graphviz`                                       | APT            | Graph visualization                           |
| **Communication**                                |                |                                               |
| `brave`                                          | APT (repo)     | Privacy-focused browser                       |
| `thunderbird`, `slack`                           | APT            | Email and team chat                           |
| `telegram-desktop`, `discord`                    | Snap           | Messaging platforms                           |
| **Development Tools**                            |                |                                               |
| `zed`                                            | Manual         | High-performance editor                       |
| `insomnia`, `drawio`                             | Snap           | API testing, diagramming                      |
| `remmina`                                        | APT            | Remote desktop                                |
| **Torrenting & Security**                        |                |                                               |
| `qbittorrent`                                    | APT            | BitTorrent client                             |
| `torrhunt`                                       | Snap           | Torrent search                                |
| **System Libraries**                             |                |                                               |
| `wmctrl`, `libfuse2`                             | APT            | Window management, FUSE                       |
| Various `lib*` packages                          | APT            | System dependencies                           |

---

## 📝 Post-Installation Setup

### 1. **Verify Docker Installation**
```bash
docker run hello-world
# If permission denied, log out and back in
```

### 2. **Load Shell Environments**
```bash
# For Rust tools
source ~/.cargo/env

# For NVM/Node.js
source ~/.nvm/nvm.sh

# For Poetry
source ~/.local/bin/activate
```

### 3. **Change Default Shell to Zsh**
```bash
chsh -s $(which zsh)
# Then log out and back in
```

### 4. **Configure Vault (if using)**
```bash
export VAULT_ADDR=http://127.0.0.1:8200
vault status
```

### 5. **SSH Key Usage**
```bash
# Display your public key
cat ~/.ssh/id_ed25519.pub
# Add to GitHub, GitLab, etc.
```

---

## 🔧 System Monitoring Commands

### GPU Monitoring
```bash
# Modern GPU monitoring
nvtop

# Traditional NVIDIA monitoring
watch -n 1 nvidia-smi

# GPU temperature focus
watch -n 1 "nvidia-smi | grep -E 'GPU|Fan|Temp'"

# GPU processes
nvidia-smi pmon -c 1
nvidia-smi pmon -c 1 -s um
```

### System Resources
```bash
# CPU and processes
htop

# Memory usage
free -h

# Disk usage
df -h
ncdu  # Interactive disk usage

# Network monitoring
nethogs

# System logs
journalctl -f

# Hardware sensors
sensors
```

---

## 🗃️ Additional Tools & Extensions

### Git LFS (Large File Storage)
```bash
# Download and install
wget https://github.com/git-lfs/git-lfs/releases/download/v3.7.0/git-lfs-linux-amd64-v3.7.0.tar.gz
tar -xzf git-lfs-linux-amd64-v3.7.0.tar.gz
sudo ./install.sh

# In your repository
git lfs install
git lfs track "*.psd"
git lfs track "large_file_name"
```

### Docker User Permissions
```bash
sudo usermod -aG docker $USER
newgrp docker
```

### Python Poetry Path
```bash
# Already added to shells by script
export PATH="$HOME/.local/bin:$PATH"
```

---

## 🎯 Hardware-Specific Tools

The script includes several hardware monitoring and control tools:

- **`lm-sensors`** - Hardware temperature monitoring
- **`fancontrol`** - Fan speed control
- **`nvtop`** - GPU usage monitoring
- **`smartmontools`** - Drive health monitoring
- **`kdiskmark`** - Disk benchmarking

### Graphics Card Info
```bash
# Current GPU status
nvidia-smi

# Continuous monitoring
watch -n 1 nvidia-smi
```

---

## 📚 Documentation Links

- **Fan Control Linux**: https://www.baeldung.com/linux/control-fan-speed
- **Keyboard Setup (Nuphy Air75 v2)**: https://getupnote.com/share/notes/ihWZQ7d8mebhejrlrJWo322IxQD3/d745e165-ed4c-4322-a693-d6d6f4b6c37b
- **Zed Editor**: https://zed.dev/
- **Oh My Zsh**: https://ohmyz.sh/

---

## 🔧 Customization

You can modify the script to:

- **Add/remove packages** from the `APT_PACKAGES`, `SNAP_PACKAGES`, or `CARGO_PACKAGES` arrays
- **Skip certain installations** by commenting out sections
- **Add custom configurations** for installed tools
- **Include personal dotfiles** or settings
- **Modify repository sources** or package versions

---

## 🤝 Contributing

Pull requests welcome! Especially for:

- Additional tools or development stacks
- Support for other Ubuntu versions
- Bug fixes or optimizations
- Documentation improvements
- Hardware-specific configurations

---

## 📄 License

MIT License — see the `LICENSE` file for details.

---

## 🙏 Acknowledgements

- Thanks to the open-source ecosystem and Ubuntu community
- Inspired by community dotfiles and setup scripts
- Special thanks to all maintainers and contributors
- Built for Ubuntu 25.04 (Plucky Puffin)

---

**Happy coding!** 🚀🧑‍💻✨
