if status is-interactive
    # Commands to run in interactive sessions can go here
end

source /opt/asdf-vm/asdf.fish

zoxide init fish | source
starship init fish | source

set fish_greeting

set -x EDITOR nvim
set -x TERM xterm-256color
set -x GOPATH $HOME/Workspaces/go
set -x PATH $PATH $GOPATH/bin $DENO_INSTALL/bin $HOME/.local/bin

alias cat="bat"
alias sl="logo-ls -AXD"
alias ls="logo-ls -AXD"
alias ll="logo-ls -AXDl"
alias l="logo-ls -AXDl"
alias tree="exa --icons --git -a --tree -s type -I '.git|node_modules|bower_components'"
alias find="fd"
alias :q="exit"
alias :h="man"
alias cd..="cd .."
alias ..="cd .."
alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -vp"
alias df="df -h"
alias rm="rm -ir"
alias open="xdg-open"
alias copy="xclip -sel clip"
alias merge="xrdb -merge ~/.Xresources"
alias svim="sudoedit"
alias icode="code-insiders"
alias ports="sudo lsof -i"
alias vim="nvim"
alias v="/usr/bin/vim"
alias top="bpytop"
alias dots="~/.scripts/dots.sh"
