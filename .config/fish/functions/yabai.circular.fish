function yabai.circular
  # select next/prev space inside current monitor
  # yabai.circular prev/next [move]
  set space_index (yabai -m query --spaces --space | jq -r '.index')

  if contains "next" $argv;
    set -g target_space_index (yabai -m query --displays --display | jq -r ".spaces | map(select(. > $space_index )) | .[0]")
    [ $target_space_index = "null" ] && set -g target_space_index (yabai -m query --displays --display | jq -r ".spaces[0]")
  else if contains "prev" $argv;
    set -g target_space_index (yabai -m query --displays --display | jq -r ".spaces | map(select(. < $space_index )) | .[-1]")
    [ $target_space_index = "null" ] && set -g target_space_index (yabai -m query --displays --display | jq -r ".spaces[-1]")
  end

  echo $target_space_index

  if contains "move" $argv
    echo "yabai -m window --space $target_space_index"
    yabai -m window --space $target_space_index
  else
    echo "yabai -m space --focus $target_space_index"
    yabai -m space --focus $target_space_index
  end
end
