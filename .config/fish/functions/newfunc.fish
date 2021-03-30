function newfunc

  if not set -q argv[1]
    echo "require function name `newfunc fname`"
    return 1
  end

  cd ~/src/configs/home/.config/fish/functions

  echo $argv[1]".fish"

  if not [ -f $argv[1]".fish" ]
    echo "created"

    echo -n "function $argv[1] -d ''
end" > $argv[1]".fish"
  end
  
 v $argv[1]".fish"

  setup.install 
end
