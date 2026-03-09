# .bashrc

# Source global definitions

if [ -f /etc/bashrc ]; then

    . /etc/bashrc

fi



if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then

    PATH="$HOME/.local/bin:$HOME/bin:$PATH"

fi

export PATH



alias get_idf='. $HOME/esp/esp-idf/export.sh'


if [ -d ~/.bashrc.d ]; then

    for rc in ~/.bashrc.d/*; do

        if [ -f "$rc" ]; then

            . "$rc"

        fi

    done

fi


# --- Custom MacBook Pro Config ---


# --- Universal Trackpad Toggle (GNOME & Hyprland) ---

if [[ "$XDG_CURRENT_DESKTOP" == *GNOME* ]]; then
    # GNOME Protocol
    alias moff='gsettings set org.gnome.desktop.peripherals.touchpad send-events "disabled"'
    alias mon='gsettings set org.gnome.desktop.peripherals.touchpad send-events "enabled"'
else
    # Hyprland Protocol
    alias moff='hyprctl keyword "device:apple-spi-touchpad:enabled" false'
    alias mon='hyprctl keyword "device:apple-spi-touchpad:enabled" true'
fi

FILE="/home/trkbytes/.cache/tmux-powerkit/keybinding_conflicts.log"

if [ -e "$FILE" ]; then 
    rm -f "$FILE"
fi
# Initialize Starship (MUST be before tmux auto-start)

eval "$(starship init bash)"


# 2. Auto-start Tmux

# Only start if tmux is installed, we are in an interactive shell,

# and not already inside a tmux/screen session.

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux new-session fish
fi 

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.dotfiles/shared/scripts:$PATH"
