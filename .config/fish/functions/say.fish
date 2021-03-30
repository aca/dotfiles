function say
  switch (uname)
  case Linux
    command espeak $argv 2>/dev/null 1>/dev/null
  case Darwin
    command say $argv
  end
end
