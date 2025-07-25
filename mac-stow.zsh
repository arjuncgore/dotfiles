#!/bin/zsh

configs=(
aerospace
raycast
ghostty
nvim
zsh
fastfetch
yazi
)

for config in "${configs[@]}"; do
    stow "${config}"
done
