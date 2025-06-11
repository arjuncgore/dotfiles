#!/bin/zsh

configs=(
aerospace
raycast
alacritty
nvim
zsh
)

for config in "${configs[@]}"; do
    stow "${config}"
done
