# Hook to print exit code, time spent (dirty but works fine)
#
# » fail 3
# « exit: 3
# » sleep 2 && fail 3
# « exit: 3, took 2.01s from 11:59:44 to 11:59:46
# » sleep 2
# « took 2.00s from 11:59:48 to 11:59:50
# » fail 1 | fail 2 | fail 3
# « exit: 1|2|3
function _save_start --on-event fish_preexec
  set -l pid $fish_pid
  eval "set -gx cmd_$pid_start (date '+%H:%M:%S')"
end # share history
function _save_end --on-event fish_postexec

  set -l last_pipestatus $pipestatus
  set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

  set -l status_color (set_color --italics red)
  set -l prompt_status (__fish_print_pipestatus "" "" "|" "$status_color" "$statusb_color" $last_pipestatus)

  set -l msg ""

  if [ "$prompt_status" != "" ]
    set msg (echo -n "exit:" $prompt_status )
  end

  set -l time_msg ""

  if test $CMD_DURATION
      set -l duration $CMD_DURATION
      if [ $duration -gt 2000 ]
        set -l formated_duration (echo "$CMD_DURATION 1000" | awk '{printf "%.2fs", $1 / $2}')
        set time_msg (eval "echo (set_color --italics red)took $formated_duration from $cmd_$pid_start to (date '+%H:%M:%S')")
        if test $msg != ""
          set time_msg (set_color --italics red)", ""$time_msg"
        end
        set msg "$msg""$time_msg"
      end

      # Show duration of the last command in seconds
      # set exclude_cmd "zsh|bash|man|ssh|v|t|f"
      # if test $CMD_DURATION -gt 10000
      #     and echo $history[1] | grep -vqE "^($exclude_cmd).*"
      #     # command -v noti 1>/dev/null 2>/dev/null && noti -m "$history[1]"
      # end
  end

  if test "$msg" != ""
    echo -s (set_color --italics red)"« $msg"
  end

end

# # Defined in /usr/local/share/fish/functions/fish_prompt.fish @ line 4
function fish_prompt
  if set -q SSH_TTY
    prompt_login
    echo -n " "
  end
  echo "» "
end
