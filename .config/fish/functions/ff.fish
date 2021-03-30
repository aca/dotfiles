function ff
  fd --type f --hidden | fzf -m --ansi --preview  "bat --color=always --style=header,grid --line-range :250 {}" | cbi
  cbo
end


