starship init fish | source
set -gx COLORTERM truecolor

function fish_greeting
    set -l mauve "CBA6F7"
    
    # 1. Tenter d'agrandir la police (ne fonctionne pas sur tous les terminaux)
    # On envoie un code de contrôle pour changer la taille
    echo -e "\e]50;SetFont=JetBrainsMono Nerd Font:size=30\a"

    # 2. Affichage de la Basmalah
    echo ""
    set_color $mauve --bold
    set -l width (tput cols)
    set -l pad (math -s0 "($width - 10) / 2")
    echo (string repeat -n $pad " ")(printf "\uFDFD")
    echo ""

    # 3. On attend un peu pour que tu puisses la voir
    sleep 0.1

    # 4. On réinitialise à la taille normale (ex: 12)
    echo -e "\e]50;SetFont=JetBrainsMono Nerd Font:size=12\a"
    set_color normal
end

fish_add_path $HOME/.local/bin
fish_add_path $HOME/bin
fish_add_path $HOME/.cargo/bin
