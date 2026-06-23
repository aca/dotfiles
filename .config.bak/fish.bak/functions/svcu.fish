function svcu
  systemctl --user $argv
end

complete -c svcu -w "systemctl --user"
