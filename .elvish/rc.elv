use readline-binding
# use github.com/zzamboni/elvish-modules/alias
edit:abbr['k '] = 'kubectl '

# https://github.com/elves/elvish/issues/1053#issuecomment-859223554
# Filter the command history through the fzf program. This is normally bound
# to Ctrl-R.
fn history []{
  var new-cmd = (
    edit:command-history &dedup &newest-first &cmd-only |
    to-terminated "\x00" |
    try {
      fzf --no-multi --no-sort --read0 --layout=reverse --info=hidden --exact ^
        --query=$edit:current-command
    } except {
      # If the user presses [Escape] to cancel the fzf operation it will exit
      # with a non-zero status. Ignore that we ran this function in that case.
      return
    }
  )
  edit:current-command = $new-cmd
}

edit:insert:binding[Ctrl-R] = []{ history >/dev/tty 2>&1 }


use math
