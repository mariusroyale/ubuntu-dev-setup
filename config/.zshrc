# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"  # You can change this to your preferred theme

# Enable plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# --- HISTORY SETTINGS (from .bashrc) ---
HISTSIZE=1000
SAVEHIST=2000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# --- TERMINAL TITLE ---
case $TERM in
xterm*|rxvt*)
  precmd() { print -Pn "\e]0;%n@%m: %~\a" }
  ;;
esac

# --- LS COLORS AND ALIASES (from .bashrc) ---
if command -v dircolors > /dev/null; then
  eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# --- LONG COMMAND ALERT ---
alias alert='notify-send --urgency=low -i "$([[ $? = 0 ]] && echo terminal || echo error)" "$(fc -ln -1 | sed -e "s/^[ \t]*[0-9]\+[ \t]*//;s/[;&|]\s*alert$//")"'

# --- NVM (Node Version Manager) ---
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# --- Rust (cargo) ---
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# --- OPTIONAL: CUSTOM ALIASES FILE ---
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

# --- COMPLETION ---
autoload -Uz compinit
compinit

# --- AUTO-RESIZE TERMINAL WINDOW ---
autoload -Uz resize
TRAPWINCH() { resize >/dev/null }

# --- GLOBSTAR (like Bash's ** pattern) ---
setopt GLOBSTAR_SHORT
