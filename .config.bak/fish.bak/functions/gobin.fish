# gobin hello ~ == $GOPATH/bin/hello ~
function gobin
  [ (count $argv) -eq 1 ] && $GOPATH/bin/$argv[1] && return
  [ (count $argv) -ge 1 ] && "$GOPATH/bin/$argv[1]" $argv[2..-1] && return
end
