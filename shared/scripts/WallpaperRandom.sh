#!/usr/bin/env bash

# Use the absolute path in your dotfiles
WALL_DIR="$HOME/.dotfiles/shared/.config/wallpapers"
RANDOM_WALL=$(find "$WALL_DIR" -type f | shuf -n 1)

if [ -n "$RANDOM_WALL" ]; then
    # 1. Set the wallpaper
    swww img "$RANDOM_WALL" --transition-type simple
    
    # 2. THE BRIDGE: Create the pointer file that Effects.sh needs
    # We must use the path the Effects script expects
    echo "$RANDOM_WALL" > "$HOME/.config/hypr/.wallpaper_current"
    
    # 3. Refresh UI
    [ -f ~/scripts/RefreshNoWaybar.sh ] && bash ~/scripts/RefreshNoWaybar.sh
fi
