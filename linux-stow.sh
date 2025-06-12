#!/bin/bash

configs=(
thunar
wofi
ghostty
waybar
bash
nvim
sway
waywall
)

for config in "${configs[@]}"; do
    stow "${config}"
done
