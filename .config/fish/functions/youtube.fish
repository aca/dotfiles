function youtube
  if [ (count $argv) = 0 ]
    command youtube-dl (pbpaste | sgrep url)
  else
    command youtube-dl $argv
  end
end
