# https://github.com/fish-shell/fish-shell/issues/159#issuecomment-476457595
function cat1
  cat $argv | string split 0
end
