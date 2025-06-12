#!/bin/zsh

configs=(
aerospace
raycast
ghostty
nvim
zsh
)

for config in "${configs[@]}"; do
    stow "${config}"
done
