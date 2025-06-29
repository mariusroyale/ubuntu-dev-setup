# 🚀 Ubuntu Development Environment Setup

A modern, interactive bash script to quickly set up a complete development environment on Ubuntu Linux. Perfect for developers who frequently reinstall their systems or want to standardize their development setup.

## ✨ Features

- **Interactive Installation**: Choose which tools to install with friendly prompts
- **Modern UI**: Beautiful colored output with emojis and progress indicators
- **Comprehensive Toolset**: Installs the most popular development tools
- **Safe Execution**: Includes error handling and confirmation prompts
- **Customizable**: Easy to modify for your specific needs

## 🛠️ Included Tools

### Core Development Tools
- **Git** - Version control system + GitHub CLI
- **Node.js** - JavaScript runtime with npm and optional Yarn
- **Rust** - Systems programming language with Cargo
- **Python** - Python 3 with pip, venv, pipenv, and poetry
- **Go** - Go programming language

### Infrastructure & Databases
- **Docker** - Containerization platform with Docker Compose
- **Redis** - In-memory data structure store
- **PostgreSQL** - Advanced relational database

### Editors & IDEs
- **Zed** - High-performance, multiplayer code editor

### Utilities & Enhancements
- **CLI Tools** - htop, tree, jq, bat, exa
- **Essential Build Tools** - build-essential, curl, wget, and more

## 🚀 Quick Start

1. **Download the script:**
   ```bash
   wget https://raw.githubusercontent.com/your-username/ubuntu-dev-setup/main/dev-setup.sh
   ```

2. **Make it executable:**
   ```bash
   chmod +x dev-setup.sh
   ```

3. **Run the script:**
   ```bash
   ./dev-setup.sh
   ```

## 📋 Requirements

- Ubuntu 20.04 LTS or newer
- Internet connection
- sudo privileges

## 🎯 Usage

The script will guide you through the installation process with interactive prompts:

1. **Welcome Screen**: Overview of tools to be installed
2. **Tool Selection**: Choose which tools you want to install
3. **Configuration**: Set up Git credentials and other preferences
4. **Installation**: Automated installation with progress updates
5. **Summary**: Review of installed tools and next steps

## ⚙️ Customization

You can easily customize the script by:

- **Adding new tools**: Add installation functions following the existing pattern
- **Modifying tool versions**: Update version numbers in the script
- **Changing default selections**: Modify the ask_yes_no prompts
- **Adding configurations**: Extend the configuration sections

## 🔧 Manual Installation

If you prefer to install tools individually, here are the key commands:

### Git & GitHub CLI
```bash
sudo apt install -y git
# Configure Git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Install GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list
sudo apt update && sudo apt install -y gh
```

### Node.js
```bash
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
npm install -g yarn
```

### Rust
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
```

### Docker
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker $USER
```

## 🐛 Troubleshooting

### Common Issues

**Permission Denied Errors**
```bash
chmod +x dev-setup.sh
```

**Docker Permission Issues**
```bash
sudo usermod -aG docker $USER
newgrp docker
# Or restart your session
```

**Node.js Global Package Permissions**
```bash
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

**Rust Environment Not Found**
```bash
source ~/.cargo/env
# Or restart your terminal
```

## 📝 Post-Installation Steps

After running the script, consider these additional setup steps:

1. **SSH Keys for Git**:
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   cat ~/.ssh/id_ed25519.pub
   # Add to GitHub/GitLab
   ```

2. **GitHub CLI Authentication**:
   ```bash
   gh auth login
   ```

3. **Docker Test**:
   ```bash
   docker run hello-world
   ```

4. **VS Code Extensions**:
   - Install your favorite extensions
   - Sync settings if you have VS Code account

5. **Zsh as Default Shell**:
   ```bash
   chsh -s $(which zsh)
   ```

## 🔄 Updates

To update the script with new tools or versions:

1. Fork this repository
2. Modify `dev-setup.sh`
3. Test your changes
4. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. Areas where contributions are especially welcome:

- Adding support for more Linux distributions
- Including additional development tools
- Improving error handling
- Adding more configuration options
- Better documentation

## ⭐ Star History

If this script saved you time, please consider giving it a star! ⭐

## 🙏 Acknowledgments

- Thanks to all the open-source projects that make development easier
- Inspired by various dotfiles and setup scripts from the community
- Special thanks to the Ubuntu community for their excellent documentation

---

**Happy Coding!** 🚀✨
