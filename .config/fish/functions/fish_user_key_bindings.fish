function add_to_pueue
  set -l command (commandline -b)
  commandline -r ""
  echo 
  echo $command
  pueue add -- $command
  commandline -f force-repaint
end

function execute_bash
  set -l command (commandline -b | string split0)
  echo
  printf "$command" | bash
  commandline -C 1000000000
  if command -sq tput
      echo -n (tput el; or tput ce)
  end
  commandline ""
  emit fish_cancel
  commandline -f repaint
end


function command_to_watch
  set -l command (commandline -b)
  commandline -r ""
  echo 
  # watch -b -n 3 -d=permanent -x fish -c "$command""|strip-ansi"
  watch -b -n 2 -d=permanent -x fish -c "$command"
  commandline -f force-repaint
end

function clear_screen
  clear 
  set -q TMUX && tmux clear-history 1>/dev/null 2>/dev/null
  commandline -f force-repaint
end

function fish_user_key_bindings
    fish_vi_key_bindings
    fzf_key_bindings
    for mode in insert default visual
    # for mode in insert visual
        bind -M $mode \cX fish_clipboard_copy
        bind -M $mode \cp add_to_pueue
        bind -M $mode \cw command_to_watch
        # bind -M $mode \cb 'pbpaste | zsh'
        bind -M $mode \cb execute_bash
        bind -M $mode \cf forward-char
        # bind -M $mode \cd fzf-cd-widget
        bind -M $mode \ca complete
        bind -M $mode \cq exit
        bind -M $mode \ce clear_screen
        bind -M $mode \cn "commandline -i (fzf-complete-from-tmux.sh) 2>/dev/null"
        bind -M $mode --erase --preset \cd # disable closing terminal
    end
    # bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
end

