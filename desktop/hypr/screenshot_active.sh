#!/bin/bash
WINDOW=$(hyprctl activewindow -j)
if [ -z "$WINDOW" ] || [ "$WINDOW" == "{}" ]; then
    notify-send "Screenshot Failed" "No active window selected"
    exit 1
fi
GEOM=$(echo "$WINDOW" | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | tr -d '\n')
if [[ "$GEOM" == *"null"* ]] || [[ -z "$GEOM" ]]; then
    notify-send "Screenshot Failed" "Invalid geometry detected"
    exit 1
fi
grim -g "$GEOM" - | wl-copy
notify-send "Screenshot Taken from active tile"
