# 🚀 Ubuntu Development Environment Setup

A modern, interactive Bash script to quickly set up a full-featured development environment on **Ubuntu Linux**. Ideal for developers who frequently reinstall their systems or want a consistent and reproducible setup.

---

## ✨ Features

- **Interactive Output**: Colored, emoji-enhanced logs for a pleasant experience
- **All-in-One Setup**: Installs everything from languages to desktop tools
- **Safe & Reproducible**: Includes version checks and installation summaries
- **Snap + APT + Manual**: Combines all sources for a complete environment
- **Post-Install Summary**: Clearly shows which tools were installed and their versions

---

## 🛠️ Included Tools

### 🧑‍💻 Core Development

- **Git** - Distributed version control
- **Node.js + npm** - JavaScript runtime and package manager
- **Rust + Cargo** - Systems programming language with modern tooling
- **Python 3** - Includes pip, venv, and development headers
- **Go** - Google’s systems language
- **Docker Engine & Compose Plugin** - Container tools
- **PostgreSQL** - Relational database
- **Redis** - In-memory key-value store
- **Zed Editor** - High-performance multiplayer code editor

### 🔧 CLI Utilities

- `curl`, `wget`, `gnupg`, `lsb-release`, `build-essential`, `unzip`
- `snapd`, `software-properties-common`, and core transport tools

### 🖥️ Desktop Applications

- **LibreOffice** - Office suite
- **Thunderbird** - Email client
- **VLC** - Media player
- **OBS Studio** - Streaming and screen recording
- **qBittorrent** - Torrent client
- **NordPass** (via Snap)
- **Postman** (via Snap)

---

## 📋 Requirements

- Ubuntu 25.04
- Internet connection
- `sudo` access

---

## 🚀 Quick Start

```bash
# 1. Download the script
wget https://github.com/mariusroyale/ubuntu-dev-setup/blob/0e1a6e9d52317097cfe4fbbf3c7fc2a482a17172/dev-setup.sh

OR

# Clone the repository
git clone git@github.com:mariusroyale/ubuntu-dev-setup.git

# 2. Make it executable
chmod +x dev-setup.sh

# 3. Run it
./dev-setup.sh
```

---

## 🧪 Installed Software Overview

| Tool                                                    | Source  | Notes                           |
|---------------------------------------------------------|---------|---------------------------------|
| `curl`                                                  | APT     |                                 |
| `wget`                                                  | APT     |                                 |
| `gpg`                                                   | APT     |                                 |
| `software-properties-common`                            | APT     |                                 |
| `apt-transport-https`                                   | APT     |                                 |
| `ca-certificates`                                       | APT     |                                 |
| `gnupg`                                                 | APT     |                                 |
| `lsb-release`                                           | APT     |                                 |
| `build-essential`                                       | APT     |                                 |
| `unzip`                                                 | APT     |                                 |
| `snapd`                                                 | APT     |                                 |
| `git`                                                   | APT     |                                 |
| `htop`                                                  | APT     |                                 |
| `jq`                                                    | APT     |                                 |
| `fzf`                                                   | APT     |                                 |
| `ripgrep`                                               | APT     |                                 |
| `bat`                                                   | APT     |                                 |
| `fd-find`                                               | APT     |                                 |
| `tree`                                                  | APT     |                                 |
| `tmux`                                                  | APT     |                                 |
| `ncdu`                                                  | APT     |                                 |
| `zoxide`                                                | APT     |                                 |
| `neovim`                                                | APT     |                                 |
| `nodejs` + `npm`                                        | NVM     | LTS version                     |
| `rust` + `cargo`                                        | Manual  | Installed via rustup            |
| `golang-go`                                             | APT     |                                 |
| `python3`                                               | APT     | Includes pip, venv              |
| `docker-ce`                                             | APT     |                                 |
| `docker-ce-cli`                                         | APT     |                                 |
| `containerd.io`                                         | APT     |                                 |
| `docker-compose-plugin`                                 | APT     |                                 |
| `redis-server`                                          | APT     |                                 |
| `postgresql`                                            | APT     | Includes contrib                |
| `sqlite3`                                               | APT     |                                 |
| `zsh`                                                   | APT     |                                 |
| `postman`                                               | Snap    |                                 |
| `brave`                                                 | Snap    |                                 |
| `qbittorrent`                                           | Snap    |                                 |
| `thunderbird`                                           | Snap    |                                 |
| `vlc`                                                   | Snap    |                                 |
| `obs-studio`                                            | Snap    |                                 |
| `libreoffice`                                           | Snap    |                                 |
| `ohmyz.sh`                                              | Manual  | https://ohmyz.sh/               |
| `zed`                                                   | Manual  | https://zed.dev/                |
| `nushell`                                               | Cargo   | Modern shell written in Rust    |
| `net-tools`                                             | APT     | ifconfig, netstat, etc          |
| `nvtop`                                                 | APT     | Monitor gpu usage               |
| `playerctl`                                             | APT     | Control media players w/ MPRIS  |
| `gnome-shell-extension-manager`                         | APT     | Manage GNOME Shell extensions   |

---

## 📝 Post-Installation Tips
1. **GitHub CLI Login**
```bash
gh auth login
```

2. **Change Default Shell to Zsh**
```bash
sudo apt install -y zsh
chsh -s $(which zsh)
```

3. **Verify Docker Installation**
```bash
docker run hello-world
```

4. **Monitor GPU Usage**
```bash
nvtop
```

```bash
# OR if you want to tinker a bit more ...
watch -n 1 nvidia-smi

# Monitor GPU Temperature
watch -n 1 nvidia-smi | grep -E 'GPU|Fan|Temp'

# List All Running GPU Processes
nvidia-smi pmon -c 1
nvidia-smi pmon -c 1 -s um

# Monitor GPU Memory Usage
watch -n 1 nvidia-smi | grep -E 'GPU|Fan|Temp|Memory'
```

5. **Monitor CPU Usage**
```bash
htop
```

6. **Monitor Memory Usage**
```bash
free -h
```

7. **Monitor Disk Usage**
```bash
df -h
```

8. **Monitor Network Usage**
```bash
nethogs
```

9. **Monitor System Logs**
```bash
journalctl -f
```

```bash
sudo usermod -aG docker $USER
newgrp docker
```

### Global NPM Permissions

```bash
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

### Rust Environment Not Found

  ```bash
  source ~/.cargo/env
  ```

### 🗃️ GIT LFS - https://git-lfs.com/

  Download: https://github.com/git-lfs/git-lfs/releases/download/v3.7.0/git-lfs-linux-amd64-v3.7.0.tar.gz  -> run install.sh with sudo

  Inside the GIT repository where you have large files (over 100mb), run the following commands:
  ```bash
  #1
  git lfs install
  #2 track
  git lfs track "*.psd"
  git lfs track bedrock_server
  ```
  That's it! You may run the rest of the GIT commands normally.

---

## Graphics

Running 5
```bash
-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 570.133.07             Driver Version: 570.133.07     CUDA Version: 12.8     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA GeForce RTX 3080        Off |   00000000:01:00.0  On |                  N/A |
|  0%   47C    P8             43W /  370W |     664MiB /  10240MiB |      0%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
```

## 📚 Documentation

Fan Control Linux: https://www.baeldung.com/linux/control-fan-speed
Keyboard Setup (Nuphy Air75 v2): https://getupnote.com/share/notes/ihWZQ7d8mebhejrlrJWo322IxQD3/d745e165-ed4c-4322-a693-d6d6f4b6c37b

## 🔧 Customization

You can modify the script to:

- Add or remove packages
- Add profiles or conditionals
- Include dotfiles, configs, or personal preferences
- Update package versions or use alternative package managers (e.g. `nvm`, `pyenv`)

---

## 🤝 Contributing

Pull requests welcome! Especially for:

- Additional tools or stacks
- Support for other distros
- Interactive prompts or profiles
- Bug fixes or optimizations

---

## 📄 License

MIT License — see the `LICENSE` file for details.

---

## 🙏 Acknowledgements

- Thanks to the open-source ecosystem and Ubuntu community
- Inspired by community dotfiles and setup scripts
- Special thanks to all maintainers and contributors

---

**Happy coding!** 🚀🧑‍💻✨
