function ln -d 'ln -svir [target] [file]'
  if type -q gln
    command gln -svir $argv
  else
    command ln -svir $argv
  end
end