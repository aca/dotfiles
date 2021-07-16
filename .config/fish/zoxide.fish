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
        alias __zoxide_cd_internal="builtin cd"
    end
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    __zoxide_cd_internal $argv
    and builtin commandline -f repaint
end

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
if test "$__zoxide_hooked" != 1
    set __zoxide_hooked 1
    function __zoxide_hook --on-variable PWD
        test -z "$fish_private_mode"
        and command zoxide add -- (__zoxide_pwd)
    end
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
    else if begin
            test $argc -eq 1; and test -d $argv[1]
        end
        __zoxide_cd $argv[1]
    else
        set -l __zoxide_result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $__zoxide_result
    end
end

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l __zoxide_result (command zoxide query -i -- $argv)
    and __zoxide_cd $__zoxide_result
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
alias z="__zoxide_z"

__zoxide_unset zi
alias zi="__zoxide_zi"

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually
# ~/.config/fish/config.fish):
#
# zoxide init fish | source
