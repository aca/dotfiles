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
      str:trim-space (fzf --no-multi --height=30% --min-height 10 --no-sort --read0 --info=hidden --exact --query=$edit:current-command | slurp)
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

set edit:insert:binding[Alt-w] = { set edit:current-command = ( printf "watch --interval 2 --differences=permanent --exec elvish -c %q" $edit:current-command ) }

# It doesn't work..
# set edit:insert:binding[Ctrl-G] = {|| cd (src.dir >/dev/tty) }

fn fzf_cd {||
  try {
    cd (fd --hidden --type d  --max-depth 6 --no-ignore -0 | fzf --read0 --height=30% --min-height 10)
    edit:redraw &full=$true
  } except {
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
  } except e {
    edit:redraw &full=$true
    return
  }
}
set edit:insert:binding[Ctrl-S] = {|| 
  fzf_cd_src > /dev/tty 2>&1
}

set edit:insert:binding[Ctrl-D] = { edit:location:start }
set edit:insert:binding[Alt-e] = {|| edit:replace-input (print $edit:current-command | e:vipe --suffix elv) > /dev/tty 2>/dev/null }

set edit:insert:binding[Ctrl-N] = {||
  cd (e:vifm --choose-dir -) </dev/tty >/dev/tty 2>&1
}

set edit:insert:binding[Ctrl-W] = {||
  cd ~/src/scratch/(fd --base-directory ~/src/scratch --strip-cwd-prefix --hidden --type d --max-depth 1 --no-ignore -0 | fzf --read0) >/dev/tty 2>&1
  edit:redraw &full=$true
}


set edit:insert:binding[Ctrl-B] = {|| 
  # NOTE: elvish -> bash -> elvish
  # quoting, escaping is sick
  edit:replace-input ( printf "pueue add -- elvish -c %q" (echo $edit:current-command | sh -c 'x=$(cat -); printf "%q" "$x"'))
}

set edit:insert:binding[Ctrl-Q] = { exit }
set edit:insert:binding[Ctrl-P] = { edit:history:start }
set edit:history:binding[Ctrl-P] = { edit:history:up }
set edit:history:binding[Ctrl-N] = { edit:history:down }
