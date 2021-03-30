function df -d 'df -hT | grep -v 'tmpfs' | grep -v boot'
  command df -hT | grep -v 'tmpfs' | grep -v boot
end