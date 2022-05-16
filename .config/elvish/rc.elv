# vim:foldmethod=marker foldmarker={{{,}}}

#
# Reference
# https://github.com/xiaq/etc/blob/master/rc.elv

use str
use platform

use /env
use /utils
use /bind
use /completion
use /prompt
use plugins/edit.elv/smart-matcher; smart-matcher:apply
if (has-external zoxide) { use /zoxide }
# use github.com/zzamboni/elvish-modules/nix; nix:single-user-setup

nop ?(use local)

# }}}
# abbr {{{
# TODO: https://github.com/elves/elvish/issues/1472
# set edit:small-word-abbr['k'] = 'kubectl'
# set edit:small-word-abbr['v'] = 'nvim'
# set edit:small-word-abbr['os'] = 'openstack '
# set edit:small-word-abbr['ta'] = 'tmux attach -t '
# set edit:small-word-abbr['elv'] = 'elvish'
# set edit:abbr['l '] = 'less '

fn l {|@a| e:ls -1U [&darwin=-G &linux=--color=auto][$platform:os] $@a }
fn la {|@a| e:ls -alU [&darwin=-G &linux=--color=auto][$platform:os] $@a }
# fn ll {|@a| if (has-external exa) { e:exa -l --icons $@a } else { e:ls -lt [&darwin=-G &linux=--color=auto][$platform:os] $@a }}
fn ll {|@a| e:ls -alU [&darwin=-G &linux=--color=auto][$platform:os] $@a }
fn dc {|@a| cd $@a }
fn w { nop ?(cd ~/src/scratch/(fd --base-directory ~/src/scratch --strip-cwd-prefix --hidden --type d --max-depth 1 --no-ignore -0 | fzf --read0)) }
fn v {|@a| e:nvim $@a }
# fn e {|@a| edit:clear; tmux clear-history; }
fn k {|@a| e:kubectl $@a }
fn elv { |@a| e:elvish $@a }
fn mkdir { |@a| e:mkdir -p $@a }

# cd
fn s {|| cd (src.dir)}
fn x {|@a| cd (scratch $@a) }
fn grt { cd (or (e:git rev-parse --show-toplevel 2>/dev/null) (echo ".")) }
fn cdf { |p| try { isDir $p; cd $p } catch { cd (dirname $p) }  }
fn ffc { || $cdf~ (ff)  }
# }}}

# wrapper
fn ghq { |@a| e:ghq $@a; sh -c "src.update &" }
fn zs {|@a| zsh $@a }
fn rm {|@a| if (has-external trash-put) { e:trash-put -v $@a } else { e:rm -rv $@a } }
fn trash-empty { |@a| yes | e:trash-empty }
fn mv {|@a| e:mv -v -n $@a }
fn cp {|@a| e:cp -rp -v -n $@a }
# fn jq { |@a| e:jq -R 'fromjson?' | e:jq $@a }
fn vifm {|@a| cd (e:vifm -c 'nnoremap s :quit<cr>' $@a --choose-dir -) }; fn f {|@a| vifm $@a}

# utils
fn from-0 { || from-terminated "\x00" }
fn export { |v| set-env (echo $v | cut -d '=' -f 1) (echo $v | cut -d '=' -f 2-) }

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
