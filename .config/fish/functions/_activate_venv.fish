#!/usr/bin/env fish

# function _activate_venv --on-event fish_preexec
#     noti
#     builtin cd $argv

#     if set gitdir (git rev-parse --show-toplevel 2>/dev/null) && test -d $gitdir/venv
#       if test \( -z "$VIRTUAL_ENV" -o "$VIRTUAL_ENV" != "$gitdir/venv" \)
#           source $gitdir/venv/bin/activate.fish
#       end

#       if test -n "$VIRTUAL_ENV" -a "$VIRTUAL_ENV" != "$gitdir/venv"
#           deactivate
#       end
#     end
# end
