function pactl.pci
  command -q pactl || return 1
  set SINK_NEXT (pactl list sinks short | grep 'alsa_output.pci-0000_01_00.1.hdmi-stereo' | awk '{print $1}')
  for i in (pactl list sink-inputs short | awk '{print $1}')
    pactl move-sink-input $i $SINK_NEXT
  end
  pactl set-default-sink $SINK_NEXT
end
