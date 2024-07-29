function swp -d "swap two files(rename)"
  if test (count $argv) != 2; echo "argv != 2"; return 1; end
  set -l tmp __tmp__(random)

  # check if file/directory exists
  if ! test -e $argv[1]; and ! test -d $argv[1]; echo "argv[1] not exist"; return 1; end
  if ! test -e $argv[2]; and ! test -d $argv[2]; echo "argv[1] not exist"; return 1; end

  mv -v $argv[1] $tmp
  mv -v $argv[2] $argv[1]
  mv -v $tmp $argv[2]
end
