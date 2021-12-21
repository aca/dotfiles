# vi mode binding
# https://github.com/elves/elvish/issues/971
set edit:insert:binding[Ctrl-'['] = $edit:command:start~

# use readline-binding

# env init
if (not (has-env _ENV)) {
  set-env _ENV ""
  set-env _OS (uname)
}

fn ll {|@a|
  if (eq $E:_OS Darwin) {
    ls -alt -G $@a
  } else {
    ls -alt --color=auto $@a
  }
}

fn v {|@a|
    nvim $@a
}

# use function ll
# set edit:small-word-abbr['ll'] = 'ls -ltr'
set edit:small-word-abbr['k'] = 'kubectl'
set edit:small-word-abbr['v'] = 'nvim'
set edit:small-word-abbr['os'] = 'openstack '
set edit:small-word-abbr['ta'] = 'tmux attach -t '
set edit:small-word-abbr['elv'] = 'elvish'

# var _whoami = (constantly (styled (whoami)@(hostname) inverse))

# set edit:prompt = { put 'λ ' }
# set edit:rprompt = { }
# set edit:rprompt = (constantly (styled (whoami)@(hostname) inverse))
# set edit:rprompt = { tilde-abbr $pwd }


# set edit:abbr['ci '] = 'pbcopy'
# set edit:abbr['co '] = 'pbpaste'
# set edit:abbr['copyq.history '] = 'copyq read (seq 0 100) | nvim - '
# set edit:abbr['cp '] = 'command cp -vrp '
# set edit:abbr['v- '] = 'nvim - '
# set edit:abbr['dc '] = 'cd '
# set edit:abbr['sp- '] = 'shuf | mpv --playlists=-'
# set edit:abbr['cp ']  = 'cp -vrp '
#
# set edit:abbr['ll']  = 'ls -al'


# .rw-r--r--   96 rok staff  6 Dec 13:20   _clear.fish
# .rw-r--r--  543 rok staff  6 Dec 13:20   _print_cmd_duration.fish
# .rw-r--r--  436 rok staff  6 Dec 13:20   _pueue_add.fish
# .rw-r--r--   84 rok staff  6 Dec 13:20   _rm_color.fish
# .rw-r--r--   85 rok staff  6 Dec 13:20   _save_history.fish
# .rw-r--r--  342 rok staff  6 Dec 13:20   _watch_command.fish
# .rw-r--r-- 1.2k rok staff  6 Dec 13:20   agnoster.fish
# .rw-r--r--  178 rok staff  6 Dec 13:20   ansible.all.fish
# .rwxr-xr-x  162 rok staff  6 Dec 13:20   ansible.source.fish
# .rw-r--r--   80 rok staff  6 Dec 13:20   aria2c.noautorename.fish
# .rw-r--r--  401 rok staff  6 Dec 13:20   asdf.fish
# .rwxr-xr-x  205 rok staff  6 Dec 13:20   aws.fish
# .rw-r--r--  107 rok staff  6 Dec 13:20   bak.fish
# .rw-r--r--  124 rok staff  6 Dec 13:20   cat1.fish
# .rw-r--r--  235 rok staff  6 Dec 13:20   cdf.fish
# .rw-r--r--   61 rok staff  6 Dec 13:20   cert.cert.fish
# .rw-r--r--   54 rok staff  6 Dec 13:20   cert.key.fish
# .rw-r--r--   35 rok staff  6 Dec 13:20   cloc.fish
# .rw-r--r--   94 rok staff  6 Dec 13:20   config.linux.fish
# .rw-r--r--   66 rok staff  6 Dec 13:20   copyq.history.fish
# .rw-r--r--   45 rok staff  6 Dec 13:20   cp.fish
# .rw-r--r--  220 rok staff  6 Dec 13:20   cppath.fish
# .rw-r--r--  126 rok staff  6 Dec 13:20   cra.fish
# .rw-r--r--  120 rok staff  6 Dec 13:20   dbr.fish
# .rw-r--r--  118 rok staff  6 Dec 13:20   dbt.fish
# .rw-r--r--  147 rok staff  6 Dec 13:20   dbtp.fish
# .rw-r--r--   38 rok staff  6 Dec 13:20   dc.fish
# .rw-r--r--   61 rok staff  6 Dec 13:20   detach.fish
# .rw-r--r--   44 rok staff  6 Dec 13:20   df.h.fish
# .rw-r--r--  226 rok staff  6 Dec 13:20   diff.cmd.fish
# .rw-r--r--   33 rok staff  6 Dec 13:20   f.fish
# .rw-r--r--   68 rok staff  6 Dec 13:20   fd.fish
# .rw-r--r--  109 rok staff  6 Dec 13:20   fd.removeempty.fish
# .rw-r--r--   72 rok staff  6 Dec 13:20   fda.fish
# .rw-r--r--   67 rok staff  6 Dec 13:20   fdd.fish
# .rw-r--r--   66 rok staff  6 Dec 13:20   fdf.fish
# .rw-r--r--  166 rok staff  6 Dec 13:20   ff.fish
# .rw-r--r--   71 rok staff  6 Dec 13:20   ffc.fish
# .rw-r--r--  171 rok staff  6 Dec 13:20   ffh.fish
# .rw-r--r--  133 rok staff  6 Dec 13:20   ffo.fish
# .rw-r--r--  125 rok staff  6 Dec 13:20   ffp.fish
# .rw-r--r--  156 rok staff  6 Dec 13:20   ffv.fish
# .rw-r--r--   47 rok staff  6 Dec 13:20   field.fish
# .rw-r--r--   27 rok staff  6 Dec 13:20   fish_greeting.fish
# .rw-r--r--   30 rok staff  6 Dec 13:20   fish_mode_prompt.fish
# .rw-r--r--   82 rok staff  6 Dec 13:20   fish_right_prompt.fish
# .rw-r--r--  939 rok staff  6 Dec 13:20   fish_user_key_bindings.fish
# .rw-r--r-- 1.1k rok staff  6 Dec 13:20   fzf-history.fish
# lrwxr-xr-x   37 rok staff  6 Dec 13:20   fzf_key_bindings.fish -> ../../../.fzf/shell/key-bindings.fish
# .rw-r--r--  548 rok staff  6 Dec 13:20   fzy_select_history.fish
# .rw-r--r--   50 rok staff  6 Dec 13:20   gb.fish
# .rw-r--r--   67 rok staff  6 Dec 13:20   git.ff.fish
# .rw-r--r--  200 rok staff  6 Dec 13:20   gitcfg.fish
# .rw-r--r--  193 rok staff  6 Dec 13:20   gobin.fish
# .rw-r--r--  154 rok staff  6 Dec 13:20   gosrc.fish
# .rw-r--r--   78 rok staff  6 Dec 13:20   grt.fish
# .rw-r--r--   38 rok staff  6 Dec 13:20   grv.fish
# .rw-r--r--   50 rok staff  6 Dec 13:20   gs.fish
# .rw-r--r--   36 rok staff  6 Dec 13:20   hex.fish
# .rw-r--r--   54 rok staff  6 Dec 13:20   hm.fish
# .rw-r--r--   46 rok staff  6 Dec 13:20   icat.fish
# .rw-r--r--   20 rok staff  6 Dec 13:20   k.fish
# .rw-r--r--  194 rok staff  6 Dec 13:20   korean-chk.fish
# .rw-r--r--  785 rok staff  6 Dec 13:20   l.fish
# .rw-r--r--   29 rok staff  6 Dec 13:20   ll.fish
# .rw-r--r--  124 rok staff  6 Dec 13:20   ln.fish
# .rw-r--r--   57 rok staff  6 Dec 13:20   mkdir.fish
# .rw-r--r--   46 rok staff  6 Dec 13:20   mv.fish
# .rw-r--r--  356 rok staff  6 Dec 13:20   newfunc.fish
# .rw-r--r--  370 rok staff  6 Dec 13:20   nvim.fish
# .rw-r--r--   91 rok staff  6 Dec 13:20   os.clr.fish
# .rw-r--r--   58 rok staff  6 Dec 13:20   os.env.fish
# .rw-r--r--  509 rok staff  6 Dec 13:20   os.pj.fish
# .rw-r--r--   41 rok staff  6 Dec 13:20   p-.fish
# .rw-r--r--  272 rok staff  6 Dec 13:20   pactl.bluez.fish
# .rw-r--r--  235 rok staff  6 Dec 13:20   path.add.fish
# .rw-r--r--   45 rok staff  6 Dec 13:20   path.fish
# .rw-r--r--  153 rok staff  6 Dec 13:20   path.remove.fish
# .rw-r--r--   49 rok staff  6 Dec 13:20   pus.fish
# .rw-r--r--   44 rok staff  6 Dec 13:20   py.fish
# .rw-r--r--  156 rok staff  6 Dec 13:20   restore.fish
# .rw-r--r--  140 rok staff  6 Dec 13:20   rm.fish
# .rw-r--r--   51 rok staff  6 Dec 13:20   rmm.fish
# .rw-r--r--  114 rok staff  6 Dec 13:20   say.fish
# .rw-r--r--  107 rok staff  6 Dec 13:20   silent.fish
# .rw-r--r--   52 rok staff  6 Dec 13:20   socks5.fish
# .rw-r--r--  321 rok staff  6 Dec 13:20   src.fish
# .rw-r--r--  122 rok staff  6 Dec 13:20   sudo.fish
# .rw-r--r--   83 rok staff  6 Dec 13:20   svcu.fish
# .rw-r--r--  421 rok staff  6 Dec 13:20   swp.fish
# .rw-r--r--  117 rok staff  6 Dec 13:20   take.fish
# .rw-r--r--   80 rok staff  6 Dec 13:20   tmux.save.fish
# .rw-r--r--  116 rok staff  6 Dec 13:20   transmission-remote.fish
# .rw-r--r--  133 rok staff  6 Dec 13:20   tree.fish
# .rw-r--r--  139 rok staff  6 Dec 13:20   treee.fish
# .rw-r--r--   97 rok staff  6 Dec 13:20   tscr.fish
# .rw-r--r--  108 rok staff  6 Dec 13:20   valacritty.fish
# .rw-r--r--   45 rok staff  6 Dec 13:20   vd.fish
# .rw-r--r--  111 rok staff  6 Dec 13:20   vfish.fish
# .rw-r--r--   70 rok staff  6 Dec 13:20   vfunc.fish
# .rw-r--r--   45 rok staff  6 Dec 13:20   videavim.fish
# .rw-r--r--   45 rok staff  6 Dec 13:20   vj.fish
# .rw-r--r--   62 rok staff  6 Dec 13:20   vkitty.fish
# .rw-r--r--  111 rok staff  6 Dec 13:20   vmop.fish
# .rw-r--r--  371 rok staff  6 Dec 13:20   vol.fish
# .rw-r--r--   47 rok staff  6 Dec 13:20   vtmux.fish
# .rw-r--r--   85 rok staff  6 Dec 13:20   vvifm.fish
# .rw-r--r--   80 rok staff  6 Dec 13:20   vxdg.fish
# .rw-r--r--   52 rok staff  6 Dec 13:20   vy.fish
# .rw-r--r--  410 rok staff  6 Dec 13:20   x.fish
# .rw-r--r--   53 rok staff  6 Dec 13:20   xargsi.fish
# .rw-r--r-- 1.0k rok staff  6 Dec 13:20   yabai.circular.fish
# .rw-r--r--  939 rok staff  6 Dec 13:20   yabai.circular.monitor.fish
# .rw-r--r--  154 rok staff  6 Dec 13:20   youtube.fish
# .rw-r--r--  249 rok staff  6 Dec 13:20   zk.fish
# .rw-r--r--  307 rok staff 13 Dec 10:58   pactl.pci.fish
# .rw-r--r-- 1.6k rok staff 13 Dec 20:59   fish_prompt.fish

# # https://github.com/elves/elvish/issues/1053#issuecomment-859223554
# # Filter the command history through the fzf program. This is normally bound
# # to Ctrl-R.
# fn fzf_history {||
#
#   var new-cmd = (
#     edit:command-history &dedup &newest-first &cmd-only |
#     to-terminated "\x00" |
#     try {
#       fzf --no-multi --no-sort --read0 --layout=reverse --info=hidden --exact ^
#         --height 40% ^
#         --query=$edit:current-command
#     } except {
#       # If the user presses [Escape] to cancel the fzf operation it will exit
#       # with a non-zero status. Ignore that we ran this function in that case.
#       return
#     }
#   )
#   # set edit:navigation = $new-cmd
#   # edit:redraw &full=$true
# }

use str

fn fzf_history {||
  if ( not (has-external "fzf") ) {
    edit:history:start
    return
  }
  var new-cmd = (
    edit:command-history &dedup &newest-first &cmd-only |
    to-terminated "\x00" |
    try {
      str:trim-space (fzf --no-multi --height=30% --no-sort --read0 --info=hidden --exact --query=$edit:current-command | slurp)
    } except {
      edit:redraw &full=$true
      return
    }
  )
  edit:redraw &full=$true
  set edit:current-command = $new-cmd
}
set edit:insert:binding[Ctrl-R] = {|| fzf_history >/dev/tty 2>&1 }


# https://elv.sh/ref/edit.html#keybindings
# set edit:insert:binding[Ctrl-L] = { clear > /dev/tty; edit:redraw &full=$true; tmux clear-history }

use math

set edit:after-command = [
  {|m| 
    if (> $m[duration] 2) {
      echo '« took '$m[duration]' seconds' 
    }
  }
]
