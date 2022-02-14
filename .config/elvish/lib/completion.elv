set edit:completion:arg-completer[cd] = {|@args|
  use path
  edit:complete-filename '' |  each {|x| if (path:is-dir $x[stem]) { put $x[stem] } }
  edit:complete-filename '.' |  each {|x| if (path:is-dir $x[stem]) { put $x[stem] } }
}

use platform

use elvish-bash-completion/bash-completer
set edit:completion:arg-completer[sudo] = $edit:complete-sudo~
set edit:completion:arg-completer[time] = $edit:complete-sudo~
set edit:completion:arg-completer[ssh] = (bash-completer:new "ssh")
set edit:completion:arg-completer[scp] = (bash-completer:new "scp")
set edit:completion:arg-completer[man] = (bash-completer:new "man")
set edit:completion:arg-completer[curl] = (bash-completer:new "curl")
set edit:completion:arg-completer[ip] = (bash-completer:new "ip")
set edit:completion:arg-completer[aria2c] = (bash-completer:new "aria2c")
set edit:completion:arg-completer[git] = (bash-completer:new "git" &bash_function="__git_wrap__git_main")
set edit:completion:arg-completer[killall] = (bash-completer:new "killall")
set edit:completion:arg-completer[kubectl] = (bash-completer:new "kubectl" &bash_function="__start_kubectl")
set edit:completion:arg-completer[k] = $edit:completion:arg-completer[kubectl]
set edit:completion:arg-completer[virsh] = (bash-completer:new "virsh" &bash_function="_virsh_complete virsh")
set edit:completion:arg-completer[umount] = (bash-completer:new "umount" &bash_function="_umount_module")
if (eq $platform:os "darwin") {
  set edit:completion:arg-completer[limactl] = (bash-completer:new "limactl" &bash_function="__start_limactl limactl")
  set edit:completion:arg-completer[colima] = (bash-completer:new "colima" &bash_function="__start_colima colima")
  set edit:completion:arg-completer[rg] = (bash-completer:new "rg" &bash_function="_rg rg" &completion_filename="rg.bash" )
  set edit:completion:arg-completer[fd] = (bash-completer:new "fd" &bash_function="_fd fd" &completion_filename="fd.bash" )
} else {
  set edit:completion:arg-completer[ip] = (bash-completer:new "ip" &bash_function="_ip ip")
  set edit:completion:arg-completer[rg] = (bash-completer:new "rg" &bash_function="_rg rg")
  set edit:completion:arg-completer[fd] = (bash-completer:new "fd" &bash_function="_fd fd")
  set edit:completion:arg-completer[journalctl] = (bash-completer:new "journalctl" &bash_function="_journalctl journalctl")
  set edit:completion:arg-completer[systemctl] = (bash-completer:new "systemctl" &bash_function="_systemctl systemctl")
  set edit:completion:arg-completer[iptables] = (bash-completer:new "iptables" &bash_function="_iptables iptables")
  set edit:completion:arg-completer[tcpdump] = (bash-completer:new "tcpdump" &bash_function="_tcpdump tcpdump")
}
