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

