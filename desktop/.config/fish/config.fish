starship init fish | source
set -gx COLORTERM truecolor

function fish_greeting
    set -l mauve "CBA6F7"
    set_color $mauve --bold

    set -l width (tput cols)
    # ﷽ renders as 1 col wide; adjust to 2 if it looks off-center
    set -l pad (math -s0 "($width - 1) / 2")
    set -l pad_str (string repeat -n $pad " ")

    echo ""
    # \e#3 = top half of double-height line
    # \e#4 = bottom half — must repeat the exact same content
    printf "\e#3%s\uFDFD\n" $pad_str
    printf "\e#4%s\uFDFD\n" $pad_str
    echo ""

    set_color normal
end

fish_add_path $HOME/.local/bin
fish_add_path $HOME/bin
fish_add_path $HOME/.cargo/bin
