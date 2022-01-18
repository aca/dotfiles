# Hook to print exit code, time spent (dirty but works fine)
#
# » fail 3
# « exit: 3
#
# » sleep 2 && fail 3
# « exit: 3, took 2.01s from 11:59:44 to 11:59:46
#
# » sleep 2
# « took 2.00s from 11:59:48 to 11:59:50
#
# » fail 1 | fail 2 | fail 3
# « exit: 1|2|3
#
function _save_start --on-event fish_preexec
  set -l pid $fish_pid
  eval "set -gx cmd_$pid_start (date '+%H:%M:%S')"
end

function _save_end --on-event fish_postexec
  set -l last_pipestatus $pipestatus
  set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

  set -l status_color (set_color --italics red)
  set -l prompt_status (__fish_print_pipestatus "" "" "|" "$status_color" "$status_color" $last_pipestatus)

  if [ "$prompt_status" != "" ]
    echo (set_color --italics red)"« exit:" $prompt_status
  end

  if test $CMD_DURATION
      set -l duration $CMD_DURATION
      if [ $duration -gt 1000 ]
        set -l formated_duration (echo "$CMD_DURATION 1000" | awk '{printf "%.2fs", $1 / $2}')
        echo (set_color --italics red)« took: $formated_duration / done: (date '+%Y-%m-%d %H:%M:%S')
        # set time_msg (eval "echo (set_color --italics red)took: $formated_duration / done: (date '+%Y-%m-%d %H:%M:%S')")
        # if test $msg != ""
        #   set time_msg (set_color --italics red)", ""$time_msg"
        # end
        # set msg "$msg""$time_msg"
      end
  end

  # if test "$msg" != ""
  #   echo -s (set_color red)"« $msg"
  # end
end

# # Defined in /usr/local/share/fish/functions/fish_prompt.fish @ line 4
function fish_prompt
  if set -q SSH_TTY
    prompt_login
    echo -n ' '
  end
  set_color '7c7c7c'; echo -n 'F|'$(date "+%H:%M"); set_color red;echo -n " | ";  set_color normal

  end
