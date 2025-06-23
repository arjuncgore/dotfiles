# ~/.bashrc

# Exit if not running interactively
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'
alias update='sudo pacman -Syu'

# Set editor
export EDITOR=nvim

# Enable Starship prompt
eval "$(starship init bash)"

# Enable bash completion if available
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="$HOME/bin:$PATH"

# Wayland + Electron + AMD compat
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland,x11
export MOZ_ENABLE_WAYLAND=1
export WLR_NO_HARDWARE_CURSORS=1
export LIBVA_DRIVER_NAME=radeonsi
export ELECTRON_OZONE_PLATFORM_HINT=auto

