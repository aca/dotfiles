function os.pj -d "fzf openstack project list, set OS_PROJECT_NAME, if arg given, query&set automatically"
  if [ -z $argv ]
    set -l result (openstack project list -f value | fzf)
    echo $result
    [ -z "$result" ] || export OS_PROJECT_NAME=(echo $result | awk '{ print $2 }')
    os.env
  else
    set -l result (openstack project list -f value | fzf --select-1 --exit-0 -q $argv)
    echo $result
    [ -z "$result" ] || export OS_PROJECT_NAME=(echo $result | awk '{ print $2 }')
    os.env
  end
end
