
noti -m "cdf loaded"
function cdf -d 'cd'
  if [ (count $argv) -eq 0 ]
    cd
  else if [ -f $argv[1] ] 
    cd (dirname $argv[1])
  else
    cd $argv[1]
  end
end

# should follow by file arguments
complete -c cdf --arguments -F