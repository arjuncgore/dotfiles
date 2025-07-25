#!/bin/bash

configs=(
thunar
wofi
ghostty
waybar
bash
nvim
swayfed
waywall
yazi
)

for config in "${configs[@]}"; do
    stow "${config}"
done
