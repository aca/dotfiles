# Key bindings
#
# print current binding
#   pprint $edit:insert:binding

use math
use str

# https://github.com/elves/elvish/issues/1053#issuecomment-859223554
fn fzf_history {||
  if ( not (has-external "fzf") ) {
    edit:history:start
    return
  }
  var new-cmd = (
    edit:command-history &dedup &newest-first &cmd-only |
    to-terminated "\x00" |
    try {
      str:trim-space (fzf --no-multi --height=75% --min-height 10 --no-sort --read0 --info=hidden --exact --query=$edit:current-command | slurp)
    } catch {
      edit:redraw &full=$true
      return
    }
  )
  edit:redraw &full=$true
  set edit:current-command = $new-cmd
}
set edit:insert:binding[Ctrl-R] = {|| fzf_history >/dev/tty 2>&1 }

fn fzf_file { ||
  use str
  var last = (str:split ' ' $edit:current-command | put [ (all) ][-1])

  if (not-eq $last '') {
    var s = (str:trim-suffix $edit:current-command $last)
    var s2 = (str:join ' ' [$s (printf "%q" (fzf --height 75% --query $last --min-height 10 --info=hidden --no-sort </dev/tty) )])
    edit:replace-input $s2
  } else {
    edit:replace-input (str:join ' ' [$edit:current-command (printf "%q" (fzf --height 75% --min-height 10 --info=hidden --no-sort </dev/tty) )])
  }
}

set edit:insert:binding[Ctrl-T] = {|| 
  try {
    fzf_file >/dev/tty 2>&1
    edit:redraw &full=$true
  } catch {
    edit:redraw &full=$true
  }
}

fn copy_current_command {||
  # ~/.bin/yank
  echo $edit:current-command | yank
}
set edit:insert:binding[Ctrl-X] = {|| copy_current_command >/dev/tty 2>&1 }

fn paste_command {||
  edit:insert-at-dot (pbpaste | slurp)
}
set edit:insert:binding[Ctrl-V] = {|| paste_command >/dev/tty 2>&1 }
set edit:command:binding[p] = {|| paste_command >/dev/tty 2>&1 }

set edit:insert:binding[Alt-w] = { set edit:current-command = ( printf "watch --interval 2 --differences=permanent --exec elvish -c %q" $edit:current-command ) }

# It doesn't work..
# set edit:insert:binding[Ctrl-G] = {|| cd (src.dir >/dev/tty) }

fn fzf_cd {||
  try {
    cd (fd --hidden --type d  --max-depth 6 --no-ignore -0 | fzf --read0 --height=30% --min-height 10)
    edit:redraw &full=$true
  } catch {
    edit:redraw &full=$true
    return
  }
}
set edit:insert:binding[Alt-c] = {|| 
  fzf_cd > /dev/tty 2>&1
}

fn fzf_cd_src {||
  try {
    cd (src.dir)
    edit:redraw &full=$true
  } catch e {
    edit:redraw &full=$true
    return
  }
}
set edit:insert:binding[Ctrl-S] = {|| 
  fzf_cd_src > /dev/tty 2>&1
}

set edit:insert:binding[Ctrl-D] = { edit:location:start }
set edit:insert:binding[Alt-e] = {|| edit:replace-input (print $edit:current-command | e:vipe --suffix elv) > /dev/tty 2>/dev/null }
set edit:insert:binding[Ctrl-W] = {||
  cd ~/src/scratch/(fd --base-directory ~/src/scratch --strip-cwd-prefix --hidden --type d --max-depth 1 --no-ignore -0 | fzf --read0) >/dev/tty 2>&1
  edit:redraw &full=$true
}


# queue command to pueue
# I don't like pueue interface, maybe just use tmux
# elvish -> bash -> elvish
# echo 1\necho 2 -> elvish -c $'echo 1\necho 2'
set edit:insert:binding[Ctrl-P] = {|| 
  if (not-eq $edit:current-command "") {
    edit:replace-input ( printf "pueue add -- elvish -c %q" (put $edit:current-command | to-lines | sh -c 'x=$(cat -); printf "%q" "$x"'))
    edit:smart-enter
  }
}

# execute command in bash
set edit:insert:binding[Ctrl-B] = {|| 
  if (not-eq $edit:current-command "") {
    edit:replace-input ( printf "echo %q | bash" (put $edit:current-command))
    edit:smart-enter
  }
}

set edit:insert:binding[Ctrl-Q] = { exit }
set edit:insert:binding[Ctrl-E] = { nop ?(tmux clear-history 2>/dev/null); clear >/dev/tty; edit:redraw &full=$true }
# set edit:insert:binding[Ctrl-I] = { edit:lastcmd:start }

# navigate history like vim
# set edit:insert:binding[Ctrl-H] = { edit:history:start }
# set edit:history:binding['Ctrl-N'] = { edit:history:up }
# set edit:history:binding['Ctrl-P'] = { edit:history:down }

# navigate
set edit:insert:binding[Ctrl-N] = {|| cd (e:vifm --choose-dir -) </dev/tty >/dev/tty 2>&1 }

# fish like ctrl-a 
set edit:insert:binding[Ctrl-A] = { edit:completion:smart-start }
