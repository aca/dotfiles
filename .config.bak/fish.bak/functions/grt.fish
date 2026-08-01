function grt
  cd (git rev-parse --show-toplevel 2>/dev/null || echo ".")
end
