function _pueue_add
  set -l command (commandline -b)
  commandline -r ""
  echo

  if echo $command | string match -q "https://*"
    set command (string join ' ' "aria2c" "'$command'")
  end

  pueue add -g commandline -- "$command"
  commandline -f force-repaint
end

function execute_bash
  set -l command (commandline -b | string split0)
  echo
  printf "$command" | bash
  # commandline -C 1000000000
  # if command -sq tput
  #     echo -n (tput el; or tput ce)
  # end
  # commandline ""
  emit fish_cancel
  commandline -f repaint
end

function clear_screen
  clear
  set -q TMUX && tmux clear-history
  commandline -f force-repaint
end

function fish_user_key_bindings
    fish_vi_key_bindings
    fzf_key_bindings

    bind \cr fzf-history
    bind -M insert \cr fzf-history

    for mode in insert default visual
        bind -M $mode \cx fish_clipboard_copy
        bind -M $mode \cp _pueue_add
        bind -M $mode \cw _watch_command
        # bind -M $mode \cb execute_bash
        bind -M $mode \cf forward-char
        bind -M $mode \ca complete
        bind -M $mode \cq exit
        bind -M $mode \ce clear_screen
        bind -M $mode --erase --preset \cd # disable closing terminal
    end

    bind --preset -M insert \cv fish_clipboard_paste_trim
    bind --preset -M visual \cv fish_clipboard_paste_trim
    bind --preset -M default \cv fish_clipboard_paste_trim

end

# Workaround for https://github.com/fish-shell/fish-shell/issues/7927
function fish_clipboard_paste_trim
  pbpaste | sed 's/\t/    /g' | perl -pe 'chomp if eof' | pbcopy
  fish_clipboard_paste
end

