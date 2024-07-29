function yabai.circular.monitor
  # select next/prev space inside current monitor
  # yabai.circular prev/next [move]
  set monitor_index (yabai -m query --displays --display| jq -r '.index')

  if contains "next" $argv;
    set -g target_monitor_index (yabai -m query --displays | jq -r ".[].index" | string join '.' | jq ".map(select(. > $monitor_index )) | .[0]")
    # [ $target_monitor_index = "null" ] && set -g target_monitor_index (yabai -m query --displays --display | jq -r ".spaces[0]")
  else if contains "prev" $argv;
    set -g target_monitor_index (yabai -m query --displays | jq -r ".[].index | map(select(. < $monitor_index )) | .[-1]")
    # [ $target_monitor_index = "null" ] && set -g target_monitor_index (yabai -m query --displays --display | jq -r ".spaces[-1]")
  end

  if contains "move" $argv
    yabai -m display --focus $target_monitor_index
  else
    yabai -m display --focus $target_monitor_index
  end
end
