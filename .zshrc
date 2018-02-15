## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=100000
SAVEHIST=500

WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

HYPHEN_INSENSITIVE="true"

export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export TERMINAL=terminator

export CONKY_CONFIG="${HOME}/.config/conky"

# ibus config
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# java options
_SILENT_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
alias java='java "$_SILENT_JAVA_OPTIONS"'

# depot tools
export PATH="${PATH}:/opt/depot_tools"

# android tools and home
export ANDROID_HOME="${HOME}/android/sdk"
export PATH="${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools"

# export node.js modules to PATH
export PATH="$HOME/.node_modules/bin:${PATH}"
#
# export gem modules to PATH
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# wine variables
export WINEPREFIX=~/.wine
export WINEARCH=win32

# export python virtualenv wrapper
export WORKON_HOME=~/.virtualenvs

export RUST_SRC_PATH=~/rust/nightly
# cargo env
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

# exercism autocompletion
if [ -f ~/.config/exercism/exercism_completion.zsh ]; then
  . ~/.config/exercism/exercism_completion.zsh
fi

# fzf configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Antigen configuration
export ADOTDIR="${HOME}/.config/antigen"
source $ADOTDIR/antigen.zsh

antigen use oh-my-zsh

#antigen bundle vi-mode
antigen bundle z
antigen bundle extract
antigen bundle pip
antigen bundle command-not-found
antigen bundle colored-man-pages
antigen bundle git

antigen bundles <<COMPLETIONS
    git
    go
    gradle
    jira
    mvn
    sbt
    node
    npm
    nvm
    pip
    virtualenvwrapper
    docker
COMPLETIONS

antigen bundle zsh-users/zsh-syntax-highlighting

# geomety theme confiuration
GEOMETRY_SYMBOL_PROMPT="➔"
GEOMETRY_SYMBOL_EXIT_VALUE="➔"
PROMPT_GEOMETRY_GIT_CONFLICTS=true
GEOMETRY_COLOR_GIT_DIRTY=yellow
PROMPT_GEOMETRY_GIT_TIME=false
export GEOMETRY_PROMPT_PLUGINS=(virtualenv exec_time git rustup)

antigen theme frmendes/geometry


## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

## Alias section
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB

alias vi='nvim'
alias vim='nvim'
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

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r
