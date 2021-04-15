function fish_right_prompt
#     set -g __last_status $status
#
#     set_color --italics
#     set_color --dim
#     prompt_pwd
#
#     if test $CMD_DURATION
#         set -l duration
#         # Show duration of the last command in seconds
#         echo "$CMD_DURATION 1000" | awk '{printf " %.3fs ", $1 / $2}'
#
#         # set exclude_cmd "zsh|bash|man|ssh|v|t|f"
#         # if test $CMD_DURATION -gt 10000
#         #     and echo $history[1] | grep -vqE "^($exclude_cmd).*"
#         #     # command -v noti 1>/dev/null 2>/dev/null && noti -m "$history[1]"
#         # end
#     end
#
#
#     if [ "$__last_status" -ne 0 ]
#         set_color normal
#         set_color --bold
#         set_color --italics
#         set_color red
#         echo -n " $__last_status "
#         set_color normal
#     end
#
#
end
