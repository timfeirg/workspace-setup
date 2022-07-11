# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
export HOMEBREW_NO_AUTO_UPDATE=1
export ZSH=$HOME/.oh-my-zsh
export GOPATH=$HOME/gocode
export PATH="/opt/homebrew/bin:/opt/homebrew/opt/coreutils/libexec/gnubin:$GOPATH/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:$HOME/.virtualenvs/lain-cli/bin:/Users/timfeirg/.asdf/shims"
plugins=(
git
gitfast
asdf
git-extras
gpg-agent
vagrant
# golang
fasd
dotenv
redis-cli
ssh-agent
# mosh
docker
pip
virtualenv
virtualenvwrapper
# pyenv
kubectl
)
source $ZSH/oh-my-zsh.sh
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

source ~/antigen.zsh
source ~/.lain-complete.zsh

export ZLE_RPROMPT_INDENT=0
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=1

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
# smartcase behavior in tab completions, see https://www.reddit.com/r/zsh/comments/4aq8ja/is_it_possible_to_enable_smartcase_tab_completion/
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
antigen bundle zsh-users/zsh-completions
antigen theme romkatv/powerlevel10k
antigen apply

COMPLETION_WAITING_DOTS="true"

# User configuration
DEFAULT_USER=timfeirg
DEBIAN_PREVENT_KEYBOARD_CHANGES=yes

export EDITOR=nvim
alias agq='ag -Q'
# export MANPAGER="nvim -c 'set ft=man' -"
alias la='exa -alHbg --sort newest'
alias l='exa -alHbg --sort newest'
alias sudo='sudo '
alias ktp='kubectl top pod'
alias kgp='kubectl get pod -owide'

# vagrant related
alias vst="vagrant global-status --prune"
alias vsh="vagrant ssh"
alias vd="vagrant destroy -f"
alias vup="vagrant up"
alias vupp="SSH_AUTH_SOCK='' vagrant up --provision"
# ansible related
alias ave="ansible-vault edit"
alias feature='git-feature'
alias bug='git-feature -a bug'
alias gsf='git-sync --force'
alias refactor='git-feature -a refactor'

# edit all files that match this ag search
function agvi() {
  ag $@ -l | xargs -o nvim
}

function hag() {
	helm list --all | ag $@
}

function hdag() {
	helm list --all | ag $@ | awk '{print $1}' | xargs helm delete
}

function kdag() {
	kubectl get deploy | ag $@ | awk '{print $1}' | xargs kubectl scale --replicas=0 deployment
}

function gpswca() {
	local repo_name=$(basename `git rev-parse --show-toplevel`)
	git remote remove swca || true
	git fetch --all --tags --prune && git delete-merged-branches
	git remote add swca https://swca.aisino.com/aisino-ein-aics/$repo_name
	git push -f swca --all
	git push -f swca --tags
}

# vi mode
bindkey -v
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^[[Z' reverse-menu-complete
bindkey '^[[[CE' autosuggest-execute
bindkey '^E' end-of-line
bindkey '^A' beginning-of-line
export KEYTIMEOUT=1

# history config
HISTSIZE=100000
SAVEHIST=10000000
setopt menu_complete
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
alias gs='TERM=xterm tig status'
alias gst='git branch --all && grv && git status --show-stash && git rev-list --format=%B --max-count=1 HEAD'
alias gfa='git fetch --all --tags --prune && git delete-merged-branches'
alias gcne='gc! --no-edit'
alias gcane='gca! --no-edit'
alias gcanep='gca! --no-edit && gp -f $1 $2'
alias gcls='gcl --depth 1 '
alias gcnep='gc! --no-edit && gp -f $1 $2'
alias grhd='git reset HEAD '
alias gcl='hub clone'
alias gcaanep='ga -A && gca! --no-edit && gp -f $1 $2'
alias glt='git log --decorate=full --simplify-by-decoration'
alias vi=$EDITOR
alias ssh='TERM=xterm ssh'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--no-mouse --inline-info"
export FZF_CTRL_R_OPTS="--no-mouse --inline-info"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

eval "$(direnv hook zsh)"

unsetopt correct_all
unsetopt correct
DISABLE_CORRECTION="true"

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

# if [[ "$PROFILE_STARTUP" == true ]]; then
#   zprof
#   unsetopt xtrace
#   exec 2>&3 3>&-
# fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
