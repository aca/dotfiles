# =============================================================================
#
# Utility functions for zoxide.
#

# Remove definitions.

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    pwd -L
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    cd $argv
    and commandline -f repaint
end

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
function __zoxide_hook --on-variable PWD
    zoxide add (__zoxide_pwd)
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
    else if begin; test $argc -eq 1; and test $argv[1] = '-'; end
        __zoxide_cd -
    else if begin; test $argc -eq 1; and test -d $argv[1]; end
        __zoxide_cd $argv[1]
    else
        set -l __zoxide_result (zoxide query -- $argv)
        and __zoxide_cd $__zoxide_result
    end
end

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l __zoxide_result (zoxide query -i -- $argv)
    and __zoxide_cd $__zoxide_result
end

# Add a new entry to the database.
function __zoxide_za
    zoxide add $argv
end

# Query an entry from the database using only keywords.
function __zoxide_zq
    zoxide query $argv
end

# Query an entry from the database using interactive selection.
function __zoxide_zqi
    zoxide query -i $argv
end

# Remove an entry from the database using the exact path.
function __zoxide_zr
    zoxide remove $argv
end

# Remove an entry from the database using interactive selection.
function __zoxide_zri
    zoxide remove -i $argv
end

# =============================================================================
#
# Convenient aliases for zoxide. Disable these using --no-aliases.
#

# Remove definitions.
function __zoxide_unset
    set --erase $argv > /dev/null 2>&1
    abbr --erase $argv > /dev/null 2>&1
    functions --erase $argv > /dev/null 2>&1
end

__zoxide_unset 'z'
function z
    __zoxide_z $argv
end

__zoxide_unset 'zi'
function zi
    __zoxide_zi $argv
end

__zoxide_unset 'za'
function za
    __zoxide_za $argv
end

__zoxide_unset 'zq'
function zq
    __zoxide_zq $argv
end

__zoxide_unset 'zqi'
function zqi
    __zoxide_zqi $argv
end

__zoxide_unset 'zr'
function zr
    __zoxide_zr $argv
end

__zoxide_unset 'zri'
function zri
    __zoxide_zri $argv
end

# =============================================================================
#
# To initialize zoxide with fish, add the following line to your fish
# configuration file (usually ~/.config/fish/config.fish):
#
# zoxide init fish | source
