function ffo -d 'fd --type f --hidden | fzf --ansi -m | xargs -I{} o {}'
  fd --type f --hidden | fzf --ansi -m | xargs -I{} o {}
end