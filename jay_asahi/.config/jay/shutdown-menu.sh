#!/bin/bash

choice=$(echo -e "Shutdown\nCancel" | wofi --dmenu --width=100 --height=140 --prompt "Shutdown?" --hide-scroll)

if [ "$choice" = "Shutdown" ]; then
    shutdown now
fi

