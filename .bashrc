#
# ~/.bashrc
#

# source autojump bash configuration
source /etc/profile.d/autojump.bash

complete -cf sudo

# auto cd on entering path
shopt -s autocd

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

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

# use new experimental gcc features
alias gccn='gcc -fconcepts'
alias g++n='g++ -fconcepts'

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

export PS1="[\u@\h [$COLOR_BLUE\W$COLOR_RESET]\$ "
export PROMPT_COMMAND=updateGitStatus 

export TERMINAL=terminator 

# java options 
_SILENT_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
alias java='java "$_SILENT_JAVA_OPTIONS"'

export ANDROID_HOME=/mnt/shared/android/sdk

# add depot tools to path
export PATH="${PATH}:/opt/depot_tools"

# ruby variables
export PATH="$(ruby -e 'print Gem.user_dir')/bin:${PATH}"

# export node.js modules to PATH
export PATH="$HOME/.node_modules/bin:${PATH}"

# export haskell cabal packages
export PATH="$HOME/.cabal/bin:${PATH}"

# wine variables
export WINEPREFIX=~/.wine
export WINEARCH=win32

# export python virtualenv wrapper
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# source fzf bash configuration
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

complete -F _fzf_file_completion -o default -o bashdefault cd

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Use ag instead of the default find command for listing candidates.
_fzf_compgen_path() {
    ag -g "" "$1"
}

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

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n ${status} | ag "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n ${status} | ag "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n ${status} | ag "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n ${status} | ag "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n ${status} | ag "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n ${status} | ag "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

function updateGitStatus {
    PS1_GIT_STATUS_FILE="/tmp/ps1-git-status"
    PS1_GIT_STATUS_FUSE="/tmp/ps1-git-status.fuse"
    local branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [[ -n "${branch}" ]]; then
        export PS1="\n[$COLOR_BLUE\w$COLOR_RESET] $COLOR_GREEN$(<${PS1_GIT_STATUS_FILE})$COLOR_RESET\n[\u@\h]\\$ "
        if [[ -f ${PS1_GIT_STATUS_FUSE} ]]; then
            return 0
        fi
        touch ${PS1_GIT_STATUS_FUSE}
        (
            local stat=`parse_git_dirty`
            echo "[${branch}${stat}]" > ${PS1_GIT_STATUS_FILE}
            rm ${PS1_GIT_STATUS_FUSE}
        ) & disown
    else
        echo "" > ${PS1_GIT_STATUS_FILE}
        export PS1='[\u@\h \W]\$ '
    fi
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
