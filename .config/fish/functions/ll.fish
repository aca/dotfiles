function ll
  set -gx EXA_ICON_SPACING 1
  set -gx EXA_IGNORE "Icon?|javasharedresources|.DS_Store"
  
  # https://github.com/fenetikm/falcon/blob/master/exa/EXA_COLORS
  set -gx EXA_COLORS "uu=38;5;249:un=38;5;241:gu=38;5;245:gn=38;5;241:da=38;5;245:sn=38;5;7:sb=38;5;7:ur=38;5;3;1:uw=38;5;5;1:ux=38;5;1;1:ue=38;5;1;1:gr=38;5;249:gw=38;5;249:gx=38;5;249:tr=38;5;249:tw=38;5;249:tx=38;5;249:fi=38;5;248:di=38;5;253:ex=38;5;1:xa=38;5;12:*.png=38;5;4:*.jpg=38;5;4:*.gif=38;5;4"
  exa -la --icons --time-style long-iso --group -I '$EXA_IGNORE' -s=name $argv
end
