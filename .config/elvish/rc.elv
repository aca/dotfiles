# Reference
# https://github.com/xiaq/etc/blob/master/rc.elv

use interactive
use str
use platform
use path

# if (and (has-env WEZTERM_PANE) (not (has-env NVIM_LISTEN_ADDRESS))) {
#   set-env NVIM_LISTEN_ADDRESS "/tmp/nvim"$E:WEZTERM_PANE
# }

if (not (has-env _ELVISH_INIT)) { 
    # http://www.linusakesson.net/programming/tty/
    stty -ixon
    use /env 

    set-env _ELVISH_INIT 1
}

fn history {
    edit:command-history &dedup &newest-first &cmd-only | to-lines
}

use /funcs
use /bind
use /completion
use /git-subrepo-elvish/.elvish
use /prompt
use plugins/edit.elv/smart-matcher; smart-matcher:apply
if (has-external zoxide) { use /zoxide }
nop ?(use local)

fn l {|@a| e:ls -1U [&darwin=-G &linux=--color=auto][$platform:os] $@a }
fn la {|@a| e:ls -alU [&darwin=-G &linux=--color=auto][$platform:os] $@a }
fn ll {|@a| e:ls -alU [&darwin=-G &linux=--color=auto][$platform:os] $@a }
fn w { nop ?(cd ~/src/scratch/(fd --base-directory ~/src/scratch --strip-cwd-prefix --hidden --type d --max-depth 1 --no-ignore -0 | fzf --read0)) }
# directory
fn s {|| cd (src.dir)}
fn x {|@a| cd (scratch $@a) }
fn grt { cd (or (e:git rev-parse --show-toplevel 2>/dev/null) (echo ".")) }
fn cdf { |p| try { isDir $p; cd $p } catch { cd (dirname $p) } }
fn ffc { || $cdf~ (ff)  }

# wrapper
fn ghq { |@a| e:ghq $@a; sh -c "src.update &" }
fn ghqbare { |@a| e:ghq clone --bare $@a;  ;sh -c "src.update &" }
fn zs {|@a| zsh $@a }
fn rm {|@a| if (has-external trash-put) { e:trash-put -v $@a } else { e:rm -rv $@a } }
fn trash-empty { |@a| yes | e:trash-empty }
fn vifm {|@a| cd (e:vifm -c 'nnoremap s :quit<cr>' $@a --choose-dir -) }; fn f {|@a| vifm $@a}
fn v {|@a| if (has-external nvim) { e:nvim $@a } else { e:vim $@a }}
fn vim {|@a| if (has-external nvim) { e:nvim $@a } else { e:vim $@a }}

# utils
fn from-0 { || from-terminated "\x00" }
fn export { |v| set-env (echo $v | cut -d '=' -f 1) (echo $v | cut -d '=' -f 2-) }

# UNIX comm alternative but keep original output sorted
# list all non md files
#   λ fd --type f | filterline fd --extension 'md'
fn filterline {
  |@rest|
  var second = [(eval (echo $@rest))]
  from-lines | each {
    |x|
    if (not (has-value $second $x)) {
      echo $x
    }
  }
}

# warp proxy
fn proxyon { 
    set-env http_proxy "http://localhost:40000/"
    set-env https_proxy "http://localhost:40000/"
    set-env no_proxy "127.0.0.1,localhost,192.168.0.0/16"
}

fn proxyoff {
    unset-env http_proxy
    unset-env https_proxy
    unset-env no_proxy 
}
