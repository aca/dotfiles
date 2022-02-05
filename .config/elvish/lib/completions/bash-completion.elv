use str
use path
use platform

fn bash-completer { |&bash_function="" &completion_filename="" name @cmd|
  var f = {|@cmd|
    if (eq $cmd []) {
      return
    }

    if (eq $bash_function "") {
      set bash_function = _$name
    }

    if (eq $completion_filename "") {
      set completion_filename = $name
    }

    # The fix allowing to use aliases with this function
    # We could call if as 'k get ...' or 'blabla get ...'
    # It will be always ssh
    set cmd[0] = $name

    var bash_completion_script = 'source /usr/share/bash-completion/bash_completion
source /usr/share/bash-completion/completions/$1 2>/dev/null
'
    if (eq $platform:os "darwin") {
      set bash_completion_script = "source /usr/local/share/bash-completion/bash_completion
/usr/local/share/bash-completion/completions/$1 2>/dev/null
/usr/local/share/bash-completion/bash_completion/$1 2>/dev/null
"
    }

    # TODO: Do we need COMP_WORDBREAKS?
    var completions = [(
  echo $bash_completion_script'
fn=$2
shift; shift;
COMP_CWORD=$1
shift
COMPREPLY=()
COMP_WORDBREAKS=''"''"''"''><=;|&(:'' 
COMP_LINE="$@"
COMP_WORDS=($COMP_LINE)

if [ "${COMP_LINE: -1}" = " " ]; then
  COMP_WORDS+=("")
fi

COMP_POINT=${#COMP_LINE}
$fn 2>/dev/null # elvish is looking for StdErr also
printf ''%s\n'' "${COMPREPLY[@]}"
' | bash --norc --noprofile -s $completion_filename $bash_function (- (count $cmd) 1) $@cmd | from-lines | each {|n| str:trim-space $n} )]
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

set edit:completion:arg-completer[umount] = (bash-completer "umount" &bash_function="_umount_module")
set edit:completion:arg-completer[ssh] = (bash-completer "ssh")
set edit:completion:arg-completer[scp] = (bash-completer "scp")
set edit:completion:arg-completer[ip] = (bash-completer "ip" &bash_function="_ip ip")
set edit:completion:arg-completer[rg] = (bash-completer "rg")
set edit:completion:arg-completer[fd] = (bash-completer "fd" &bash_function="_fd fd")
set edit:completion:arg-completer[curl] = (bash-completer "curl")
set edit:completion:arg-completer[gh] = (bash-completer "gh" &bash_function="__start_gh")
set edit:completion:arg-completer[git] = (bash-completer "git" &bash_function="__git_wrap__git_main")
set edit:completion:arg-completer[man] = (bash-completer "man")
set edit:completion:arg-completer[killall] = (bash-completer "man")
set edit:completion:arg-completer[pkill] = (bash-completer "pkill" &bash_function="pgrep")
set edit:completion:arg-completer[systemctl] = (bash-completer "systemctl" &bash_function="_systemctl systemctl")
set edit:completion:arg-completer[virsh] = (bash-completer "virsh" &bash_function="_virsh_complete virsh")
set edit:completion:arg-completer[aria2c] = (bash-completer "aria2c")
