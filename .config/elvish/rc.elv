# Reference
# - https://github.com/xiaq/etc/blob/master/rc.elv
#
# TODO: use `constantly` to cache elvish

use interactive
use str
use platform
use path

# if (has-external zoxide) { 
#     use /zoxide 
#     set notify-bg-job-success = $false
#     set after-chdir = [{|_| zoxide add -- $pwd & }]
# }

if (not (has-env _ELVISH_INIT)) { 
    # http://www.linusakesson.net/programming/tty/
    stty -ixon
    use /env 

    set-env _ELVISH_INIT 1
}

use /funcs
use /bind
use /completion
# use /git-subrepo-elvish/.elvish
use /prompt
use plugins/edit.elv/smart-matcher; smart-matcher:apply

nop ?(use local)

fn d {|@a| cd ~/src/configs/dotfiles }
fn l {|@a| e:ls -1U [&darwin=-G &linux=--color=auto][$platform:os] $@a }
fn la {|@a| e:ls -alU [&darwin=-G &linux=--color=auto][$platform:os] $@a }
fn ll {|@a| e:ls -alU [&darwin=-G &linux=--color=auto][$platform:os] $@a }
fn w { nop ?(cd ~/src/scratch/(fd --base-directory ~/src/scratch --strip-cwd-prefix --hidden --type d --max-depth 1 --no-ignore -0 | fzf --read0)) }
# directory
fn s {|| cd (src.dir)}
fn x {|@a| cd (scratch $@a) }
fn dot {|@a| cd ~/src/root/dotfiles }
fn dot.v {|@a| cd ~/src/root/dotfiles/.config/nvim }
fn grt { cd (e:git rev-parse --show-toplevel) }
fn cdf { |p| try { isDir $p; cd $p } catch { cd (dirname $p) } }
fn ffc { || $cdf~ (ff)  }
# fn sudo {|@a| if (eq 0 (id -u)) {
#         e:sudo $@a
#     } else {
#          $a[0] }
#     }
# }

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
fn export { |v| put $v | str:split &max=2 '=' (one) | set-env (all) }

# cloudflare warp proxy
# fn proxyon { 
#     set-env http_proxy "http://localhost:40000/"
#     set-env https_proxy "http://localhost:40000/"
#     set-env no_proxy "127.0.0.1,localhost,192.168.0.0/16"
# }
#
# fn proxyoff {
#     unset-env http_proxy
#     unset-env https_proxy
#     unset-env no_proxy 
# }

fn str-to-rune-array { |x|
    put [ (str:split '' $x) ]
}

fn ign { |@a|
    try {
        eval (repr $@a)
    } catch {
        nop   
    }
}

# diff (echo 1 | psub) (echo 2 | psub)
fn psub {
    var output = (mktemp)
    cat > $output
    echo $output
}

# Filters a sequence of items and outputs those for whom the function outputs $true.
#
# exclude csv
#
#   fd --type f | filter { |x| not (str:contains $x "csv") }
#
fn filter {|&out=$false func~ @inputs|
    if $out {
        each {|item| if (not (func $item)) { put $item } } $@inputs
    } else {
        each {|item| if (func $item) { put $item } } $@inputs
    }
}

# UNIX comm alternative but keep original output sorted
# list all non md files
#   λ fd --type f | filterline fd --extension 'md'
fn filterline { |@rest|
  var second = [(eval (echo $@rest))]
  from-lines | each {
    |x|
    if (not (has-value $second $x)) {
      echo $x
    }
  }
}

# https://github.com/elves/elvish/issues/1721
# filter { |x| > 3 $x } [ 1 2 3 4]
fn filter {|pred~ @items &not=$false &out=$put~|
  var ck~ = $pred~
  if $not { set ck~ = {|item| not (pred $item)} }
  each {|item| if (ck $item) { $out $item }} $@items
}

fn fish-completion {|@words|
  use str
  # noti -m (str:join ' ' $words)
  # printf "complete -C killall" (str:join ' ' $words) | fish | from-lines 
  printf "complete -C %q" (str:join ' ' $words) | fish | from-lines | each { |x| 
    var cands = [(str:split &max=2 "\t" $x)]
    var n = (count $cands)
    if (== $n 2) {
        edit:complex-candidate $cands[0] &display=(str:join ' | ' $cands)
    } else {
        edit:complex-candidate $cands[0]
    }
  } 
}

# use github.com/xiaq/edit.elv/compl/go
#
use plugins/edit.elv/compl/go; go:apply
# set edit:completion:arg-completer[go] = $fish-completion~
set edit:completion:arg-completer[git] = $fish-completion~
set edit:completion:arg-completer[kubectl] = $fish-completion~
set edit:completion:arg-completer[pueue] = $fish-completion~
set edit:completion:arg-completer[systemctl] = $fish-completion~
set edit:completion:arg-completer[rg] = $fish-completion~
set edit:completion:arg-completer[ssh] = $fish-completion~
set edit:completion:arg-completer[aria2c] = $fish-completion~
set edit:completion:arg-completer[killall] = $fish-completion~
set edit:completion:arg-completer[just] = $fish-completion~
