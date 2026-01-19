#!/bin/bash

# 1. Get raw window data
WINDOW=$(hyprctl activewindow -j)

# 2. validation: Did we get a window?
if [ -z "$WINDOW" ] || [ "$WINDOW" == "{}" ]; then
    notify-send "Screenshot Failed" "No active window selected"
    exit 1
fi

# 3. Extract coordinates (X,Y) and Size (WxH) using jq
# We use 'tr -d "\n"' to strip any invisible newline characters that break grim
GEOM=$(echo "$WINDOW" | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | tr -d '\n')

# 4. Final Safety Check: Does GEOM look like "10,10 500x500"?
# If it contains "null" or weird characters, stop.
if [[ "$GEOM" == *"null"* ]] || [[ -z "$GEOM" ]]; then
    notify-send "Screenshot Failed" "Invalid geometry detected"
    exit 1
fi

# 5. Snap
grim -g "$GEOM" - | wl-copy
notify-send "Screenshot Taken" "Active tile copied to clipboard"
