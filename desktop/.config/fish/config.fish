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


fish_add_path $HOME/.local/bin
fish_add_path $HOME/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.dotfiles/shared/scripts


