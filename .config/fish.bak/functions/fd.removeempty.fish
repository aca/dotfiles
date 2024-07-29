function fd.removeempty -d 'remove empty files'
  for i in (seq 10)
    fd --type empty -x rm -v -r
  end
end