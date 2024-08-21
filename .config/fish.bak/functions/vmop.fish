function vmop -d 'mop'
  cat ~/.moprc | jq . | sponge (realpath ~/.moprc)
  nvim -c 'set ft=json' ~/.moprc 
end