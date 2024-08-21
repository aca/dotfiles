function ffp -d 'ps -ef | fzf -m --ansi -e --nth 9 --header-lines 1'
  ps -ef | fzf -m --ansi -e --nth 9 --header-lines 1
end