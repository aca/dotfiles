function _watch_command
  set -l command (commandline -b)
  if [ "$command" = "" ]
          return
  end

  watch --beep --interval 5 --differences=permanent --exec fish -c "$command | _rm_color"

  # commandline -r ""; echo; commandline -f force-repaint
  # commandline -r ""; echo; commandline -f force-repaint
  commandline -b -r ""
end

