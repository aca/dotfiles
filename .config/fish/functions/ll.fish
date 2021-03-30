function ll
  set -gx EXA_ICON_SPACING 1
  exa -la --icons --time-style long-iso --group -I '$EXA_IGNORE' -s=name $argv
end
