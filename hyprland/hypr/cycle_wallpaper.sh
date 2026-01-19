#!/bin/bash
DIR="/usr/share/hyprland"
RANDOM_WALL=$(find $DIR -name "wall*.png" | shuf -n 1)
hyprctl hyprpaper preload "$RANDOM_WALL"
hyprctl hyprpaper wallpaper ",$RANDOM_WALL"
hyprctl hyprpaper unload unused
