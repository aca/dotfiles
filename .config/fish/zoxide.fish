# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
end

# A copy of fish's internal cd function. This makes it possible to use
# `alias cd=z` without causing an infinite loop.
if ! builtin functions -q __zoxide_cd_internal
    if builtin functions -q cd
        builtin functions -c cd __zoxide_cd_internal
    else
        alias __zoxide_cd_internal='builtin cd'
    end
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    __zoxide_cd_internal $argv
end

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end

# =============================================================================
#
# When using zoxide with --no-aliases, alias these internal functions as
# desired.
#

# Jump to a directory using only keywords.
function __zoxide_z
    set argc (count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end

# Completions for `z`.
function __zoxide_z_complete
    set -l trigger '**'
    set -l trigger_length (string length $trigger)

    set -l line (commandline -op)
    set -l interactive 0
    if test (string sub -s "-$trigger_length" $line[-1]) = $trigger
        set line[-1] (string sub -e "-$trigger_length" $line[-1])
        set interactive 1
    end

    set -l query $line[2..-1]
    if test $interactive -eq 0 -a (count (commandline -cop)) -le 1
        __fish_complete_directories "$query" ''
        return
    end
    set -l result (_ZO_FZF_OPTS='--bind=ctrl-z:ignore --exit-0 --height=35% --inline-info --no-sort --reverse --select-1' zoxide query -i -- $query)
    set -l exit $status
    if test $exit -ne 0
        test $exit -eq 130
        and commandline -p "$line"
        return
    end

    set -l cmd $line[1]
    commandline -p "$cmd "(string escape $result)
end

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l result (command zoxide query -i -- $argv)
    and __zoxide_cd $result
end

# =============================================================================
#
# Convenient aliases for zoxide. Disable these using --no-aliases.
#

# Remove definitions.
function __zoxide_unset
    set --erase $argv >/dev/null 2>&1
    abbr --erase $argv >/dev/null 2>&1
    builtin functions --erase $argv >/dev/null 2>&1
end

__zoxide_unset z
alias z=__zoxide_z
complete -e z
complete -c z -f -a '(__zoxide_z_complete)'

__zoxide_unset zi
alias zi=__zoxide_zi

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually
# ~/.config/fish/config.fish):
#
# zoxide init fish | source
