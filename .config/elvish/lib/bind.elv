# Bindings...
# pprint $edit:insert:binding

use math

# https://github.com/elves/elvish/issues/1053#issuecomment-859223554
fn fzf_history {||
  if ( not (has-external "fzf") ) {
    edit:history:start
    return
  }
  use str
  var new-cmd = (
    edit:command-history &dedup &newest-first &cmd-only |
    to-terminated "\x00" |
    try {
      # requires latest fzy for `-0` options
      str:trim-space (fzy -0 --lines (math:max (- (tput lines) 6) 10) --query=$edit:current-command | slurp)
      # str:trim-space (fzf --no-multi --height=30% --no-sort --read0 --info=hidden --exact --query=$edit:current-command | slurp)
    } except {
      edit:redraw &full=$true
      return
    }
  )
  edit:redraw &full=$true
  set edit:current-command = $new-cmd
}
set edit:insert:binding[Ctrl-R] = {|| fzf_history >/dev/tty 2>&1 }

fn copy_current_command {||
  echo $edit:current-command | pbcopy
}
set edit:insert:binding[Ctrl-X] = {|| copy_current_command >/dev/tty 2>&1 }

fn paste_command {||
  set edit:current-command = (echo $edit:current-command(pbpaste))
}
set edit:insert:binding[Ctrl-V] = {|| paste_command >/dev/tty 2>&1 }

# https://elv.sh/ref/edit.html#keybindings
set edit:insert:binding[Ctrl-E] = { edit:clear > /dev/tty; edit:redraw &full=$true; tmux clear-history }
set edit:after-command = [
  {|m| 
    if (> $m[duration] 1) {
      echo (styled (printf "« %q took %s seconds\n" $m[src][code] $m[duration]) '#ff0000')
    }
  }
]

fn watch_command { ||
  set edit:current-command = ( printf "watch --interval 2 --differences=permanent --exec elvish -c %q" $edit:current-command )
}
set edit:insert:binding[Ctrl-W] = {|| watch_command }

