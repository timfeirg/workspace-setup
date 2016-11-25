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
autoenv
fasd brew redis-cli ssh-agent mosh docker httpie
)
source $ZSH/oh-my-zsh.sh
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh

source ~/antigen.zsh
export BULLETTRAIN_STATUS_EXIT_SHOW=true
export BULLETTRAIN_PROMPT_ORDER=(
time
status
custom
context
dir
virtualenv
git
)
export BULLETTRAIN_GIT_BG=green
export BULLETTRAIN_TIME_BG=cyan
export BULLETTRAIN_STATUS_ERROR_BG=red
export BULLETTRAIN_STATUS_ERROR_FG=red
export BULLETTRAIN_DIR_FG=black
export BULLETTRAIN_CONTEXT_DEFAULT_USER=timfeirg
export BULLETTRAIN_CONTEXT_SHOW=true
export BULLETTRAIN_GIT_COLORIZE_DIRTY=true
if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
  export BULLETTRAIN_IS_SSH_CLIENT=true
fi

antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen apply

COMPLETION_WAITING_DOTS="true"

# User configuration
DEFAULT_USER=timfeirg
DEBIAN_PREVENT_KEYBOARD_CHANGES=yes

# env
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/texbin:/usr/games"
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
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^[[Z' reverse-menu-complete
export KEYTIMEOUT=1

# history config
HISTSIZE=100000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

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

# Setting ag as the default source for fzf, this will enable fzf to respect .gitignore
export FZF_DEFAULT_COMMAND='ag -g ""'
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
