#!/bin/bash

choice=$(echo -e "Exit\nCancel" | wofi --dmenu --width=200 --height=100 --prompt "Exit Hyprland?" --hide-scroll)

if [ "$choice" = "Exit" ]; then
    hyprctl dispatch exit
fi

