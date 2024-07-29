function _pueue_add
  set -l command (commandline -b)
  commandline -r ""
  echo

  # TODO: FIX
  # if echo $command | string match -q "^https://*"
  #   set command (string join ' ' "aria2c" "'$command'")
  # end
  #
  # if echo $command | string match -q "^https://www.youtube.com/*"
  #   set command (string join ' ' "youtube-dl" "'$command'")
  # end

  echo $command

  pueue add -- "$command"
  commandline -f force-repaint
end

