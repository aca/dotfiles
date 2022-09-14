# Reference
# https://github.com/xiaq/etc/blob/master/rc.elv

set edit:command-abbr['gco'] = 'git checkout'
set edit:command-abbr['k'] = 'kubectl'
set edit:command-abbr['os'] = 'openstack '
set edit:command-abbr['ta'] = 'tmux attach -t'
set edit:command-abbr['elv'] = 'elvish'
set edit:command-abbr['mkdir'] = 'mkdir -p'
set edit:command-abbr['dc'] = 'cd'
set edit:command-abbr['cp'] = 'cp -rpvn'
set edit:command-abbr['ssht'] = 'ssh -t'
set edit:command-abbr['mv'] = 'mv -vn'
set edit:command-abbr['v'] = 'vim'
set edit:command-abbr['svc'] = 'sudo systemctl'
set edit:command-abbr['svcu'] = 'systemctl --user'
set edit:command-abbr['virsh'] = 'sudo virsh'
set edit:command-abbr['virt-customize'] = 'sudo virt-customize'
set edit:command-abbr['virt-clone'] = 'sudo virt-clone'
set edit:command-abbr['virt-install'] = 'sudo virt-install'

set edit:command-abbr['xargsi'] = 'xargs -I@'

use str
use platform

# if (and (has-env WEZTERM_PANE) (not (has-env NVIM_LISTEN_ADDRESS))) {
#   set-env NVIM_LISTEN_ADDRESS "/tmp/nvim"$E:WEZTERM_PANE
# }

if (not (has-env _ELVISH_INIT)) { 
    stty -ixon
    use /env 

    set-env _ELVISH_INIT 1
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
fn cdf { |p| try { isDir $p; cd $p } catch { cd (dirname $p) }  }
fn ffc { || $cdf~ (ff)  }
# }}}

# wrapper
fn ghq { |@a| e:ghq $@a; sh -c "src.update &" }
fn ghqbare { |@a| e:ghq clone --bare $@a;  ;sh -c "src.update &" }
fn zs {|@a| zsh $@a }
fn rm {|@a| if (has-external trash-put) { e:trash-put -v $@a } else { e:rm -rv $@a } }
fn trash-empty { |@a| yes | e:trash-empty }
# fn jq { |@a| e:jq -R 'fromjson?' | e:jq $@a }
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

# OSC52
# set edit:after-readline = [ $@edit:after-readline { |args| printf "\033]133;C;\007" } ]
# set edit:after-command = [ $@edit:after-command { |m| printf "\033]133;A;cl=m;aid=%s\007" $pid } ]

fn asdf-available {
    if ?(test -d $pwd/.asdf) {
        return
    } 

    var tmppath = $pwd
    {
        for i [0 0 0 0] {
            {
                if (eq $tmppath $E:HOME) {
                    fail 1 
                }
                if ?(test -f $tmppath/.tool-versions) {
                    return
                } 
                if ?(test -d $tmppath/.git) {
                    fail 1
                } 
                if ?(test -d $tmppath/.asdf) {
                    fail 1
                } 
            }
            set tmppath = $tmppath/../
        }
    }

    fail 1
}

set edit:before-readline = [
    { printf "\e]7;file://"$E:HOSTNAME$pwd"\e\\" }

    # this is fix for asdf performance issue
    {
        set paths = [(
            if ?(asdf-available) {
                put $@paths | { 
                    put ~/.asdf/bin ~/.asdf/shims
                    each { |x|
                        if (not (str:contains $x "/.asdf")) { 
                            put $x
                        } 
                    }; 
                }
            } else {
                put $@paths | { 
                    each { |x| 
                        if (not (str:contains $x "/.asdf")) { 
                            put $x
                        } 
                    }; 
                    put ~/.asdf/bin ~/.asdf/shims
                }
            }
        )]
    }
]
