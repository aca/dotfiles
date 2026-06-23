function _print_cmd_duration
    if test $CMD_DURATION
        set -l duration $CMD_DURATION
        if [ $duration -gt 2000 ]
          echo "$CMD_DURATION 1000" | awk '{printf "%.3fs ", $1 / $2}'
        end
        # Show duration of the last command in seconds

          # set exclude_cmd "zsh|bash|man|ssh|v|t|f"
          # if test $CMD_DURATION -gt 10000
          #     and echo $history[1] | grep -vqE "^($exclude_cmd).*"
          #     # command -v noti 1>/dev/null 2>/dev/null && noti -m "$history[1]"
          # end
    end
end
