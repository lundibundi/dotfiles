# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

export ADOTDIR="${HOME}/.config/antigen"
source $ADOTDIR/antigen.zsh

antigen use oh-my-zsh

#antigen bundle vi-mode
antigen bundle z
antigen bundle extract
antigen bundle pip
antigen bundle command-not-found
antigen bundle colored-man-pages

antigen bundles <<COMPLETIONS
    git
    hub
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

#function prompt_geometry_render_lprompt() {
#  NEWLINE=$'\n'
#  echo "$GEOMETRY_PROMPT_PREFIX %F{$GEOMETRY_COLOR_DIR}%3~%f ${NEWLINE} "      \
#       "%${#PROMPT_SYMBOL}{%(?.$GEOMETRY_PROMPT.$GEOMETRY_EXIT_VALUE)%} "      \
#       "$GEOMETRY_PROMPT_SUFFIX"
#}

#antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship

antigen apply


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

export MANPATH="/usr/local/man:$MANPATH"
export EDITOR='vim'
export TERMINAL=terminator 

# java options 
_SILENT_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
alias java='java "$_SILENT_JAVA_OPTIONS"'

# android tools and home
export ANDROID_HOME=/mnt/shared/android/sdk
export PATH="${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools"

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

# set variables for fcitx
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

# export python virtualenv wrapper
export WORKON_HOME=~/.virtualenvs

# cargo env
source "$HOME/.cargo/env"

# exercism autocompletion
if [ -f ~/.config/exercism/exercism_completion.zsh ]; then
  . ~/.config/exercism/exercism_completion.zsh
fi

#export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
#export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#
#_fzf_compgen_path() {
#    ag -g "" "$1"
#}


# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
