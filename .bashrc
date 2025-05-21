# Not bash or zsh?
[ -n "${BASH_VERSION:-}" -o -n "${ZSH_VERSION:-}" ] || return 0

# Not an interactive shell?
[[ $- == *i* ]] || return 0

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

# use active DISPLAY if available on remote session
# NOTES: this is a hack for working on VM
if [ -z "$WAYLAND_DISPLAY" ]; then
    for i in "$XDG_RUNTIME_DIR/wayland"-?; do
        export WAYLAND_DISPLAY="$i"
    done
fi

# PS1='\u@\h $ '

# replace with programs.bash.vteIntegration
# https://codeberg.org/dnkl/foot/wiki#bash
# osc7_cwd() {
#     local strlen=${#PWD}
#     local encoded=""
#     local pos c o
#     for (( pos=0; pos<strlen; pos++ )); do
#         c=${PWD:$pos:1}
#         case "$c" in
#             [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
#             * ) printf -v o '%%%02X' "'${c}" ;;
#         esac
#         encoded+="${o}"
#     done
#     printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
# }
# PROMPT_COMMAND=${PROMPT_COMMAND:+${PROMPT_COMMAND%;}; }osc7_cwd;

# NIX
# if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
#   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
# fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias elv='elvish'

set -o vi

# __vte_termprop_signal() {
#     local errsv="$?"
#     printf '\033]666;%s!\033\\' "$1"
#     return $errsv
# }
#
# __vte_termprop_set() {
#     local errsv="$?"
#     printf '\033]666;%s=%s\033\\' "$1" "$2"
#     return $errsv
# }
#
# __vte_termprop_reset() {
#     local errsv="$?"
#     printf '\033]666;%s\033\\' "$1"
#     return $errsv
# }
#
# __vte_osc7 () {
#     local errsv="$?"
#     printf "\033]7;file://%s%s\033\\" "${HOSTNAME}" "$(/nix/store/j81wrpng273njj13q0xfwy8gr8byr9v7-vte-0.80.1/libexec/vte-urlencode-cwd)"
#     return $errsv
# }
#
# __vte_precmd() {
#     local errsv="$?"
#     __vte_termprop_set "vte.shell.postexec" "$?"
#     __vte_termprop_signal "vte.shell.precmd"
#     return $errsv;
# }
#
# __vte_prompt_command() {
#     local errsv="$?"
#     __vte_termprop_set "vte.shell.postexec" "$errsv"
#     __vte_osc7
#     local pwd='~'
#     [ "$PWD" != "$HOME" ] && pwd=${PWD/#$HOME\//\~\/}
#     pwd="${pwd//[[:cntrl:]]}"
#     printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${pwd}"
#     __vte_termprop_signal "vte.shell.precmd"
#     return $errsv
# }
#
# if [[ -n "${BASH_VERSION:-}" ]]; then
#
#     # Newer bash versions support PROMPT_COMMAND as an array. In this case
#     # only add the __vte_osc7 function to it, and leave setting the terminal
#     # title to the outside setup.
#     # On older bash, we can only overwrite the whole PROMPT_COMMAND, so must
#     # use the __vte_prompt_command function which also sets the title.
#
#     if [[ "$(declare -p PROMPT_COMMAND 2>&1)" =~ "declare -a" ]]; then
#         PROMPT_COMMAND+=(__vte_precmd)
#         PROMPT_COMMAND+=(__vte_osc7)
#     else
#         PROMPT_COMMAND="__vte_prompt_command"
#     fi
#     PS0=$(__vte_termprop_signal "vte.shell.preexec")
#
#     # Shell integration
#     if [[ "$PS1" != *\]133\;* ]]; then
#
#         # Enclose the primary prompt between
#         # ← OSC 133;D;retval ST (report exit status of previous command)
#         # ← OSC 133;A ST (mark beginning of prompt)
#         # → OSC 133;B ST (mark end of prompt, beginning of command line)
#         PS1='\[\e]133;D;$?\e\\\e]133;A\e\\\]'"$PS1"'\[\e]133;B\e\\\]'
#
#         # Prepend OSC 133;L ST for a conditional newline if the previous
#         # command's output didn't end in one.
#         # This is not done here by default, in order to provide the default
#         # visual behavior of shells. Uncomment if you want this feature.
#         #PS1='\[\e]133;L\e\\\]'"$PS1"
#
#         # iTerm2 doesn't touch the secondary prompt.
#         # Konsole encloses it between 133;A and 133;B.
#         # For efficient jumping between commands, we follow iTerm2 by default
#         # and don't mark PS2 as prompt. Uncomment if you want to mark it.
#         #PS2='\[\e]133;A\e\\\]'"$PS2"'\[\e]133;B\e\\\]'
#
#         # Mark the beginning of the command's output by OSC 133;C ST.
#         # '\r' ensures that the kernel's cooked mode has the right idea of
#         # the column, important for handling TAB followed by BS keypresses.
#         # Prepend to the user's PS0 to preserve whether it ends in '\r'.
#         # Note that bash doesn't support the \[ \] markers here.
#         PS0='\e]133;C\e\\\r'"${PS0:-}"
#     fi
#
# elif [[ -n "${ZSH_VERSION:-}" ]]; then
#     precmd_functions+=(__vte_osc7)
#     precmd_functions+=(__vte_precmd)
#
#     # Shell integration (see the bash counterpart for more detailed comments)
#     if [[ "$PS1" != *\]133\;* ]]; then
#
#         # Enclose the primary prompt between D;retval, A and B.
#         PS1=$'%{\e]133;D;%?\e\\\e]133;A\e\\%}'"$PS1"$'%{\e]133;B\e\\%}'
#
#         # Prepend L for conditional newline (skipped).
#         #PS1=$'%{\e]133;L\e\\%}'"$PS1"
#
#         # Secondary prompt (skipped).
#         #PS2=$'%{\e]133;A\e\\%}'"$PS2"$'%{\e]133;B\e\\%}'
#
#         # Mark the beginning of output by C.
#         # The execution order is: the single function possibly hooked up
#         # in $preexec, followed by all the functions hooked up in the
#         # $preexec_functions array. Ensure that we are the very first.
#         __vte_preexec() {
#             local errsv="$?"
#             printf '\e]133;C\e\\\r'
#             return $errsv
#         }
#         preexec_functions=(__vte_preexec $preexec $preexec_functions)
#         unset preexec
#     fi
#
# fi
#
