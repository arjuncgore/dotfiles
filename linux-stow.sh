#!/bin/bash

configs=(
thunar
wofi
alacritty
waybar
bash
nvim
sway
waywall
)

for config in "${configs[@]}"; do
    stow "${config}"
done
