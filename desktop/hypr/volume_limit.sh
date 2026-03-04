#!/bin/bash
CURRENT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
LIMIT=1.8
if (( $(echo "$CURRENT < $LIMIT" | bc -l) )); then
    wpctl set-volume -l $LIMIT @DEFAULT_AUDIO_SINK@ 5%+
fi
