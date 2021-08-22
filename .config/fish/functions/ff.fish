function ff
  fd --type f --hidden | fzf -m --ansi --preview  "bat --color=always --style=header,grid --line-range :250 {}" | xargs realpath | pbcopy
  pbpaste
end


