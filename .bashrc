# vim: foldmethod=marker foldlevel=0:

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

PS1='\u@\h $ '

unset color_prompt force_color_prompt

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

set -o vi

if [[ "$USER" == "ubuntu" ]]; then export TERM=xterm ; fi

if [[ -f ~/.fzf/shell/key-bindings.bash ]]; then source ~/.fzf/shell/key-bindings.bash; fi
if [[ -f ~/.asdf/asdf.sh ]]; then source ~/.asdf/asdf.sh; fi
# . "$HOME/.cargo/env"

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion
[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion ]] && . /usr/local/share/bash-completion/bash_completion

# _dothis_completions()
# {
#   declare -p COMP_WORDS >> /tmp/elvisherr
#   echo "COMP_CWORD: $COMP_CWORD" >> /tmp/elvisherr
#   COMPREPLY=()
#   COMPREPLY+=("now")
#   COMPREPLY+=("tomorrow")
#   COMPREPLY+=("never")
# }
#
# complete -F _dothis_completions dothis
