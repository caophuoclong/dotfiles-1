#  / __ \/ /_        ____ ___  __  __   /__  /  _____/ /_
# / / / / __ \______/ __ `__ \/ / / /_____/ /  / ___/ __ \
#/ /_/ / / / /_____/ / / / / / /_/ /_____/ /__(__  ) / / /
#\____/_/ /_/     /_/ /_/ /_/\__, /     /____/____/_/ /_/
#                           /____/

# Export ENV - Path
export ZSH="/home/vu/.oh-my-zsh"
export DENO_INSTALL="/home/vu/.deno"
export PATH="$DENO_INSTALL/bin:/home/linuxbrew/.linuxbrew/bin:/home/vu/.local/bin:$PATH"
export EDITOR="nvim"
export TERM="xterm-256color"
export GOPATH="/home/vu/Workspaces/go"
export PATH=$PATH:$(go env GOPATH)/bin
export FZF_DEFAULT_OPTS='--prompt="הּ " --preview "bat --color=always {1} --theme=ansi" --layout=reverse --height=50% --info=inline --border --margin=1 --padding=1'
. /opt/asdf-vm/asdf.sh

eval "$(zoxide init zsh)"
# Theme
ZSH_THEME=""
eval "$(starship init zsh)"

#Plugins
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-completions docker docker-compose docker-machine sudo npm yarn golang gh cargo)

# Sources
source $ZSH/oh-my-zsh.sh

# Alias
alias cat="bat"
alias sl="exa --icons -as type --git --color=always"
alias ls="exa --icons -as type --git --color=always"
alias ll="exa --icons -als type --git --color=always"
alias tree="exa --icons --git -a --tree -s type -I '.git|node_modules|bower_components'"
alias grep="rg"
alias find="fd"
alias reload="source ~/.zshrc"
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
alias top="btop"
alias tb="taskbook"
alias v="\vim"
alias dots="~/.scripts/dots.sh"
alias vocab="cat ~/Documents/Notes/English/TodayVocab.md"
alias vocabe="nvim ~/Documents/Notes/English/TodayVocab.md"
# Functions
ex() {
  if [ -f $1 ]; then
    case $1 in
    *.tar.bz2) tar xjf $1 ;;
    *.tar.gz) tar xzf $1 ;;
    *.bz2) bunzip2 $1 ;;
    *.rar) unrar x $1 ;;
    *.gz) gunzip $1 ;;
    *.tar) tar xf $1 ;;
    *.tbz2) tar xjf $1 ;;
    *.tgz) tar xzf $1 ;;
    *.zip) unzip $1 ;;
    *.Z) uncompress $1 ;;
    *.7z) 7z x $1 ;;
    *.deb) ar x $1 ;;
    *.tar.xz) tar xf $1 ;;
    *.tar.zst) unzstd $1 ;;
    *.dmg | *.pkg | Payload\~) 7z x $1 ;;
    *) echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# BEGIN_KITTY_SHELL_INTEGRATION
if test -e "/usr/lib/kitty/shell-integration/kitty.zsh"; then source "/usr/lib/kitty/shell-integration/kitty.zsh"; fi
# END_KITTY_SHELL_INTEGRATION
