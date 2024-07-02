use builtin
use path

# =============================================================================
#
# Utility functions for zoxide.
#

# cd + custom logic based on the value of _ZO_ECHO.
fn __zoxide_cd {|path|
    builtin:cd $path
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to track previous directory.
var oldpwd = $builtin:pwd
set builtin:before-chdir = [$@builtin:before-chdir {|_| edit:add-var oldpwd $builtin:pwd }]

# Initialize hook to add directories to zoxide.
if (builtin:not (builtin:eq $E:__zoxide_shlvl $E:SHLVL)) {
    set E:__zoxide_shlvl = $E:SHLVL
    set builtin:after-chdir = [$@builtin:after-chdir {|_| zoxide add -- $pwd }]
}

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

# Jump to a directory using only keywords.
fn __zoxide_z {|@rest|
    if (builtin:eq [] $rest) {
        __zoxide_cd ~
    } elif (builtin:eq [-] $rest) {
        __zoxide_cd $oldpwd
    } elif (and ('builtin:==' (builtin:count $rest) 1) (path:is-dir &follow-symlink=$true $rest[0])) {
        __zoxide_cd $rest[0]
    } else {
        var path
        try {
            set path = (zoxide query --exclude $pwd -- $@rest)
        } catch {
        } else {
            __zoxide_cd $path
        }
    }
}
edit:add-var __zoxide_z~ $__zoxide_z~

# Jump to a directory using interactive search.
fn __zoxide_zi {|@rest|
    var path
    try {
        set path = (zoxide query -i -- $@rest)
    } catch {
    } else {
        __zoxide_cd $path
    }
}
edit:add-var __zoxide_zi~ $__zoxide_zi~

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

edit:add-var z~ $__zoxide_z~
edit:add-var zi~ $__zoxide_zi~

# Load completions.
fn __zoxide_z_complete {|@rest|
    if (!= (builtin:count $rest) 2) {
        builtin:return
    }
    edit:complete-filename $rest[1] |
        builtin:each {|completion|
            var dir = $completion[stem]
            if (path:is-dir $dir) {
                builtin:put $dir
            }
        }
}
set edit:completion:arg-completer[z] = $__zoxide_z_complete~

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually
# ~/.elvish/rc.elv):
#
#   eval (zoxide init elvish | slurp)
#
# Note: zoxide only supports elvish v0.18.0 and above.
