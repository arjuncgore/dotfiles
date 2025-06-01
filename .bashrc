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

