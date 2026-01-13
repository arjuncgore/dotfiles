#!/bin/bash

choice=$(echo -e "Shutdown\nCancel" | wofi --dmenu --width=200 --height=100 --prompt "Shutdown?" --hide-scroll)

if [ "$choice" = "Shutdown" ]; then
    shutdown now
fi

