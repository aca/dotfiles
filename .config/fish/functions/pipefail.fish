function pipefail -d "returns true(1) if pipe fails"
  if string match -v 0 -- $pipestatus
    return 0
  else
    return 1
  end
end
