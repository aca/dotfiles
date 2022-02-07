# vim:foldmethod=marker foldmarker={{{,}}}

#
# Reference
# https://github.com/xiaq/etc/blob/master/rc.elv

# epm:install github.com/zzamboni/elvish-completions
# use github.com/zzamboni/elvish-completions/cd

use str
use zoxide

use elvish-bash-completion/bash-completer
set edit:completion:arg-completer[ssh] = (bash-completer:new "ssh")
set edit:completion:arg-completer[scp] = (bash-completer:new "scp")
set edit:completion:arg-completer[rg] = (bash-completer:new "rg")
set edit:completion:arg-completer[curl] = (bash-completer:new "curl")
set edit:completion:arg-completer[man] = (bash-completer:new "man")
set edit:completion:arg-completer[git] = (bash-completer:new "git" &bash_function="__git_wrap__git_main")
set edit:completion:arg-completer[killall] = (bash-completer:new "killall")
set edit:completion:arg-completer[ip] = (bash-completer:new "ip" &bash_function="_ip ip")
set edit:completion:arg-completer[kubectl] = (bash-completer:new "kubectl" &bash_function="__start_kubectl")
set edit:completion:arg-completer[k] = $edit:completion:arg-completer[kubectl]
set edit:completion:arg-completer[aria2c] = (bash-completer:new "aria2c")
set edit:completion:arg-completer[journalctl] = (bash-completer:new "journalctl" &bash_function="_journalctl journalctl")
set edit:completion:arg-completer[virsh] = (bash-completer:new "virsh" &bash_function="_virsh_complete virsh")
set edit:completion:arg-completer[iptables] = (bash-completer:new "iptables" &bash_function="_iptables iptables")
set edit:completion:arg-completer[tcpdump] = (bash-completer:new "tcpdump" &bash_function="_tcpdump tcpdump")
set edit:completion:arg-completer[umount] = (bash-completer:new "umount" &bash_function="_umount_module")

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
  styled [&$true=(whoami)@(hostname)' ' &$false=""][(has-env SSH_CLIENT)] yellow; styled 'E|'(date "+%H:%M")' ' '#7c7c7c'; styled '| ' 'red'
}
# set edit:rprompt = { styled 'ᑀ '(tilde-abbr $pwd) yellow }
set edit:rprompt = { styled (tilde-abbr $pwd) yellow }
# set edit:before-readline = [
# ]

set edit:after-readline = [
  {|args|
    # https://gitlab.freedesktop.org/Per_Bothner/specifications/blob/master/proposals/semantic-prompts.md
    printf "\033]133;C;\007"
  }
]

set edit:after-command = [
  {|m|
    # https://gitlab.freedesktop.org/Per_Bothner/specifications/blob/master/proposals/semantic-prompts.md
    printf "\033]133;A;cl=m;aid=%s\007" $pid
    if (< $m[duration] 5) {
      nop
    } else {
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
