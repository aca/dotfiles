function say
  switch (uname)
  case Linux
    command espeak $argv
  case Darwin
    command say $argv
  end
end
