#!/bin/bash

# Folder containing the anime wallpapers
DIR="/usr/share/hyprland"

# Pick a random image from that folder
RANDOM_WALL=$(find $DIR -name "wall*.png" | shuf -n 1)

# Tell Hyprpaper to load and set it
hyprctl hyprpaper preload "$RANDOM_WALL"
hyprctl hyprpaper wallpaper ",$RANDOM_WALL"

# Optional: Unload unused wallpapers to save RAM (cleanup)
hyprctl hyprpaper unload unused
