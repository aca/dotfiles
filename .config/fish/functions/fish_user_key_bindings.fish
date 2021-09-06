function _pueue_add
  set -l command (commandline -b)
  commandline -r ""
  echo

  if echo $command | string match -q "https://*"
    set command (string join ' ' "aria2c" "'$command'")
  end

  pueue add -- "$command"
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


function _watch_command
  set -l command (commandline -b)
  if [ "$command" = "" ]
          return
  end

  if command -q viddy
    viddy -n3 --shell fish -- $command
  else
    watch --beep --interval 2 --differences=permanent --exec fish -c "$command | perl -pe 's/\x1b\[[0-9;]*[mG]//g'"
  end

  commandline -r ""
  echo
  commandline -f force-repaint
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
    # for mode in insert visual
        bind -M $mode \cx fish_clipboard_copy
        bind -M $mode \cp _pueue_add
        bind -M $mode \cw _watch_command
        # bind -M $mode \cb 'pbpaste | zsh'
        bind -M $mode \cb execute_bash
        bind -M $mode \cf forward-char
        # bind -M $mode \cd fzf-cd-widget
        bind -M $mode \ca complete
        bind -M $mode \cq exit
        bind -M $mode \ce clear_screen
        # bind -M $mode \cc kill-whole-line # clear commandline (c-u by default)
        # bind -M $mode \cn "commandline -i (fzf-complete-from-tmux.sh) 2>/dev/null"

        # bind -M $mode \cn fzf-cd-widget
        bind -M $mode --erase --preset \cd # disable closing terminal


        # bind -M insert \cm fzf-cd-widget
    end

    # bind --preset -M insert \cc echo\ -n\ \(string\ replace\ \\e\\\[3J\ \"\"\)\;\ commandline\ -f\ repaint
    # bind --preset \cl echo\ -n\ \(string\ replace\ \\e\\\[3J\ \"\"\)\;\ commandline\ -f\ repaint
    # bind --preset -M visual \cl echo\ -n\ \(string\ replace\ \\e\\\[3J\ \"\"\)\;\ commandline\ -f\ repaint

    # bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"

    bind --preset -M insert \cv fish_clipboard_paste_trim
    bind --preset -M visual \cv fish_clipboard_paste_trim
    bind --preset -M default \cv fish_clipboard_paste_trim

end

# Workaround for https://github.com/fish-shell/fish-shell/issues/7927
function fish_clipboard_paste_trim
  pbpaste | sed 's/\t/    /g' | perl -pe 'chomp if eof' | pbcopy
  fish_clipboard_paste
end

