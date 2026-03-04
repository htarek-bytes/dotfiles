#!/bin/bash
# Hide the active window one by one (like macOS Command+H)

# Get the active window address
ACTIVE_WINDOW=$(hyprctl activewindow -j | jq -r '.address')

if [ "$ACTIVE_WINDOW" = "null" ] || [ -z "$ACTIVE_WINDOW" ]; then
    exit 0
fi

# Move window to special workspace (hidden)
hyprctl dispatch movetoworkspacesilent special:hidden,$ACTIVE_WINDOW
