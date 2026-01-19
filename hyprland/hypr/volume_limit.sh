#!/bin/bash
# 1. Get current volume (e.g., 1.25)
CURRENT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
LIMIT=1.8

# 2. Check if we are below the limit
if (( $(echo "$CURRENT < $LIMIT" | bc -l) )); then
    # If safe, increase volume
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
else
    # If unsafe, force it back to exactly 1.8 (180%) just in case
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 1.8
fi
