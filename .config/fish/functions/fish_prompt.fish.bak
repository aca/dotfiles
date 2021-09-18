function fish_prompt
  set_color black
  echo -n '#'
  set_color normal

  # current time
  # set_color --dim --italics
  set_color --dim
  # echo -n ' '(date +%H:%M:%S)
  # echo -n ' '$USER
 
  # user/hostname
  set_color normal
  if [ -n "$SSH_CLIENT" ]
    set -l user (whoami)
    set -l host (hostname)
    echo -n "$user@$host "
  end

  # seperator
  set_color e31e31
  # echo -n ' » '
  # echo -n 'ϟ '
  echo -n '| '
  set_color normal
  set_color --italics
end
