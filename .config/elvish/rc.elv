# vim:foldmethod=marker foldmarker=[[,]]

#
# Reference
# https://github.com/xiaq/etc/blob/master/rc.elv

use epm
use str
use zoxide

# use epm
# epm:install github.com/zzamboni/elvish-completions

# use github.com/zzamboni/elvish-completions/git
#
# # epm:install github.com/href/elvish-gitstatus
# # epm:install github.com/zzamboni/elvish-themes
# use github.com/href/elvish-gitstatus/gitstatus

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

var hostinfo = ''
if (not-eq $E:SSH_CLIENT "") {
  set hostinfo = (whoami)@(hostname)' '
}
set edit:prompt = { styled $hostinfo'E|'(date "+%H:%M")' ' '#7c7c7c'; styled '| ' 'red'   }
set edit:rprompt = { styled (tilde-abbr $pwd) yellow }

set edit:after-command = [
  {|m| 
    if (> $m[duration] 2) {
      print (styled (styled (printf "« took: %.3fs / done: "(date "+%Y-%m-%d %H:%M:%S") $m[duration])"\n" red) italic)
    }
  }
]

# set edit:prompt = {
#     var git = (gitstatus:query $pwd)
#
#     if (bool $git[is-repository]) {
#
#         # show the branch, or current commit if not on a branch
#         var branch = ''
#         if (eq $git[local-branch] "") {
#             set branch = $git[commit][:8]
#         } else {
#             set branch = $git[local-branch]
#         }
#
#         put '|'
#         put (styled $branch red)
#
#         # show a state indicator
#         if (or (> $git[unstaged] 0) (> $git[untracked] 0)) {
#             put (styled '*' yellow)
#         } elif (> $git[staged] 0) {
#             put (styled '*' green)
#         } elif (> $git[commits-ahead] 0) {
#             put (styled '^' yellow)
#         } elif (> $git[commits-behind] 0) {
#             put (styled '⌄' yellow)
#         }
#
#     }
# }

# abbr [[
fn l {|@a| e:ls $@a }
fn la {|@a| e:ls -a $@a }
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
fn w {|| cd (src.dir); sh -c "src.update &" }
# ]]

# wrapper
fn ghq { |@a| e:ghq $@a; sh -c "src.update &" }
fn dc {|@a| cd $@a }


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


# UNIX comm alternative but keep sorted
# list all non md files
# 
#   λ fd --type f | filterline fd --extension 'md' 
# 
fn filterline {
  |@rest|
  var second = [(eval (echo $@rest))]
  from-lines | each { 
    |x|  
    if (not (has-value $second $x)) {
      put $x
    }
  }
}
