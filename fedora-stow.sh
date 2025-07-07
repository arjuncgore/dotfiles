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
)

for config in "${configs[@]}"; do
    stow "${config}"
done
