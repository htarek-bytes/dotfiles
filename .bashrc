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


# 1. Trackpad Toggle (mon/moff)

# 'moff' disables the trackpad (useful when typing)

alias moff='gsettings set org.gnome.desktop.peripherals.touchpad send-events disabled'

# 'mon' enables it back

alias mon='gsettings set org.gnome.desktop.peripherals.touchpad send-events enabled'

# Mouse Toggle for MacBook Pro 2017
# Correct syntax with brackets []
# Silent Mouse Toggle
alias moff='hyprctl keyword "device[apple-spi-touchpad]:enabled" false > /dev/null'
alias mon='hyprctl keyword "device[apple-spi-touchpad]:enabled" true > /dev/null'

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

    exec tmux

fi 
export PATH="$HOME/.cargo/bin:$PATH"
