#!/bin/bash

# --- OPTIONS ---
O_WIFI="   Wi-Fi"
O_BT="   Bluetooth"
O_AUDIO="   Audio Mixer"
O_SET="   Settings"
O_TERM="   Terminal"
O_EXIT="   Logout"

# --- SHOW MENU (Use Cyberpunk Theme) ---
CHOICE=$(echo -e "$O_WIFI\n$O_BT\n$O_AUDIO\n$O_SET\n$O_TERM\n$O_EXIT" | rofi -dmenu -p "COMMAND DECK" -theme ~/.config/rofi/config.rasi -theme-str 'window { width: 500px; height: 300px; } listview { columns: 2; lines: 3; }')

# --- EXECUTE ---
case "$CHOICE" in
    "$O_WIFI")
        nm-connection-editor ;;  # Opens the reliable Wifi Window
    "$O_BT")
        blueman-manager ;;       # Opens the reliable Bluetooth Window
    "$O_AUDIO")
        pavucontrol ;;           # Opens Audio Mixer
    "$O_SET")
        gnome-control-center ;;  # General Settings
    "$O_TERM")
        ptyxis ;;                # Terminal
    "$O_EXIT")
        hyprctl dispatch exit ;;
esac
