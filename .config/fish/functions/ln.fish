function ln -d ''
  if command -v gln
    command gln -svir $argv
  else
    command ln -svir $argv
  end
end