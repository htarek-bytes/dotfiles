#!/bin/bash
# Get current workspace ID using grep/awk (no extra tools needed)
CURRENT=$(hyprctl monitors | grep "active workspace:" | awk '{print $3}' | cut -d'(' -f1)

if [ "$CURRENT" == "10" ]; then
    # We are on Desktop -> Go Back
    hyprctl dispatch workspace previous
else
    # We are working -> Go to Desktop (Workspace 10)
    hyprctl dispatch workspace 10
fi
