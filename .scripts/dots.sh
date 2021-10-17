#!/bin/bash
DOTFILES_DIR="$HOME/.dotfiles"
CURRENT_PWD=$(pwd)
DOTFILES_REPO_HTTPS="https://github.com/thanhvule0310/dotfiles"
DOTFILES_REPO_SSH="git@github.com:thanhvule0310/dotfiles.git"
DOTFILES_REPO=$DOTFILES_REPO_SSH

function _spinner() {
  # $1 start/stop
  #
  # on start: $2 display message
  # on stop : $2 process exit status
  #           $3 spinner function pid (supplied from stop_spinner)

  local on_success="DONE"
  local on_fail="FAIL"
  local white="\e[1;37m"
  local green="\e[1;32m"
  local red="\e[1;31m"
  local nc="\e[0m"

  case $1 in
  start)
    # calculate the column where spinner and status msg will be displayed
    let column=$(tput cols)-${#2}-8
    # display message and position the cursor in $column column
    echo -ne ${2}
    printf "%${column}s"

    # start spinner
    i=1
    sp='\|/-'
    delay=${SPINNER_DELAY:-0.15}

    while :; do
      printf "\b${sp:i++%${#sp}:1}"
      sleep $delay
    done
    ;;
  stop)
    if [[ -z ${3} ]]; then
      echo "spinner is not running.."
      exit 1
    fi

    kill $3 >/dev/null 2>&1

    # inform the user uppon success or failure
    echo -en "\b["
    if [[ $2 -eq 0 ]]; then
      echo -en "${green}${on_success}${nc}"
    else
      echo -en "${red}${on_fail}${nc}"
    fi
    echo -e "]"
    ;;
  *)
    echo "invalid argument, try {start/stop}"
    exit 1
    ;;
  esac
}

function start_spinner {
  # $1 : msg to display
  _spinner "start" "${1}" &
  # set global spinner pid
  _sp_pid=$!
  disown
}

function stop_spinner {
  # $1 : command exit status
  _spinner "stop" $1 $_sp_pid
  unset _sp_pid
}

case $1 in
backup)
  CURRENT_TIME=$(date)
  echo -e " Starting backup dotfiles"

  start_spinner "➜ Clean old configs in repo"

  rm -rf $DOTFILES_DIR/.bashrc
  rm -rf $DOTFILES_DIR/.clang-format
  rm -rf $DOTFILES_DIR/.gitconfig
  rm -rf $DOTFILES_DIR/.prettierrc
  rm -rf $DOTFILES_DIR/.scripts
  rm -rf $DOTFILES_DIR/.tmux.conf
  rm -rf $DOTFILES_DIR/.vimrc
  rm -rf $DOTFILES_DIR/.vsnip
  rm -rf $DOTFILES_DIR/.xinitrc
  rm -rf $DOTFILES_DIR/.Xresources
  rm -rf $DOTFILES_DIR/.zshrc
  rm -rf $DOTFILES_DIR/.config/*
  rm -rf $DOTFILES_DIR/.config/ytfzf
  rm -rf $DOTFILES_DIR/.config/rofi
  stop_spinner $?

  start_spinner "➜ Copy to dotfiles folder"
  cp ~/.bashrc $DOTFILES_DIR/
  cp ~/.clang-format $DOTFILES_DIR/
  cp ~/.gitconfig $DOTFILES_DIR/
  cp ~/.gitconfig $DOTFILES_DIR/
  cp ~/.prettierrc $DOTFILES_DIR/
  cp ~/.tmux.conf $DOTFILES_DIR/
  cp ~/.vimrc $DOTFILES_DIR/
  cp ~/.xinitrc $DOTFILES_DIR/
  cp ~/.Xresources $DOTFILES_DIR/
  cp ~/.zshrc $DOTFILES_DIR/
  cp -r ~/.scripts $DOTFILES_DIR/
  cp -r ~/.vsnip $DOTFILES_DIR/
  cp -r ~/.config/bat $DOTFILES_DIR/.config/
  cp -r ~/.config/btop $DOTFILES_DIR/.config/
  cp -r ~/.config/bspwm $DOTFILES_DIR/.config/
  cp -r ~/.config/cava $DOTFILES_DIR/.config/
  cp -r ~/.config/dunst $DOTFILES_DIR/.config/
  cp -r ~/.config/fish $DOTFILES_DIR/.config/
  cp -r ~/.config/fontconfig $DOTFILES_DIR/.config/
  cp -r ~/.config/gtk-3.0 $DOTFILES_DIR/.config/
  cp -r ~/.config/lsd $DOTFILES_DIR/.config/
  cp -r ~/.config/nvim $DOTFILES_DIR/.config/
  cp -r ~/.config/omf $DOTFILES_DIR/.config/
  cp -r ~/.config/paru $DOTFILES_DIR/.config/
  cp -r ~/.config/picom $DOTFILES_DIR/.config/
  cp -r ~/.config/polybar $DOTFILES_DIR/.config/
  cp -r ~/.config/starship.toml $DOTFILES_DIR/.config/
  cp -r ~/.config/sxhkd $DOTFILES_DIR/.config/
  cp -r ~/.config/vis $DOTFILES_DIR/.config/
  cp -r ~/.config/ytfzf $DOTFILES_DIR/.config/
  cp -r ~/.config/rofi $DOTFILES_DIR/.config/

  stop_spinner $?

  start_spinner "➜ Push to Github"

  # Check is exist commit message
  if [ -z "$2" ]; then
    commit_message="Automatic backup daily: $CURRENT_TIME"
  else
    commit_message="$2"
  fi

  echo -e "   > Commit message: '$commit_message'"
  cd $DOTFILES_DIR || exit

  if ! git diff --quiet HEAD || git status --short; then
    {
      echo ""
      echo "$CURRENT_TIME"
      echo ""
      echo "### Install: "
      echo "\`\`\`bash"
      echo "curl -o- https://raw.githubusercontent.com/thanhvule0310/dotfiles/main/.scripts/dots.sh | bash"
      echo "\`\`\`"
    } >README.md

    git add . >/dev/null 2>&1
    git commit -m "$commit_message" >/dev/null 2>&1
    git push origin main >/dev/null 2>&1
  fi

  cd $CURRENT_PWD
  stop_spinner $?

  echo -e " Backup success!"
  ;;

*)
  echo -e " Starting restore dotfiles"

  cd $DOTFILES_DIR

  start_spinner "➜ Restoring..."
  cp .bashrc ~/
  cp .clang-format ~/
  cp .gitconfig ~/
  cp .gitconfig ~/
  cp .prettierrc ~/
  cp .tmux.conf ~/
  cp .vimrc ~/
  cp .xinitrc ~/
  cp .Xresources ~/
  cp .zshrc ~/
  cp .scripts ~/
  cp .vsnip ~/
  cp .config/* ~/.config/

  cd $CURRENT_PWD
  stop_spinner $?
  echo -e " Restore dotfiles success"
  ;;
esac
