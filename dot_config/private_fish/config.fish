alias ls="lsd"
alias cat="bat --paging=never"

set -Ux EDITOR micro

fish_add_path $HOME/.fnm
fish_add_path $HOME/bin

if status is-interactive
    # Commands to run in interactive sessions can go here

    starship init fish | source
    atuin init fish | source
    yq shell-completion fish | source
    ssh_agent
end
