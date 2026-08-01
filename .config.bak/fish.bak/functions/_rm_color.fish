# remove ANSI color code
function _rm_color
  perl -pe 's/\x1b\[[0-9;]*[mG]//g'
end
