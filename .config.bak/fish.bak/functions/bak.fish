function bak -d 'add .bak to file'
  cp -rp $argv[1] $argv[1].bak || sudo cp -rp $argv[1] $argv[1].bak
end
