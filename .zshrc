[[ -o interactive ]] && return # If not running interactively, don't do anything

vifm() { cd "$(command vifm --choose-dir - "$@")" }

# export ZSH="$HOME/.oh-my-zsh"
# DISABLE_AUTO_UPDATE="true"
# plugins=(
#   # tmux
#   # kubectl
#   fzf
#   # zsh-vi-mode
#   # aws
# )
# source $ZSH/oh-my-zsh.sh
#
# export HOMEBREW_PREFIX="/opt/homebrew";
# export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
# export HOMEBREW_REPOSITORY="/opt/homebrew";
# export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
# export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
# export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
# fpath=($HOME/.zsh/zsh-completions/src $fpath)

# local ret_status="%(?::%{$fg[red]%})%(?..« exit: %?
# )%{$reset_color%}"
# local hostinfo=""
# if [[ "$SSH_TTY" != '' ]]; then hostinfo="%n@%m "; fi
# # PROMPT='${ret_status}%{$fg[#7c7c7c]%}${hostinfo}Z|%D{%H:%I} %{$fg[yellow]%}|%{$reset_color%} '
# PROMPT='${ret_status}%{$fg[#7c7c7c]%}${hostinfo}%{$fg[yellow]%}»%{$reset_color%} '
# ZLE_RPROMPT_INDENT=0
# RPROMPT='%{$fg[#7c7c7c]%}zsh %{$fg[yellow]%}%~%{$reset_color%}'

typeset -F SECONDS
function -record-start-time() {
  emulate -L zsh
  ZSH_START_TIME=${ZSH_START_TIME:-$SECONDS}
}
# add-zsh-hook preexec -record-start-time

function -report-start-time() {
  emulate -L zsh
  if [ $ZSH_START_TIME ]; then
    local DELTA=$(($SECONDS - $ZSH_START_TIME))
    if (( $DELTA > 1 )); then
      SECS="$(print -f "%.2f" $DELTA)s"
      echo $fg[italic]$fg[red]"« took: "$SECS" / done: "$(date "+%Y-%m-%d %H:%M:%S")
    fi
    unset ZSH_START_TIME
  fi
}
# add-zsh-hook precmd -report-start-time

set -o physical
set -o vi
setopt AUTO_CD                 # [default] .. is shortcut for cd .. (etc)
setopt AUTO_PARAM_SLASH        # tab completing directory appends a slash
setopt AUTO_PUSHD              # [default] cd automatically pushes old dir onto dir stack
setopt AUTO_RESUME             # allow simple commands to resume backgrounded jobs
setopt CLOBBER                 # allow clobbering with >, no need to use >!
# setopt CORRECT                 # [default] command auto-correction
# setopt CORRECT_ALL             # [default] argument auto-correction
setopt NO_FLOW_CONTROL         # disable start (C-s) and stop (C-q) characters
setopt NO_HIST_IGNORE_ALL_DUPS # don't filter duplicates from history
setopt NO_HIST_IGNORE_DUPS     # don't filter contiguous duplicates from history
setopt HIST_FIND_NO_DUPS       # don't show dupes when searching
setopt HIST_IGNORE_SPACE       # [default] don't record commands starting with a space
setopt HIST_VERIFY             # confirm history expansion (!$, !!, !foo)
setopt IGNORE_EOF              # [default] prevent accidental C-d from exiting shell
setopt INTERACTIVE_COMMENTS    # [default] allow comments, even in interactive shells
setopt LIST_PACKED             # make completion lists more densely packed
setopt MENU_COMPLETE           # auto-insert first possible ambiguous completion
setopt NO_NOMATCH              # [default] unmatched patterns are left unchanged
# setopt PRINT_EXIT_VALUE        # [default] for non-zero exit status
setopt PUSHD_IGNORE_DUPS       # don't push multiple copies of same dir onto stack
setopt PUSHD_SILENT            # [default] don't print dir stack after pushing/popping
setopt SHARE_HISTORY           # share history across shells
setopt inc_append_history
setopt inc_appendhistorytime  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time

# export GOPATH=$HOME
# export GOPROXY=direct
# export GHQ_ROOT=$HOME/src
# export EDITOR=nvim
# export VISUAL=nvim
# export LANG=en_US.UTF-8
# export LANGUAGE=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
# export PATH=$HOME/bin:$HOME/.bin:$PATH
typeset -U path # clear unique path

alias v='nvim'
alias vim='nvim'

bindkey '^e' clear-screen

_exit() { exit }; zle -N _exit
bindkey '^q' _exit;

_paste() { LBUFFER+="$(clippaste)" }; zle -N _paste
bindkey '^v' _paste # Paste

_copy() { 
  echo $BUFFER | clipcopy
}; zle -N _copy

# for faster '^x', remove all unused bindings 
bindkey -r "^X^R"
bindkey -r "^X?" 
bindkey -r "^XC" 
bindkey -r "^Xa" 
bindkey -r "^Xc" 
bindkey -r "^Xd" 
bindkey -r "^Xe" 
bindkey -r "^Xh" 
bindkey -r "^Xm" 
bindkey -r "^Xn" 
bindkey -r "^Xt" 
bindkey -r "^X~" 
bindkey '^x' _copy # copy

# https://gitlab.freedesktop.org/Per_Bothner/specifications/-/blob/master/proposals/prompts-data/shell-integration.zsh
_prompt_executing=""
function __prompt_precmd() {
    local ret="$?"
    if test "$_prompt_executing" != "0"
    then
      _PROMPT_SAVE_PS1="$PS1"
      _PROMPT_SAVE_PS2="$PS2"
      PS1=$'%{\e]133;P;k=i\a%}'$PS1$'%{\e]133;B\a\e]122;> \a%}'
      PS2=$'%{\e]133;P;k=s\a%}'$PS2$'%{\e]133;B\a%}'
    fi
    if test "$_prompt_executing" != ""
    then
       printf "\033]133;D;%s;aid=%s\007" "$ret" "$$"
    fi
    printf "\033]133;A;cl=m;aid=%s\007" "$$"
    _prompt_executing=0
}

function __prompt_preexec() {
    PS1="$_PROMPT_SAVE_PS1"
    PS2="$_PROMPT_SAVE_PS2"
    printf "\033]133;C;\007"
    _prompt_executing=1
}

preexec_functions+=(__prompt_preexec)
precmd_functions+=(__prompt_precmd)

if [[ $(uname -s) = Darwin ]]; then
  # Override insanely low open file limits on macOS.
  ulimit -n 524288
  ulimit -u 2048
fi
export GIT_SSL_CAPATH="/tmp/netskope-cert-bundle.pem"
export SSL_CERT_FILE="/tmp/netskope-cert-bundle.pem"
export REQUESTS_CA_BUNDLE="/tmp/netskope-cert-bundle.pem"
export AWS_CA_BUNDLE="/tmp/netskope-cert-bundle.pem"
