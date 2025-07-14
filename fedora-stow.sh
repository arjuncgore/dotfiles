#!/bin/bash

configs=(
thunar
wofi
ghostty
waybar
bash
nvim
swayfed
waywallfed
)

for config in "${configs[@]}"; do
    stow "${config}"
done
