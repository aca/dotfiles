# vim:foldmethod=marker foldmarker=[[,]]

#
# Reference
# https://github.com/xiaq/etc/blob/master/rc.elv

# epm:install github.com/zzamboni/elvish-completions
# use github.com/zzamboni/elvish-completions/cd

# epm:install github.com/ezh/elvish-bash-completion

use str
use zoxide

use carapace
use elvish-bash-completion/git
use elvish-bash-completion/kubectl

use edit.elv/smart-matcher
smart-matcher:apply

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
    try {
      if (< $m[duration] 2) {
        return
      }
      if (str:has-prefix $m[src][code] "cd (vifm") {
        return
      }
      print (styled (styled (printf "« took: %.3fs / done: "(date "+%Y-%m-%d %H:%M:%S") $m[duration])"\n" red) italic)
    } except {

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
fn l {|@a| 
  # e:ls $@a
  e:exa --icons -1
}
fn la {|@a| e:ls -a $@a }
fn ll {|@a|
  # e:ls -alt [&darwin=-G &linux=--color=auto][$platform:os] $@a 
  # https://github.com/fenetikm/falcon/blob/master/exa/EXA_COLORS
  e:exa -l --icons
}

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
fn s {|| cd (src.dir); sh -c "src.update &" }
fn x {|@a| cd (scratch $@a) }
# ]]

# wrapper
fn ghq { |@a| e:ghq $@a; sh -c "src.update &" }
fn dc {|@a| cd $@a }
fn zs {|@a| zsh $@a }
fn from-0 { || from-terminated "\x00" }

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
