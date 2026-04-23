#!/bin/bash

choice=$(echo -e "Exit\nCancel" | wofi --dmenu --width=100 --height=140 --prompt "Exit Jay?" --hide-scroll)

if [ "$choice" = "Exit" ]; then
    jay quit
fi

