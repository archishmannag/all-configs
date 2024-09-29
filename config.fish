if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    set -Ux STARSHIP_CONFIG /run/media/archishman/D-Drive/starship.toml
    starship init fish | source
    alias ls=eza
    alias cat=bat
    alias ll="eza --icons=always -l"
end
