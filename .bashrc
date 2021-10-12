#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='exa --icons -as type'
alias tree='exa --icons -as type --tree'
alias ll='exa --icons -als type'
alias :q='exit'
alias :h='man'
PS1='[\u@\h \W]\$ '
