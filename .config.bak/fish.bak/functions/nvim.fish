# replace https://github.com/bogado/file-line
# converts "nvim main.go:3" to "nvim main.go +3"
function nvim
  set -l nargv
  for arg in $argv
    if string match -q -- "*:*" $arg
      set -l splitted (string split ":" $arg)
      set -a nargv "$splitted[1]"
      set -a nargv "+$splitted[2]"
    else
      set -a nargv "$arg"
    end
  end
  command nvim $nargv
end
