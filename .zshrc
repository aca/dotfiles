# vim: set filetype=zsh foldmethod=marker foldlevel=0:
# PROMPT='%{$fg[green]%}%{$PROMPT}%{$fg[white]%}'

# autoload -U promptinit && promptinit
# prompt restore

# oh-my-zsh {{{
export ZSH="$HOME/.oh-my-zsh"
DISABLE_AUTO_UPDATE="true"
# export ZSH_THEME="jreese"

plugins=(
  # tmux
  # kubectl
  # fzf
  # zsh-vi-mode
  # aws
)

source $ZSH/oh-my-zsh.sh
local NEWLINE=$'\n'; local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})%(?..« exit: %?${NEWLINE})"
# PROMPT='${ret_status}%{$fg[cyan]%}%{$reset_color%}𝑍 '
# PROMPT='%{$fg[green]%}%{$PROMPT}%{$fg[white]%}'
PROMPT='%{$fg[yellow]%}𝓩%{$reset_color%} '
RPROMPT='%~'
# }}}

# Options {{{ 
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
#  }}} zsh options

# Exports {{{
export GOPATH=$HOME
export GOPROXY=direct
export GHQ_ROOT=$HOME/src
export EDITOR=nvim
export VISUAL=nvim
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# }}}

# Aliases {{{
alias v='nvim'
alias vim='nvim'
alias k='kubectl'
alias f='vifm'
alias t='tmux'
alias ta='tmux attach -t'
alias tk='tmux kill-server'
alias td='tmux detach'
# }}}

# # PATH {{{
# export PATH=$HOME/.bin:$PATH
# export PATH=$HOME/.krew/bin:$PATH
# export PATH=$HOME/bin:$PATH
# export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
# typeset -U path # clean path
# # }}}

[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh
# [ -e ~/.nix-profile/etc/profile.d/nix.sh ] && source ~/.nix-profile/etc/profile.d/nix.sh

source ~/.fzf/shell/key-bindings.zsh
source ~/.submodules/zsh-fzf-history-search/zsh-fzf-history-search.zsh
