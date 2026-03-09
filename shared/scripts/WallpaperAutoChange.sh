#!/usr/bin/env bash
# /* ---- 💫 https://github.com/LinuxBeginnings 💫 ---- */

# 1. Define the refresh script path
wallust_refresh="$HOME/scripts/RefreshNoWaybar.sh"

# 2. Get the focused monitor name
focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')

# 3. Validate input directory
if [[ $# -lt 1 ]] || [[ ! -d "$1" ]]; then
    echo "Usage: $0 <dir containing images>"
    exit 1
fi

# 4. Transition settings
export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_TYPE=simple
INTERVAL=1800

# 5. The Loop
while true; do
    # Added '-type f' so it only grabs files, NOT the directory itself
    find "$1" -type f \
        | while read -r img; do
            echo "$((RANDOM % 1000)):$img"
        done \
        | sort -n | cut -d':' -f2- \
        | while read -r img; do
            # Apply the wallpaper
            swww img -o "$focused_monitor" "$img"
            
            # Execute the refresh script if it exists
            if [[ -f "$wallust_refresh" ]]; then
                bash "$wallust_refresh"
            fi
            
            sleep "$INTERVAL"
        done
done
