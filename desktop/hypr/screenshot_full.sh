#!/bin/bash
FILE=~/Pictures/Screenshot_$(date +'%Y-%m-%d-%H%M%S.png')
grim - | tee "$FILE" | wl-copy
notify-send "Full Screenshot taken"
