# set edit:completion:arg-completer[cd] = {|@args|
#   use path
#   edit:complete-filename '' |  each {|x| if (path:is-dir $x[stem]) { put $x[stem] } }
#   edit:complete-filename '.' |  each {|x| if (path:is-dir $x[stem]) { put $x[stem] } }
# }

use platform

use elvish-bash-completion/bash-completer
# use github.com/aca/elvish-bash-completion/bash-completer
set edit:completion:arg-completer[aria2c] = (bash-completer:new "aria2c")
set edit:completion:arg-completer[curl] = (bash-completer:new "curl")
set edit:completion:arg-completer[docker] = (bash-completer:new "docker")
set edit:completion:arg-completer[fd] = (bash-completer:new "fd")
set edit:completion:arg-completer[gh] = (bash-completer:new "gh" &bash_function="__start_gh gh")
set edit:completion:arg-completer[git] = (bash-completer:new "git" &bash_function="__git_wrap__git_main")
set edit:completion:arg-completer[ip] = (bash-completer:new "ip" &bash_function="_ip ip")
set edit:completion:arg-completer[kill] = (bash-completer:new "kill")
set edit:completion:arg-completer[killall] = (bash-completer:new "killall")
set edit:completion:arg-completer[kubectl] = (bash-completer:new "kubectl" &bash_function="__start_kubectl"); set edit:completion:arg-completer[k] = $edit:completion:arg-completer[kubectl]
set edit:completion:arg-completer[make] = (bash-completer:new "make" )
set edit:completion:arg-completer[man] = (bash-completer:new "man")
set edit:completion:arg-completer[pkill] = (bash-completer:new "pgrep")
set edit:completion:arg-completer[pueue] = (bash-completer:new "pueue" )
set edit:completion:arg-completer[rg] = (bash-completer:new "rg")
set edit:completion:arg-completer[scp] = (bash-completer:new "scp")
set edit:completion:arg-completer[ssh] = (bash-completer:new "ssh")
set edit:completion:arg-completer[sudo] = $edit:complete-sudo~
set edit:completion:arg-completer[time] = $edit:complete-sudo~
set edit:completion:arg-completer[tmux] = (bash-completer:new "tmux")
set edit:completion:arg-completer[umount] = (bash-completer:new "umount" &bash_function="_umount_module")
set edit:completion:arg-completer[virsh] = (bash-completer:new "virsh" &bash_function="_virsh_complete virsh")
set edit:completion:arg-completer[which] = (bash-completer:new "which"  &bash_function="_complete type" &completion_filename="complete")
if (eq $platform:os "darwin") {
  set edit:completion:arg-completer[limactl] = (bash-completer:new "limactl" &bash_function="__start_limactl limactl")
  set edit:completion:arg-completer[colima] = (bash-completer:new "colima" &bash_function="__start_colima colima")
} else {
  set edit:completion:arg-completer[journalctl] = (bash-completer:new "journalctl" &bash_function="_journalctl journalctl")
  set edit:completion:arg-completer[systemctl] = (bash-completer:new "systemctl" &bash_function="_systemctl systemctl")
  set edit:completion:arg-completer[iptables] = (bash-completer:new "iptables" &bash_function="_iptables iptables")
  set edit:completion:arg-completer[tcpdump] = (bash-completer:new "tcpdump" &bash_function="_tcpdump tcpdump")
}

set edit:completion:arg-completer[lcache] = { |@cmd|
    var cmdlen = (count $cmd)
    if (eq $cmdlen 1) {
      put 'get' 'set'
    } else {
      nop ?(ls ~/.cache/lcache)
    }
}
