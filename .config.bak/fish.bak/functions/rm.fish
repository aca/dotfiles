function rm -d 'trash-put'
    if command -q trash-put 
        command trash-put -v $argv
    else
        command rm -vr $argv
    end
end