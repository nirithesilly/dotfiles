alias -- bashconf='nvim ~/.bashrc'
alias -- bashreload='source ~/.bashrc'
alias -- cat='bat'
alias -- du='dust'
alias -- ll='eza -lah --icons=auto'
alias -- ls='eza --icons=auto'
alias -- niriconf='nvim ~/.config/niri/config.kdl'
alias -- startdownloaderbot='cd ~/projects/tg-downloader-bot && source .venv/bin/activate && python bot.py'
alias -- update='sudo pacman -Syu'
alias -- search='pacman -Ss'

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

export PATH="$HOME/.local/npm/bin:$PATH"

# Hermes Agent — ensure ~/.local/bin is on PATH
export PATH="$HOME/.local/bin:$PATH"
