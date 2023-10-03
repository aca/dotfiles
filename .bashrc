export PATH=$HOME/.bin:$HOME/bin:$PATH

[ -z "$PS1" ] && return # If not running interactively, don't do anything

shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s histappend # append to the history file, don't overwrite it

HISTCONTROL=ignoredups:ignorespace # don't put duplicate lines in the history. See bash(1) for more options ... or force ignoredups and ignorespace
HISTSIZE=1000
HISTFILESIZE=2000

PS1='\u@\h $ '

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

set -o vi

osc7_cwd() {
    local strlen=${#PWD}
    local encoded=""
    local pos c o
    for (( pos=0; pos<strlen; pos++ )); do
        c=${PWD:$pos:1}
        case "$c" in
            [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
            * ) printf -v o '%%%02X' "'${c}" ;;
        esac
        encoded+="${o}"
    done
    printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_cwd

# NOTES: bash completion sources all completion files which makes startup lag.
# Remove completion not used.
if [[ $PS1 && -f /opt/homebrew/etc/profile.d/bash_completion.sh ]]; then 
    . /opt/homebrew/etc/profile.d/bash_completion.sh
fi

# GUIX
if [ -n "$GUIX_ENVIRONMENT" ]; then
    if [[ $PS1 =~ (.*)"\\$" ]]; then
        PS1="${BASH_REMATCH[1]} [env]\\\$ "
    fi
fi

# NIX
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# . /home/rok/src/config/dotfiles/.config/elvish/lib/elvish-bash-completion/bash-completion/bash_completion

# https://github.com/Eugeny/tabby/issues/7717
if [ -z "$TMUX" ]; then
    PS1=${PS1}'\[\e]1337;CurrentDir=${PWD}\a\]'
else
    PS1=${PS1}'\[\ePtmux;\e\e]1337;CurrentDir=${PWD}\a\e\\\]'
fi

