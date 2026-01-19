#!/bin/bash
# Cycle through Hyprland's blue wallpapers

WALLPAPER_DIR="/usr/share/hypr"
STATE_FILE="$HOME/.config/hypr/.current_wallpaper"

# Get all wallpapers from /usr/share/hypr (the default blue ones)
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | sort)

if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    notify-send "No wallpapers found" "Check $WALLPAPER_DIR"
    exit 1
fi

# Read current index or start at 0
CURRENT_INDEX=0
if [ -f "$STATE_FILE" ]; then
    CURRENT_INDEX=$(cat "$STATE_FILE")
fi

# Increment and wrap around
CURRENT_INDEX=$(( (CURRENT_INDEX + 1) % ${#WALLPAPERS[@]} ))

# Save new index
echo "$CURRENT_INDEX" > "$STATE_FILE"

# Set wallpaper
WALLPAPER="${WALLPAPERS[$CURRENT_INDEX]}"

# Kill swaybg and restart with new wallpaper
pkill swaybg
swaybg -i "$WALLPAPER" &

notify-send "Wallpaper Changed" "$(basename "$WALLPAPER")"
