#!/bin/bash

choice=$(echo -e "Exit\nCancel" | wofi --dmenu --width=200 --height=100 --prompt "Exit Sway?" --hide-scroll)

if [ "$choice" = "Exit" ]; then
    swaymsg exit
fi

