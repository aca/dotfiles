function restore -d 'reverse of bak.fish'
    set -l new (echo $argv[1] | string split -r -m1 .bak)
    cp $argv[1] $new[1] || sudo cp $argv[1] $new[1]
end
