# Bindings...
# pprint $edit:insert:binding

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
      use math
      # requires latest fzy for `-0` options
      # tput lines doesn't work
      # var height = (math:max (- (tput lines) (term.pos.row)) 6)
      # str:trim-space (fzy -0 --lines $height --query=$edit:current-command | slurp)
      str:trim-space (fzf --no-multi --height=65% --min-height 4 --no-sort --read0 --info=hidden --exact --query=$edit:current-command | slurp)
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
set edit:insert:binding[Ctrl-E] = { edit:clear > /dev/tty; edit:redraw &full=$true; }
set edit:after-command = [
  {|m| 
    if (> $m[duration] 1) {
      echo (styled (printf "« %q took %s seconds\n" $m[src][code] $m[duration]) '#ff0000')
    }
  }
]

fn watch_command { ||
  if (eq (str:trim-space $edit:current-command) "") {
    return
  } 

  set edit:current-command = ( printf "watch --interval 2 --differences=permanent --exec elvish -c %q" $edit:current-command )
}
set edit:insert:binding[Ctrl-W] = {|| watch_command }

# It doesn't work..
# set edit:insert:binding[Ctrl-G] = {|| cd (src.dir >/dev/tty) }




fn fzf_cd {||
  try {
    cd (fd --hidden --type d --max-depth 6 --no-ignore | fzf)
    edit:redraw &full=$true
  } except {
    edit:redraw &full=$true
    return
  }
}
set edit:insert:binding[Alt-c] = {|| 
  fzf_cd > /dev/tty 2>&1
}
