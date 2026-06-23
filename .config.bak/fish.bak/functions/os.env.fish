# openstack env
function os.env
  set -x | grep 'OS_'
end
