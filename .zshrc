# profile zshrc from https://gist.github.com/mwilliammyers/54edf992399e794f7ffe
# uncomment head and tail when in need

# PROFILE_STARTUP=true
# if [[ "$PROFILE_STARTUP" == true ]]; then
#   zmodload zsh/zprof # Output load-time statistics
#   # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
#   PS4=$'%D{%M%S%.} %N:%i> '
#   exec 3>&2 2>"${XDG_CACHE_HOME:-$HOME/tmp}/zsh_statup.$$"
#   setopt xtrace prompt_subst
# fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export DISABLE_AUTO_UPDATE="true"
export ZSH=$HOME/.oh-my-zsh
plugins=(
git-extras gitfast
pip
golang
fasd brew redis-cli ssh-agent mosh docker httpie
virtualenv virtualenvwrapper
helm
)
source $ZSH/oh-my-zsh.sh

source ~/antigen.zsh
export BULLETTRAIN_STATUS_EXIT_SHOW=true
export BULLETTRAIN_PROMPT_ORDER=(
time
cmd_exec_time
status
proxy
custom
context
dir
virtualenv
git
)
export BULLETTRAIN_PROMPT_CHAR=""
export BULLETTRAIN_GIT_BG=green
export BULLETTRAIN_TIME_BG=cyan
export BULLETTRAIN_STATUS_ERROR_BG=red
export BULLETTRAIN_STATUS_ERROR_FG=red
export BULLETTRAIN_DIR_FG=black
export BULLETTRAIN_CONTEXT_DEFAULT_USER=timfeirg
export BULLETTRAIN_GIT_COLORIZE_DIRTY=true
if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
  export BULLETTRAIN_IS_SSH_CLIENT=true
fi
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=1

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train
antigen apply

COMPLETION_WAITING_DOTS="true"

# User configuration
DEFAULT_USER=timfeirg
DEBIAN_PREVENT_KEYBOARD_CHANGES=yes

# env
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin"
export GOPATH=$HOME/gocode
export PATH=$PATH:$GOPATH/bin
export ANDROID_HOME=/usr/local/opt/android-sdk
if ! type nvim > /dev/null; then
  export EDITOR=vim
  alias v='f -e vim'
else
  export EDITOR=nvim
  alias v='f -e nvim'
fi

# vi mode
bindkey -v
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^[[Z' reverse-menu-complete
bindkey '^[[[CE' autosuggest-execute
export KEYTIMEOUT=1

# history config
HISTSIZE=100000
SAVEHIST=10000000
setopt BANG_HIST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
setopt correctall

autoload -U promptinit
promptinit
alias gcane='gca! --no-edit'
alias gcanep='gca! --no-edit && gp -f $1 $2'
alias gcaanep='ga -A && gca! --no-edit && gp -f $1 $2'
alias vi=$EDITOR
alias ssh='TERM=xterm ssh'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

#Disable autocorrect
unsetopt correct_all
unsetopt correct
DISABLE_CORRECTION="true"

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

# add all ssh keys
if which keychain > /dev/null; then eval `keychain -q --eval --agents ssh --inherit any id_bitbucket id_github id_gitlab id_japanapi id_sa_ricebook`; fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# if [[ "$PROFILE_STARTUP" == true ]]; then
#   zprof
#   unsetopt xtrace
#   exec 2>&3 3>&-
# fi

# added by travis gem
[ -f /Users/timfeirg/.travis/travis.sh ] && source /Users/timfeirg/.travis/travis.sh
