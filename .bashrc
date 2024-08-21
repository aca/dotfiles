[ -z "$PS1" ] && return # If not running interactively, don't do anything

# vifm() { cd "$(command vifm --choose-dir - "$@")" }

# [ -n "$__BASHRC_LOADED" ] && return; export __BASHRC_LOADED=1

# OPTS
shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s histappend # append to the history file, don't overwrite it
shopt -s nullglob # ignore if no match
HISTCONTROL=ignoredups:ignorespace # don't put duplicate lines in the history. See bash(1) for more options ... or force ignoredups and ignorespace
HISTSIZE=1000
HISTFILESIZE=2000

alias elv='elvish'

# use active DISPLAY if available on remote session
# NOTES: this is a hack for working on VM
if [ -z "$WAYLAND_DISPLAY" ]; then
    for i in "$XDG_RUNTIME_DIR/wayland"-?; do
        export WAYLAND_DISPLAY="$i"
    done
fi

PS1='\u@\h $ '

# https://codeberg.org/dnkl/foot/wiki#bash
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

# NIX
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
set -o vi
