#!/usr/bin/env bash

# 1. Environment Setup
BRIDGE_FILE="$HOME/.config/hypr/.wallpaper_current"
wallpaper_output="$HOME/.config/hypr/wallpaper_effects/.wallpaper_modified"
SCRIPTSDIR="$HOME/scripts"
rofi_theme="$HOME/.config/rofi/config-wallpaper-effect.rasi"

mkdir -p "$HOME/.config/hypr/wallpaper_effects"

# 2. Get current wall with quoting safety
if [ -f "$BRIDGE_FILE" ]; then
    wallpaper_current=$(cat "$BRIDGE_FILE")
else
    wallpaper_current=$(find "$HOME/.dotfiles/shared/.config/wallpapers" -type f | head -n 1)
fi

# 3. Define Effects with literal quotes for the eval
declare -A effects=(
    ["No Effects"]="cp \"$wallpaper_current\" \"$wallpaper_output\""
    ["Black & White"]="magick \"$wallpaper_current\" -colorspace gray \"$wallpaper_output\""
    ["Blurred"]="magick \"$wallpaper_current\" -blur 0x10 \"$wallpaper_output\""
    ["Charcoal"]="magick \"$wallpaper_current\" -charcoal 0x5 \"$wallpaper_output\""
    ["Edge Detect"]="magick \"$wallpaper_current\" -edge 1 \"$wallpaper_output\""
    ["Negate"]="magick \"$wallpaper_current\" -negate \"$wallpaper_output\""
    ["Oil Paint"]="magick \"$wallpaper_current\" -paint 4 \"$wallpaper_output\""
    ["Posterize"]="magick \"$wallpaper_current\" -posterize 4 \"$wallpaper_output\""
    ["Sepia Tone"]="magick \"$wallpaper_current\" -sepia-tone 65% \"$wallpaper_output\""
)

main() {
    choice=$(printf "%s\n" "${!effects[@]}" | LC_COLLATE=C sort | rofi -dmenu -i -config "$rofi_theme")

    if [[ -n "$choice" ]]; then
        notify-send "Processing..." "Applying $choice"
        
        # Clean old output
        rm -f "$wallpaper_output"

        # Execute
        eval "${effects[$choice]}"

        # 4. The Safety Wait (Max 5 seconds)
        for i in {1..50}; do
            [ -f "$wallpaper_output" ] && break
            sleep 0.1
        done

        if [ -f "$wallpaper_output" ]; then
            swww img "$wallpaper_output" --transition-type wipe
            wallust run "$wallpaper_output" -s
            bash "$SCRIPTSDIR/RefreshNoWaybar.sh"
        else
            notify-send "Error" "Magick failed to create the image."
        fi
    fi
}

[ -n "$(pidof rofi)" ] && pkill rofi
main
