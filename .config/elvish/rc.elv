# vim:foldmethod=marker foldmarker={{{,}}}

#
# Reference
# https://github.com/xiaq/etc/blob/master/rc.elv

use str
use platform

use /env
use /utils
use /bind
use /zoxide
use /completion
use /prompt
use edit.elv/smart-matcher; smart-matcher:apply

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
# fn e {|@a| edit:clear; tmux clear-history; }
fn k {|@a| kubectl $@a }
fn elv { |@a| e:elvish $@a }

# cd
fn s {|| cd (src.dir)}
fn dc {|@a| cd $@a }
fn x {|@a| cd (scratch $@a) }
fn grt { cd (or (git rev-parse --show-toplevel 2>/dev/null) (echo ".")) }

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
