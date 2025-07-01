
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

- Ubuntu 20.04 LTS or newer
- Internet connection
- `sudo` access

---

## 🚀 Quick Start

```bash
# 1. Download the script
wget https://raw.githubusercontent.com/your-username/ubuntu-dev-setup/main/dev-setup.sh

# 2. Make it executable
chmod +x dev-setup.sh

# 3. Run it
./dev-setup.sh
```

---

## 🧪 Installed Software Overview

| Tool              | Source | Notes                     |
|-------------------|--------|---------------------------|
| `git`             | APT    |                           |
| `nodejs` + `npm`  | APT    | LTS version               |
| `rust` + `cargo`  | Manual | Installed via rustup      |
| `go`              | APT    |                           |
| `python3`         | APT    | Includes pip, venv        |
| `docker`          | APT    | Includes Compose plugin   |
| `redis-server`    | APT    |                           |
| `postgresql`      | APT    | Includes contrib          |
| `zed`             | Manual | Installed via official    |
| `nordpass`        | Snap   |                           |
| `postman`         | Snap   |                           |
| `libreoffice`     | APT    |                           |
| `thunderbird`     | APT    |                           |
| `vlc`             | APT    |                           |
| `obs-studio`      | PPA    | PPA added automatically   |
| `qbittorrent`     | APT    |                           |

---

## 📝 Post-Installation Tips

1. **Use Docker Without `sudo`**
   ```bash
   sudo usermod -aG docker $USER
   newgrp docker
   ```

2. **Set up SSH Keys**
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   cat ~/.ssh/id_ed25519.pub
   ```

3. **GitHub CLI Login**
   ```bash
   gh auth login
   ```

4. **Change Default Shell to Zsh**
   ```bash
   sudo apt install -y zsh
   chsh -s $(which zsh)
   ```

5. **Verify Docker Installation**
   ```bash
   docker run hello-world
   ```

---

## 🐛 Troubleshooting

### Permission Errors

```bash
chmod +x dev-setup.sh
```

### Docker Group Issues

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

---

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
