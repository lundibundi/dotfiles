#
# ~/.bashrc
#

export TERMINAL=terminator 

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# source autojump bash configuration
source /etc/profile.d/autojump.bash

# auto cd on entering path
shopt -s autocd

alias vi='vim'
alias ls='ls --color=auto'
alias sudo='sudo '
alias rr='ranger'
alias pp='sudo powerpill'
alias bb='bb-wrapper'
alias emc='emacsclient -s esrv-default -c'
alias luarocks-torch='luarocks --server=https://raw.githubusercontent.com/torch/rocks/master'
alias w-word="WINEARCH=win32 WINEPREFIX=/home/lundibundi/.win32-word wine /home/lundibundi/.win32-word/drive_c/Program\ Files/Microsoft\ Office/Office14/WINWORD.EXE"
alias w-masm="WINEARCH=win32 WINEPREFIX=/home/lundibundi/.win32-def wine"
alias py='python'
alias sc='systemctl'
alias ssc='sudo systemctl'
alias bt='bluetooth'
alias btc='bluetoothctl'
alias conf='/usr/bin/git --git-dir=$HOME/.conf/ --work-tree=$HOME'


alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

PS1='[\u@\h \W]\$ '

complete -cf sudo

# use new experimental gcc features
alias gccn='gcc -fconcepts'
alias g++n='g++ -fconcepts'

# java options 
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

_SILENT_JAVA_OPTIONS="$_JAVA_OPTIONS"
unset _JAVA_OPTIONS
alias java='java "$_SILENT_JAVA_OPTIONS"'

# android variables
export ANDROID_HOME=/opt/android-sdk

# android ndk variables
source /etc/profile.d/android-ndk.sh

# add depot tools to path
source /etc/profile.d/depot_tools.sh

# ruby options
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# wine variables
export WINEPREFIX=~/.win32
export WINEARCH=win32

# set environment variables for fcitx
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

# export torch paths
. /home/lundibundi/torch/install/bin/torch-activate

# export python virtualenv wrapper
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# export node.js modules to PATH
export PATH="$HOME/.node_modules/bin:$PATH"

# export haskell cabal packages
export PATH="$HOME/.cabal/bin:$PATH"

# source fzf bash configuration
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

#complete -F _fzf_file_completion -F _fzf_path_completion -F _fzf_dir_completion -o default -o bashdefault doge
complete -F _fzf_file_completion -o default -o bashdefault cd

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Use ag instead of the default find command for listing candidates.
_fzf_compgen_path() {
    ag -g "" "$1"
}

# custom cd functions with the use of fzf

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$(pwd)}") | fzf-tmux --tac)
  cd "$DIR"
}

# cf - fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
# zsh autoload function
cs() {
  local file

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi
}

del-orphans() {
  if [[ ! -n $(pacman -Qdt) ]]; then
    echo "No orphans to remove."
  else
    sudo pacman -Rns $(pacman -Qdtq)
  fi
}

# export JAVA_HOME=/usr/lib/jvm/java-default-runtime

# distorted sound in skype
# export PULSE_LATENCY_MSEC=60

# speed-up subsequent recompilings using ccache
# export PATH="/usr/lib/ccache/bin/:$PATH"

# enabling "vi-mode" 
# set -o vi
