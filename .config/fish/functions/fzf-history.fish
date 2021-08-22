function fzf-history -d "Show command history"
  test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
  begin
    # set -gx FZF_CTRL_R_OPTS "--preview 'echo {}' --preview-window down:5:hidden:wrap --bind '?:toggle-preview'"
    set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT $FZF_DEFAULT_OPTS --tiebreak=index --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS +m"

    set -l FISH_MAJOR (echo $version | cut -f1 -d.)
    set -l FISH_MINOR (echo $version | cut -f2 -d.)

    # history's -z flag is needed for multi-line support.
    # history's -z flag was added in fish 2.4.0, so don't use it for versions
    # before 2.4.0.
    if [ "$FISH_MAJOR" -gt 2 -o \( "$FISH_MAJOR" -eq 2 -a "$FISH_MINOR" -ge 4 \) ];
      history -z --show-time="%y-%m-%d %H:%M |%n" | eval (__fzfcmd) --reverse --nth 3..  --read0 --print0 -q '(commandline)' | tail -n +2 | read -lz result
      and commandline -- $result
    else
      history | eval (__fzfcmd) -q '(commandline)' | read -l result
      and commandline -- $result
    end
  end
  commandline -f repaint
end
