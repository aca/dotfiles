function ffv
  set files (fd --type f -L --hidden | fzf -m --ansi --preview  "bat --line-range :300 {}")
  [ (count $files) != 0 ] && v -O $files
end
