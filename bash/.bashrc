alias bashconf='nvim ~/.bashrc'
alias bashreload='source ~/.bashrc'
alias cat='batcat'
alias du='dust'
alias ll='eza -lah --icons=auto'
alias ls='eza --icons=auto'
alias niriconf='nvim ~/.config/niri/config.kdl'
alias startdownloaderbot='cd ~/projects/tg-downloader-bot && source .venv/bin/activate && python bot.py'
alias code='codium'
alias off='systemctl poweroff'
alias niri-miner='genact -m cryptomining'
alias niri-c2ctl='genact -m botnet'
alias kbuild='genact -m kernel_compile'
alias niri-log='genact -m weblog'

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

export PATH="$HOME/.local/npm/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

. "$HOME/.local/bin/env"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Go
export PATH="/usr/local/go/bin:$PATH"

# Rust (rustup)
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# C++ helpers
csave() {
  local out="${1%.cpp}"
  g++ "$1" -o "$out"
}
crun() {
  local out="${1%.cpp}"
  g++ "$1" -o "$out" && ./"$out"
}
