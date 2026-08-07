

# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

HISTFILESIZE=100000
HISTSIZE=10000

shopt -s histappend
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

alias -- bashconf='nvim ~/.bashrc'
alias -- bashreload='source ~/.bashrc'
alias -- cat=bat
alias -- du=dust
alias -- flakeconf='sudo nvim /etc/nixos/flake.nix'
alias -- ll='eza -lah --icons'
alias -- ls='eza --icons'
alias -- niriconf='nvim ~/.config/niri/config.kdl'
alias -- nixcatconf='sudo cat /etc/nixos/configuration.nix'
alias -- nixclean='sudo nix-collect-garbage -d'
alias -- nixconf='sudo nvim /etc/nixos/configuration.nix'
alias -- nixgenerations='sudo nix-env --list-generations --profile /nix/var/nix/profiles/system'
alias -- rebuild='sudo nixos-rebuild switch --flake /etc/nixos#niri'
alias -- startdownloaderbot='cd ~/coding/telegram_downloader_bot && source .venv/bin/activate && python bot.py'

if [[ ! -v BASH_COMPLETION_VERSINFO ]]; then
  . "/nix/store/a480ilnq575qgwy8fjpya9pr0ryj9dw3-bash-completion-2.17.0/etc/profile.d/bash_completion.sh"
fi

export PATH="$HOME/.npm-global/bin:$PATH"

if [[ $TERM != "dumb" ]]; then
  eval "$(/nix/store/pg8rqv0924k2pyjp9dx70jiayy8biy40-starship-1.25.1/bin/starship init bash --print-full-init)"
fi

