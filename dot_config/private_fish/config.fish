alias ls="lsd"
alias cat="bat --paging=never"

if status is-interactive
    # Commands to run in interactive sessions can go here

    starship init fish | source
    atuin init fish | source
end
