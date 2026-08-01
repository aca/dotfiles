function os.clr
  for v in (set -x  | grep OS_ | awk '{print $1}')
    set -e $v
  end
end
