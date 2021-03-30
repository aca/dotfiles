function fish_prompt

  # current time
  set_color --dim --italics
  echo -n ' '(date +%H:%M:%S)
 
  # user/hostname
  set_color normal
  if [ -n "$SSH_CLIENT" ]
    set -l user (whoami)
    set -l host (hostname)
    echo -n " $user@$host"
  end

  # seperator
  set_color e31e31
  # echo -n ' » '
  # echo -n '$ '
  # echo -n 'ϟ '
  echo -n ' | '
  set_color normal
  # set_color --italics
end
