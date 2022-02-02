# vim:foldmethod=marker foldmarker={{{,}}}

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

stty -ixon # https://github.com/elves/elvish/issues/1488

# prompt {{{
# vi mode binding https://github.com/elves/elvish/issues/971
set edit:insert:binding[Ctrl-'['] = $edit:command:start~
set edit:rprompt-persistent = $false
set edit:prompt = { 
  styled [&$true=(whoami)@(hostname)' ' &$false=""][(has-env SSH_CLIENT)]'E|'(date "+%H:%M")' ' '#7c7c7c'; styled '| ' 'red'
}
set edit:rprompt = { styled 'ᑀ '(tilde-abbr $pwd) yellow }
# set edit:before-readline = [
#   {
#     noti -m "before"
#   }
# ]
set edit:after-readline = [
  {|args|
    printf "\033]133;C;\007"
  }
]
set edit:after-command = [
  {|m|
    printf "\033]133;A;cl=m;aid=%s\007" $pid
    if (< $m[duration] 5) {
      nop
    } else {
      # if (str:has-prefix $m[src][code] "cd") {
      #   return
      # }

      print (styled (styled (printf "« took: %.3fs / done: "(date "+%Y-%m-%d %H:%M:%S") $m[duration])"\n" red) italic)
    }
  }
]

# }}}
# abbr {{{
# fn l {|@a| if (has-external exa) { e:exa --icons -1 $@a } else { e:ls -1 $@a } }
fn l {|@a| e:ls -1U $@a }
fn la {|@a| e:ls -alU $@a }
# fn ll {|@a| if (has-external exa) { e:exa -l --icons $@a } else { e:ls -lt [&darwin=-G &linux=--color=auto][$platform:os] $@a }}
fn ll {|@a| e:ls -lU $@a }
fn rm {|@a| if (has-external trash-put) { e:trash-put -v $@a } else { e:rm -rv $@a } }
fn vifm {|@a| cd (e:vifm -c 'nnoremap s :quit<cr>' $@a --choose-dir -) }
fn f { vifm }

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
fn s {|| cd (src.dir)}
fn dc {|@a| cd $@a }
fn x {|@a| cd (scratch $@a) }
fn elv { |@a| e:elvish $@a }
# }}}

# wrapper
fn ghq { |@a| e:ghq $@a; sh -c "src.update &" }
fn zs {|@a| zsh $@a }

# utils
fn from-0 { || from-terminated "\x00" }

# UNIX comm alternative but keep sorted
# list all non md files
#   λ fd --type f | filterline fd --extension 'md'
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

# UNIX comm alternative but keep sorted
# list all non md files
#   λ fd --type f | filterline fd --extension 'md'
fn matchline {
  |@rest|
  var second = [(eval (echo $@rest))]
  from-lines | each {
    |x|
    if (not (has-value $second $x)) {
      put $x
    }
  }
}
