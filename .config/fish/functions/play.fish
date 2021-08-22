function play
    cd ~/src/play
    [ (count $argv) -eq 0 ] && return

    set d (date +%Y-%m-%d_$argv)
    mkdir $d
    cd $d
    touch README
end
