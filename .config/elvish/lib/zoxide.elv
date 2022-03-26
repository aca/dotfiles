use builtin
use path

# =============================================================================
#
# Utility functions for zoxide.
#

# cd + custom logic based on the value of _ZO_ECHO.
fn __zoxide_cd [path]{
    builtin:cd $path
}

# =============================================================================
#
# Hook configuration for zoxide.
#

if (not (and (builtin:has-env __zoxide_hooked) (builtin:eq (builtin:get-env __zoxide_hooked) 1))) {
    builtin:set-env __zoxide_hooked 1

    # Initialize hook to track previous directory.
    builtin:set-env __zoxide_oldpwd $pwd
    before-chdir = [$@before-chdir [_]{ builtin:set-env __zoxide_oldpwd $pwd }]

    # Initialize hook to add directories to zoxide.
    after-chdir = [$@after-chdir [_]{ zoxide add -- $pwd }]
}

# =============================================================================
#
# When using zoxide with --no-aliases, alias these internal functions as
# desired.
#

# Jump to a directory using only keywords.
fn __zoxide_z [@rest]{
    if (builtin:eq [] $rest) {
        __zoxide_cd ~
    } elif (builtin:eq [-] $rest) {
        __zoxide_cd (builtin:get-env __zoxide_oldpwd)
    } elif (and (builtin:eq (builtin:count $rest) 1) (path:is-dir $rest[0])) {
        __zoxide_cd $rest[0]
    } else {
        __zoxide_cd (zoxide query --exclude $pwd -- $@rest)
    }
}
edit:add-var __zoxide_z~ $__zoxide_z~

# Jump to a directory using interactive search.
fn __zoxide_zi [@rest]{
    __zoxide_cd (zoxide query -i -- $@rest)
}
edit:add-var __zoxide_zi~ $__zoxide_zi~

# =============================================================================
#
# Convenient aliases for zoxide. Disable these using --no-aliases.
#

edit:add-var z~ $__zoxide_z~
edit:add-var zi~ $__zoxide_zi~

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually
# ~/.elvish/rc.elv):
#
# eval (zoxide init elvish | slurp)
