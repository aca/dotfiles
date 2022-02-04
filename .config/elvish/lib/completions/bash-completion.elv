use str
use path

var rc_dir = (path:dir (src)[name])

# /usr/local/etc/bash_completion.d
# /usr/local/etc/profile.d/bash_completion.sh
# /usr/share/bash-completion/completions
# /usr/share/bash-completion/bash_completion

fn bash_completion { |name @cmd|
  var f = {|@cmd|
    if (eq $cmd []) {
      return
    }
    # The fix allowing to use aliases with this function
    # We could call if as 'k get ...' or 'blabla get ...'
    # It will be always ssh
    set cmd[0] = $name
    var bash_function = _$name

# E|21:54 | echo 'echo hello $1 $2' | bash --norc --noprofile -s 3 4 5
# hello 3 fd

# source $1/bash_completion && source $1/ssh-completion.bash
# shift
#
# COMP_CWORD=$1
# shift
#
# COMPREPLY=()
# COMP_WORDBREAKS='"'"'"'><=;|&(:'
# COMP_LINE="$@"
# COMP_WORDS=($COMP_LINE)
# COMP_POINT=${#COMP_LINE}
# _ssh 2>/dev/null # elvish is looking for StdErr also
# printf '%s\n' "${COMPREPLY[@]}"

    var completions = [(
  echo '
source /usr/local/etc/profile.d/bash_completion.sh
source /usr/local/etc/bash_completion.d/$1
fn=$2
shift; shift;
COMP_CWORD=$1
shift
COMPREPLY=()
COMP_WORDBREAKS=''"''"''"''><=;|&(:''
COMP_LINE="$@"
COMP_WORDS=($COMP_LINE)
COMP_POINT=${#COMP_LINE}
$fn 2>/dev/null # elvish is looking for StdErr also
printf ''%s\n'' "${COMPREPLY[@]}"
' | bash --norc --noprofile -s $name $bash_function (- (count $cmd) 1) $@cmd | from-lines | each {|n| str:trim-space $n} )]
    var prefix = $cmd[-1]
    if (eq $prefix '') {
      put $@completions
    } else {
      if (not-eq $@completions []) {
        if (eq [] (each {|n| if (str:has-prefix $n $prefix) { put $n }} $completions)) {
          # no shared prefix
          # for example ssh --namespace= will return list of namespaces
          # we should add --namespace= prefix to each completion
          each {|n| put $prefix$n} $completions
        } else {
          put $@completions
        }
      }
    }
  }
  put $f
}

set edit:completion:arg-completer[pueue] = (bash_completion "pueue")

# set edit:completion:arg-completer[ssh] = (bash_completion "ssh")
# set edit:completion:arg-completer[ip] = (bash_completion "ip")
# set edit:completion:arg-completer[qemu] = (bash_completion "qemu")
# set edit:completion:arg-completer[rg] = (bash_completion "rg")
