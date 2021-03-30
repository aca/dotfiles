function play
  cd ~/src/play
  if test 0 -ne (count $argv) 
    set d (date +%Y-%m-%d_$argv)
    mkdir $d
    cd $d
    test -d .git || git init 
  end
end
