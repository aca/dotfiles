function fzy_select_history
  if test (count $argv) = 0
    set fzy_flags
  else
    set fzy_flags -q "$argv"
  end
  # builtin history| command fzy -l 30 $fzy_flags|read -l foo
  # builtin history | command fzf-tmux |read -l foo
  builtin history -z --show-time="%y-%m-%d %H:%M | " | string split0 | eval command fzf -q '(commandline)' | string sub -s 18 | read -l foo
  # builtin history -z --show-time="%y-%m-%d %H:%M |%n"  | eval command fzf-tmux --read0 --print0 -q '(commandline)'| read -l foo
  commandline -f repaint
  commandline $foo
end
