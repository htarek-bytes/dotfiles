if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source
set -gx COLORTERM truecolor

function fish_greeting
    set -l mauve "CBA6F7"
    
    echo ""
    set_color $mauve --bold
    set -l width (tput cols)
    set -l pad (math -s0 "($width - 10) / 2")
    echo (string repeat -n $pad " ")(printf "\uFDFD")
    echo ""
    
    # 3. On attend un peu pour que tu puisses la voir
    sleep 0.1

    echo "IFT-1575: 22 avril, IFT-3336: 27 avril, IFT-2245: 28 avril"

    set_color normal
end

# --- Universal Trackpad Toggle (Final Hardware Protocol) ---
if string match -q "*GNOME*" "$XDG_CURRENT_DESKTOP"
    alias moff='gsettings set org.gnome.desktop.peripherals.touchpad send-events "disabled"'
    alias mon='gsettings set org.gnome.desktop.peripherals.touchpad send-events "enabled"'
else
    # Hyprland Block Syntax (Using square brackets)
    alias moff='hyprctl keyword "device[apple-spi-touchpad]:enabled" 0 > /dev/null 2>&1'
    alias mon='hyprctl keyword "device[apple-spi-touchpad]:enabled" 1 > /dev/null 2>&1'
end

# Add shared scripts to the path
fish_add_path $HOME/.dotfiles/shared/scripts

# Add cargo to the path
fish_add_path $HOME/.cargo/bin

fish_add_path $HOME/.local/bin
fish_add_path $HOME/bin

