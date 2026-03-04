#!/bin/bash

# 1. Define the filename
FILE=~/Pictures/Screenshot_$(date +'%Y-%m-%d-%H%M%S.png')

# 2. Take the screenshot
# 'grim -' outputs to the "stream" instead of a file.
# 'tee' saves that stream to $FILE *and* passes it on.
# 'wl-copy' takes the passed stream and puts it in the clipboard.
grim - | tee "$FILE" | wl-copy

# 3. Notify
notify-send "Full Screen" "Saved to File & Clipboard"
