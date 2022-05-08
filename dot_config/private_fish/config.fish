alias ls="lsd"
alias cat="bat --paging=never"

set -Ux EDITOR micro

fish_add_path $HOME/.fnm

if status is-interactive
    # Commands to run in interactive sessions can go here

    starship init fish | source
    atuin init fish | source
    yq shell-completion fish | source
end
