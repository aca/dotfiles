# vim:foldmethod=marker foldmarker=[[,]]
#
# Reference
# https://github.com/xiaq/etc/blob/master/rc.elv

# use str
use platform
# use math

use /env
use /utils
use /bind
use /completion

# vi mode binding https://github.com/elves/elvish/issues/971
set edit:insert:binding[Ctrl-'['] = $edit:command:start~
set edit:rprompt-persistent = $true

if (eq $E:SSH "") {
  set edit:prompt = ( constantly (styled 'λ ' '#baae57'))
} else {
  set edit:prompt = ( constantly (styled (whoami)@(hostname) 'λ ' inverse)  )
}

set edit:rprompt = { tilde-abbr $pwd }

# abbr [[
fn ll {|@a| e:ls -alt [&darwin=-G &linux=--color=auto][$platform:os] $@a }

# TODO: https://github.com/elves/elvish/issues/1472
# set edit:small-word-abbr['k'] = 'kubectl'
# set edit:small-word-abbr['v'] = 'nvim'
# set edit:small-word-abbr['os'] = 'openstack '
# set edit:small-word-abbr['ta'] = 'tmux attach -t '
# set edit:small-word-abbr['elv'] = 'elvish'
# set edit:abbr['l '] = 'less '

# This should be replaced to abbr later
fn v {|@a| nvim $@a }
fn k {|@a| kubectl $@a }
fn w {|@a| cd (src.dir) }
# ]]

# wrapper
fn ghq { |@a| e:ghq $@a; sh -c "src.update &" }


# set edit:abbr['ci '] = 'pbcopy'
# set edit:abbr['co '] = 'pbpaste'
# set edit:abbr['copyq.history '] = 'copyq read (seq 0 100) | nvim - '
# set edit:abbr['cp '] = 'command cp -vrp '
# set edit:abbr['v- '] = 'nvim - '
# set edit:abbr['dc '] = 'cd '
# set edit:abbr['sp- '] = 'shuf | mpv --playlists=-'
# set edit:abbr['cp ']  = 'cp -vrp '
#
# set edit:abbr['ll']  = 'ls -al'
#
