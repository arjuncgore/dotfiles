#!/bin/zsh

configs=(
aerospace
raycast
ghostty
nvim
zsh
fastfetch
)

for config in "${configs[@]}"; do
    stow "${config}"
done
