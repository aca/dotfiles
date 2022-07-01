set edit:command-abbr[gco] = 'git checkout'
set edit:command-abbr[k] = 'kubectl'
set edit:command-abbr['k'] = 'kubectl'
set edit:command-abbr['v'] = 'nvim'
set edit:command-abbr['os'] = 'openstack '
set edit:command-abbr['ta'] = 'tmux attach -t '
set edit:command-abbr['elv'] = 'elvish'
set edit:command-abbr['mkdir'] = 'mkdir -p'
set edit:command-abbr['dc'] = 'cd'
set edit:command-abbr['cp'] = 'cp -rpvn'
set edit:command-abbr['mv'] = 'mv -vn'

set edit:command-abbr['virsh'] = 'sudo virsh'
set edit:command-abbr['virt-customize'] = 'sudo virt-customize'
set edit:command-abbr['virt-clone'] = 'sudo virt-clone'
set edit:command-abbr['virt-install'] = 'sudo virt-install'

# Reference
# https://github.com/xiaq/etc/blob/master/rc.elv

use str
use platform

use /env
use /funcs
use /bind
use /completion
use /git-subrepo-elvish/.elvish
use /prompt
use plugins/edit.elv/smart-matcher; smart-matcher:apply
if (has-external zoxide) { use /zoxide }
nop ?(use local)

# }}}
# abbr {{{

fn l {|@a| e:ls -1U [&darwin=-G &linux=--color=auto][$platform:os] $@a }
fn la {|@a| e:ls -alU [&darwin=-G &linux=--color=auto][$platform:os] $@a }
# fn ll {|@a| if (has-external exa) { e:exa -l --icons $@a } else { e:ls -lt [&darwin=-G &linux=--color=auto][$platform:os] $@a }}
fn ll {|@a| e:ls -alU [&darwin=-G &linux=--color=auto][$platform:os] $@a }
fn w { nop ?(cd ~/src/scratch/(fd --base-directory ~/src/scratch --strip-cwd-prefix --hidden --type d --max-depth 1 --no-ignore -0 | fzf --read0)) }
fn vim {|@a| e:nvim $@a }
# fn e {|@a| edit:clear; tmux clear-history; }
fn k {|@a| e:kubectl $@a }

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
