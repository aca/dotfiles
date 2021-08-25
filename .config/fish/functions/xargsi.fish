function xargsi --wraps=xargs
  xargs -I{} $argv
end
