alias ls="lsd"
alias cat="bat --paging=never"

# show containers
abbr --add dps "docker ps -a --format {{"'table {{.Names}}\t{{.Image}}\t{{.Status}}'"}}"
abbr --add dpss "docker ps -q | xargs docker inspect --format {{"'{{.Config.Hostname}} - {{.Name}} - {{.NetworkSettings.IPAddress}}'"}}"
# monitor all containers
abbr --add ds 'docker stats (docker ps -q)'

set -Ux EDITOR micro

fish_add_path $HOME/.fnm
fish_add_path $HOME/bin
fish_add_path /usr/local/go/bin

if status is-interactive
    # Commands to run in interactive sessions can go here

    starship init fish | source
    atuin init fish | source
    yq shell-completion fish | source
    ssh_agent
end
