# ~/.bashrc

# Exit if not interactive
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'
alias update='yay'
alias n='nvim'
alias mongo_start='mongod --dbpath ~/.local/share/mongodb/ --bind_ip 127.0.0.1 --port 27017'

# close from personal github
clone() {
  if [ -z "$1" ]; then
    echo "Usage: clone_personal <repo-name>"
    return 1
  fi
  git clone "git@github.com:arjuncgore/$1.git"
}

# Editor
export EDITOR=nvim

# Bash completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# SDKMAN!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Wayland + Electron + AMD tweaks
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland,x11
export MOZ_ENABLE_WAYLAND=1
export WLR_NO_HARDWARE_CURSORS=1
export LIBVA_DRIVER_NAME=radeonsi
export ELECTRON_OZONE_PLATFORM_HINT=auto

# Add spicetify (keep here too if you sometimes start non-login shells)
export PATH="$HOME/.spicetify:$PATH"
export PATH="$HOME/bin:$PATH"

# yazi helper
y() {
  local tmp="$(mktemp -t 'yazi-cwd.XXXXXX')" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Starship (run once)
eval "$(starship init bash)"
