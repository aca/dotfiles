function ln -d 'ln [target] [file]'
  if type -q gln
    command gln -svir $argv
  else
    command ln -svir $argv
  end
end