# Reference
# - https://github.com/xiaq/etc/blob/master/rc.elv
#
# TODO: 
#
# - find alternative to eval, this doesn't work
#   - fn ign { |$@a| nop ($@a) }
#   - fn ign { |$@a| nop ($a[0] $a[1:]) }
# 
# - extension to stdlib, (list in operation)
#
# var a
# set a @args = $@args
# if (!=s $a '') { set @args = --query=$a -1 $@args }
# fzf $@args
#
# Of course, if this is at the head of a function replace @args by `a @args` in the function signature, and drop the first two lines.

use interactive
use str
use platform
use path

if (not (has-env _ELVISH_INIT)) { 
    stty -ixon # http://www.linusakesson.net/programming/tty/
    use /env 
    set-env _ELVISH_INIT 1
}

use /bind
use /completion
use /prompt
use plugins/edit.elv/smart-matcher; smart-matcher:apply
nop ?(use local)

# move
fn w { nop ?(cd ~/src/scratch/(fd --base-directory ~/src/scratch --strip-cwd-prefix --hidden --type d --max-depth 1 --no-ignore -0 | fzf --read0)) }
fn s {|| cd (src.dir)}
fn x {|@a| cd (scratch $@a) }
fn d {|@a| cd ~/src/github.com/aca/dotfiles }
fn dot.v {|@a| cd ~/src/github.com/aca/dotfiles/.config/nvim }
fn grt { cd (e:git rev-parse --show-toplevel) }
fn cdf { |p| try { isDir $p; cd $p } catch { cd (dirname $p) } }
fn ffc { |@a| $cdf~ (ff)  }

# basics
fn la {|@a| e:ls -alU [&darwin=-G &linux=--color=auto][$platform:os] $@a }
fn l {|@a| e:ls -1U [&darwin=-G &linux=--color=auto][$platform:os] $@a }
fn ll {|@a| e:ls -alU [&darwin=-G &linux=--color=auto][$platform:os] $@a }
fn make {|@a| e:make --directory (find.rootdir Makefile $E:HOME) $@a }

# wrappers
fn cp { |@a| if (has-external advcp) { e:advcp -g $@a } else { e:cp -v $@a } }
fn mv { |@a| if (has-external advmv) { e:advmv -g $@a } else { e:mv $@a } }
fn rm {|@a| if (has-external trash-put) { e:trash-put -v $@a } else { e:rm -rv $@a } }
fn ghq { |@a| e:ghq $@a; sh -c "src.update &" }
fn ghqbare { |@a| e:ghq clone --bare $@a;  ;sh -c "src.update &" }
fn zs {|@a| zsh $@a }
fn trash-empty { |@a| yes | e:trash-empty }
fn vifm {|@a| cd (e:vifm $@a --choose-dir -) }; fn f {|@a| vifm $@a}
fn v {|@a| if (has-external nvim) { e:nvim $@a } else { e:vim $@a }}
fn vim {|@a| if (has-external nvim) { e:nvim $@a } else { e:vim $@a }}

# utils
fn from-0 { || from-terminated "\x00" }
fn export { |v| put $v | str:split &max=2 '=' (one) | set-env (all) }
fn history { edit:command-history &dedup &newest-first &cmd-only | to-lines }

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
    # $@a # FIXME: What's wrong with this
    # $a[0] $a[1:] # FIXME: What's wrong with this
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
# https://github.com/elves/elvish/issues/1721~/.config/elvish/rc.elv:90
#
# fd --type f | grep 'html'
# fd --type f | from-lines | filter { |x| str:contains $x 'html' } [(all)]
#
# fd --type f | grep -v 'html'
# fd --type f | from-lines | filter &not=true { |x| str:contains $x 'html' } [(all)]
#
# filter { |x| > 3 $x } [ 1 2 3 4 ]
fn filter {|pred~ @items &not=$false &out=$put~|
  var ck~ = $pred~
  if $not { set ck~ = {|item| not (pred $item)} }
  each {|item| if (ck $item) { $out $item }} $@items
}
