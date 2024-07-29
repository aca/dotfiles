# vol 100
function vol
  switch (uname)
  case Linux
    # amixer set Master {$argv[1]}%
    command -v -q pactl || return 1
    for id in (pactl list sinks short | grep -i running | awk '{ print $1 }')
      pactl set-sink-volume $id {$argv[1]}%
    end
  case Darwin
    set --local val (math --scale 0 {$argv[1]}/10)
    sudo osascript -e "set Volume $val"
  end
end

