alias bashconf='nvim ~/.bashrc'
alias bashreload='source ~/.bashrc'
alias cat='bat'
alias du='dust'
alias ll='eza -lah --icons=auto'
alias ls='eza --icons=auto'
alias niriconf='nvim ~/.config/niri/config.kdl'
alias startdownloaderbot='cd ~/projects/tg-downloader-bot && source .venv/bin/activate && python bot.py'
alias botstart='cd ~/projects/tg-downloader-bot && source .venv/bin/activate && nohup python bot.py > /dev/null 2>&1 & echo $! > .bot.pid && echo "bot started (pid $(cat .bot.pid))"'
alias botstop='if [ -f ~/projects/tg-downloader-bot/.bot.pid ]; then kill $(cat ~/projects/tg-downloader-bot/.bot.pid) 2>/dev/null && rm ~/projects/tg-downloader-bot/.bot.pid && echo "bot stopped"; else echo "no pid file, bot not running"; fi'
alias botstatus='if [ -f ~/projects/tg-downloader-bot/.bot.pid ] && kill -0 $(cat ~/projects/tg-downloader-bot/.bot.pid) 2>/dev/null; then echo "bot running (pid $(cat ~/projects/tg-downloader-bot/.bot.pid))"; else echo "bot not running"; fi'
alias code='codium'
alias off='systemctl poweroff'
alias sshon='sudo systemctl start tailscaled sshd && echo "tailscaled + sshd started"'
alias sshoff='sudo systemctl stop tailscaled sshd && echo "tailscaled + sshd stopped"'
alias sshstatus='systemctl status tailscaled sshd --no-pager'
alias wisecow='fortune wisdom | cowsay | lolcat'
alias nerdcow='fortune linux computers science | cowsay | lolcat'
alias rudecow='fortune /usr/share/fortune/off/black-humor /usr/share/fortune/off/cookie /usr/share/fortune/off/drugs /usr/share/fortune/off/ethnic /usr/share/fortune/off/fortunes /usr/share/fortune/off/hphobia /usr/share/fortune/off/knghtbrd /usr/share/fortune/off/limerick /usr/share/fortune/off/linux /usr/share/fortune/off/misandry /usr/share/fortune/off/miscellaneous /usr/share/fortune/off/misogyny /usr/share/fortune/off/privates /usr/share/fortune/off/racism /usr/share/fortune/off/sex /usr/share/fortune/off/vulgarity /usr/share/fortune/off/zippy | cowsay | lolcat'
alias toilet='toilet -f pagga'
alias fastfetch='echo "" && fastfetch'

# genact fun
alias niri-miner='genact -m cryptomining'
alias niri-c2ctl='genact -m botnet'
alias kbuild='genact -m kernel_compile'
alias niri-log='genact -m weblog'

export PATH="$HOME/.local/npm/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"

# Flutter
export FLUTTER_HOME="$HOME/dev/flutter"
export PATH="$FLUTTER_HOME/bin:$PATH"

# Android SDK
export ANDROID_HOME="$HOME/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/35.0.0:$PATH"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Rust (rustup)
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

. "$HOME/.local/bin/env"

# C++ helpers
csave() {
  local out="${1%.cpp}"
  g++ "$1" -o "$out"
}
crun() {
  local out="${1%.cpp}"
  g++ "$1" -o "$out" && ./"$out"
}

# ble.sh
[[ $- == *i* ]] && [[ -f ~/.local/share/blesh/ble.sh ]] && source ~/.local/share/blesh/ble.sh --noattach
[[ ${BLE_VERSION-} ]] && ble-attach
export CHROME_EXECUTABLE="/usr/bin/firefox-devedition"


# Added by Antigravity CLI installer
export PATH="/home/niri/.local/bin:$PATH"

pyrun() { python3 "$@"; }
